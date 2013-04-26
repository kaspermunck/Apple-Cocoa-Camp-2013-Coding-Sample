//
//  CCVGoogleCurrencyConverter.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVAppSpotCurrencyConverter.h"

@interface CCVAppSpotCurrencyConverter()
{
    CCVCurrencyConvertingCompletionBlock _completionBlock;
    NSMutableDictionary *_cachedCurrencyRates;
    NSString *_key;
}
@end

@implementation CCVAppSpotCurrencyConverter

- (instancetype)init {
    self = [super init];
    if (self) {
        _cachedCurrencyRates = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    return self;
}

- (void)didReceiveData:(NSData *)data {
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSString *result = [dictionary objectForKey:@"amount"];
    NSString *rate = [dictionary objectForKey:@"rate"];
    [_cachedCurrencyRates setObject:[NSNumber numberWithFloat:rate.floatValue] forKey:_key];
    
    if (error) {
        if (_completionBlock != nil) {
            _completionBlock(NO, -1);
        }
    } else {
        if (_completionBlock != nil) {
            _completionBlock(YES, result.floatValue);
        }
    }
}

#pragma mark -
#pragma mark CCVCurrencyConverting

- (void)convertAmount:(CGFloat)amount fromCurrency:(NSString *)from toCurrency:(NSString *)to completion:(CCVCurrencyConvertingCompletionBlock)completion {
    _key = [NSString stringWithFormat:@"%@%@", from, to];
    NSNumber *rate = [_cachedCurrencyRates objectForKey:_key];
    if (rate != nil)
    {
        completion(YES, amount * rate.floatValue);
        return;
    }
    _completionBlock = completion;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    dispatch_async(queue, ^{
        // 5 decimals is an API constraint
        NSString *endpoint = [NSString stringWithFormat:@"http://currency-api.appspot.com/api/%@/%@.json?key=95745576044da46cea9f515430952d4f938298dd&amount=%.05f", from, to, amount];
        NSURL *url = [NSURL URLWithString:endpoint];
        NSData *jsonData = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(didReceiveData:) withObject:jsonData waitUntilDone:YES];
    });
}

@end
