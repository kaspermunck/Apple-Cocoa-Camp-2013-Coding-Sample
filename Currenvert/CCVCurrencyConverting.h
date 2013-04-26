//
//  CCVCurrencyConverting.h
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CCVCurrencyConvertingCompletionBlock)(BOOL success, CGFloat result);

@protocol CCVCurrencyConverting <NSObject>

@required
- (void)convertAmount:(CGFloat)amount fromCurrency:(NSString *)from toCurrency:(NSString *)to completion:(CCVCurrencyConvertingCompletionBlock)completion;

@end
