//
//  CCVKeyboardView.h
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CCVNibLoading.h"

typedef NS_ENUM(NSInteger, KeyboardButtonType) {
    KeyboardButtonTypeUnknown = -1,
    KeyboardButtonTypeValue,
    KeyboardButtonTypeComma,
    KeyboardButtonTypeBackspace,
    KeyboardButtonTypeClear,
    KeyboardButtonTypeEnter
};

@protocol CCVKeyboardViewDelegate;

@interface CCVKeyboardView : UIView

- (IBAction)tapDigitButton:(id)sender;
- (IBAction)tapCommaButton:(id)sender;
- (IBAction)tapBackspaceButton:(id)sender;
- (IBAction)tapClearButton:(id)sender;
- (IBAction)tapEnterButton:(id)sender;

@property (nonatomic, weak) id<CCVKeyboardViewDelegate> delegate;
@property (nonatomic, readonly) NSInteger value;

@end

@protocol CCVKeyboardViewDelegate <NSObject>

- (void)keyboard:(CCVKeyboardView *)keyboard didTapButtonWithType:(KeyboardButtonType)buttonType;

@end