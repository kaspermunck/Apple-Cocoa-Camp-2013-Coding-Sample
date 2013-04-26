//
//  CCVCurrencyConverterStub.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVCurrencyConverterStub.h"

@implementation CCVCurrencyConverterStub 

- (void)convertAmount:(CGFloat)amount fromCurrency:(NSString *)from toCurrency:(NSString *)to completion:(CCVCurrencyConvertingCompletionBlock)completion {
    completion(YES, self.conversionResult);
}

@end
