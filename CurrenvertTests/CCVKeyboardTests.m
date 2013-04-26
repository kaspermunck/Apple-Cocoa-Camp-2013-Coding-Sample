//
//  CCVKeyboardTests.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVKeyboardTests.h"

@implementation CCVKeyboardTests

- (void)setUp {
    _keyboard = [CCVKeyboardView viewFromNib];
    _keyboard.delegate = self;
    _callbackButtonType = KeyboardButtonTypeUnknown;
}

- (void)testDigitButtonCallback {
    [_keyboard tapDigitButton:nil];
    STAssertTrue(_callbackButtonType == KeyboardButtonTypeValue, nil);
}

- (void)testCommaButtonCallback {
    [_keyboard tapCommaButton:nil];
    STAssertTrue(_callbackButtonType == KeyboardButtonTypeComma, nil);
}

- (void)testBackspaceButtonCallback {
    [_keyboard tapBackspaceButton:nil];
    STAssertTrue(_callbackButtonType == KeyboardButtonTypeBackspace, nil);
}

- (void)testClearButtonCallback {
    [_keyboard tapClearButton:nil];
    STAssertTrue(_callbackButtonType == KeyboardButtonTypeClear, nil);
}

- (void)testEnterButtonCallback {
    [_keyboard tapEnterButton:nil];
    STAssertTrue(_callbackButtonType == KeyboardButtonTypeEnter, nil);
}

#pragma mark -
#pragma mark CCVKeyboardViewDelegate

- (void)keyboard:(CCVKeyboardView *)keyboard didTapButtonWithType:(KeyboardButtonType)buttonType {
    _callbackButtonType = buttonType;
}

@end
