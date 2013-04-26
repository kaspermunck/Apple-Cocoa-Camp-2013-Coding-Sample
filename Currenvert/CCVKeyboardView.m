//
//  CCVKeyboardView.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVKeyboardView.h"
#import "CAKeyframeAnimation+CCVAnimations.h"

@interface CCVKeyboardView()

@property (nonatomic, readwrite) NSInteger value;

@end

@implementation CCVKeyboardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [subview.layer addAnimation:[CAKeyframeAnimation CCVJumpInAnimation] forKey:nil];
        }
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)tapDigitButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboard:didTapButtonWithType:)]) {
        self.value = ((UIButton *)sender).tag;
        [self.delegate keyboard:self didTapButtonWithType:KeyboardButtonTypeValue];
    }
}

- (IBAction)tapCommaButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboard:didTapButtonWithType:)]) {
        [self.delegate keyboard:self didTapButtonWithType:KeyboardButtonTypeComma];
    }
}

- (IBAction)tapBackspaceButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboard:didTapButtonWithType:)]) {
        [self.delegate keyboard:self didTapButtonWithType:KeyboardButtonTypeBackspace];
    }
}

- (IBAction)tapClearButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboard:didTapButtonWithType:)]) {
        [self.delegate keyboard:self didTapButtonWithType:KeyboardButtonTypeClear];
    }
}

- (IBAction)tapEnterButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(keyboard:didTapButtonWithType:)]) {
        [self.delegate keyboard:self didTapButtonWithType:KeyboardButtonTypeEnter];
    }
}

@end
