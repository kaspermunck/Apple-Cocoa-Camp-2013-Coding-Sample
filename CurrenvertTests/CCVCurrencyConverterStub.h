//
//  CCVCurrencyConverterStub.h
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCVCurrencyConverting.h"

@interface CCVCurrencyConverterStub : NSObject <CCVCurrencyConverting>

@property (readwrite) CGFloat conversionResult;

@end
