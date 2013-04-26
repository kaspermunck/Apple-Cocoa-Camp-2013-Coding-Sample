//
//  CCVMainViewController.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVMainViewController.h"
#import "CCVCurrencyConverting.h"
#import "CAKeyframeAnimation+CCVAnimations.h"

@interface CCVMainViewController () <CCVKeyboardViewDelegate>
{
    NSArray *_currencies;
    NSMutableString *_mutableNumber;
    NSNumberFormatter *_numberFormatter;
}
@property (strong, nonatomic) CCVKeyboardView *keyboard;
@end

@implementation CCVMainViewController

- (instancetype)initWithCurrencyConverter:(id<CCVCurrencyConverting>)currencyConverter {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.currencyConverter = currencyConverter;
        _currencies = @[@"DKK", @"USD", @"GBP", @"EUR"];
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_numberFormatter setMinimumFractionDigits:2];
        [_numberFormatter setMaximumFractionDigits:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-568h"]];
    
    [self addKeyboard];
    [self addAnimations];
    [self insertCurrenciesInSegControls];
    [self eraseAll];
    
    [self.fromCurrencySegControl addTarget:self action:@selector(fromCurrencySegControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view bringSubviewToFront:self.activityIndicator];
}

#pragma mark -
#pragma mark Private

- (void)startLoading {
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.25f animations:^{
        self.fromCurrencySegControl.alpha = 0.25f;
        self.toCurrencySegControl.alpha = 0.25f;
        self.keyboard.alpha = 0.25f;
        self.fromAmountLabel.alpha = 0.25f;
        self.toAmountLabel.alpha = 0.25f;
        self.activityIndicator.alpha = 1.f;
    }];
}

- (void)stopLoading {
    self.view.userInteractionEnabled = YES;
    [UIView animateWithDuration:.25f animations:^{
        self.fromCurrencySegControl.alpha = 1.f;
        self.toCurrencySegControl.alpha = 1.f;
        self.keyboard.alpha = 1.f;
        self.fromAmountLabel.alpha = 1.f;
        self.toAmountLabel.alpha = 1.f;
        self.activityIndicator.alpha = 0;
    }];
}

- (void)fromCurrencySegControlDidChangeValue:(id)sender {
    [self updateLabel];
}

- (void)insertCurrenciesInSegControls {
    [self.fromCurrencySegControl removeAllSegments];
    [self.toCurrencySegControl removeAllSegments];
    
    for (int i = 0; i < _currencies.count; i++)
    {
        [self.fromCurrencySegControl insertSegmentWithTitle:[_currencies objectAtIndex:i] atIndex:i animated:NO];
        [self.toCurrencySegControl insertSegmentWithTitle:[_currencies objectAtIndex:i] atIndex:i animated:NO];
    }
    
    [self.fromCurrencySegControl setSelectedSegmentIndex:1];
    [self.toCurrencySegControl setSelectedSegmentIndex:0];
}

- (void)addKeyboard {
    self.keyboard = [CCVKeyboardView viewFromNib];
    self.keyboard.delegate = self;
    [self.view addSubview:self.keyboard];
    self.keyboard.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.keyboard attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeLeft
                                                         multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.keyboard attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeBottom
                                                         multiplier:1 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.keyboard attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeWidth
                                                         multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.keyboard attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual
                                                             toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1 constant:300]];
}

- (void)addAnimations {
    [self.fromCurrencySegControl.layer addAnimation:[CAKeyframeAnimation CCVJumpInAnimation] forKey:nil];
    [self.toCurrencySegControl.layer addAnimation:[CAKeyframeAnimation CCVJumpInAnimation] forKey:nil];
    [self.fromAmountLabel.layer addAnimation:[CAKeyframeAnimation CCVJumpInAnimation] forKey:nil];
    [self.toAmountLabel.layer addAnimation:[CAKeyframeAnimation CCVJumpInAnimation] forKey:nil];
}

- (NSString *)currencyCodeFromSegControl:(UISegmentedControl *)segControl {
    return [_currencies objectAtIndex:segControl.selectedSegmentIndex];
}

- (void)updateLabel {
    NSString *amount = [NSString stringWithFormat:@"%.05f", _mutableNumber.floatValue];
    [_numberFormatter setCurrencyCode:[self currencyCodeFromSegControl:_fromCurrencySegControl]];
    self.fromAmountLabel.text = [_numberFormatter stringFromNumber:[NSNumber numberWithFloat:amount.floatValue]];
}

- (void)appendDigit:(NSInteger)digit {
    [_mutableNumber appendFormat:@"%i", digit];
    [self updateLabel];
}

- (void)appendComma {
    if ([_mutableNumber rangeOfString:@"." options:0].length != 0) return;
    
    [_mutableNumber appendFormat:@"."];
    [self updateLabel];
}

- (void)eraseOne {
    if (_mutableNumber.length > 1) {
        [_mutableNumber deleteCharactersInRange:NSMakeRange(_mutableNumber.length-1, 1)];
        [self updateLabel];
    } else {
        [self eraseAll];
    }
}

- (void)eraseAll {
    _mutableNumber = @"".mutableCopy;
    [self updateLabel];
}

- (void)convert {
    NSString *fromCurrency = [self currencyCodeFromSegControl:_fromCurrencySegControl];
    NSString *toCurrency = [self currencyCodeFromSegControl:_toCurrencySegControl];
    
    if ([fromCurrency isEqualToString:toCurrency]) {
        [[[UIAlertView alloc] initWithTitle:@"Dear Sir"
                                    message:[NSString stringWithFormat:@"Does converting from %@ to %@ make sense?", fromCurrency, toCurrency]
                                   delegate:nil
                          cancelButtonTitle:@"I know, sorry"
                           otherButtonTitles:nil] show];
        return;
    }
    
    [self startLoading];
    CGFloat amount = _mutableNumber.floatValue;
    [self.currencyConverter convertAmount:amount
                             fromCurrency:fromCurrency
                               toCurrency:toCurrency
                               completion:^(BOOL success, CGFloat result) {
                                   
                                   [_numberFormatter setCurrencyCode:[self currencyCodeFromSegControl:_toCurrencySegControl]];
                                   NSNumber *number = [NSNumber numberWithFloat:result];
                                   self.toAmountLabel.text = [_numberFormatter stringFromNumber:number];
                                   [self stopLoading];
    }];
}

#pragma mark -
#pragma mark CCVKeyboardViewDelegate

- (void)keyboard:(CCVKeyboardView *)keyboard didTapButtonWithType:(KeyboardButtonType)buttonType
{
    switch (buttonType) {
        case KeyboardButtonTypeValue:
            [self appendDigit:keyboard.value];
            break;
            
        case KeyboardButtonTypeComma:
            [self appendComma];
            break;
            
        case KeyboardButtonTypeBackspace:
            [self eraseOne];
            break;
            
        case KeyboardButtonTypeClear:
            [self eraseAll];
            break;
            
        case KeyboardButtonTypeEnter:
            [self convert];
            break;
            
        default:
            break;
    }
}

@end
