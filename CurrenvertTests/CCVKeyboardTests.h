//
//  CCVKeyboardTests.h
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "CCVKeyboardView.h"
#import "UIView+CCVNibLoading.h"

@interface CCVKeyboardTests : SenTestCase <CCVKeyboardViewDelegate>
{
    KeyboardButtonType _callbackButtonType;
    CCVKeyboardView *_keyboard;
}
@end
