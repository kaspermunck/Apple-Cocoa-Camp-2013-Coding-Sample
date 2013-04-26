//
//  CCVMainViewController.h
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCVKeyboardView.h"

@protocol CCVCurrencyConverting;

@interface CCVMainViewController : UIViewController <CCVKeyboardViewDelegate>

- (instancetype)initWithCurrencyConverter:(id<CCVCurrencyConverting>)currencyConverter;
- (void)convert;

@property (strong, nonatomic) id<CCVCurrencyConverting> currencyConverter;

@property (weak, nonatomic) IBOutlet UILabel *fromAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAmountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fromCurrencySegControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toCurrencySegControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
