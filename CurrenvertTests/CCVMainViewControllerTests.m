//
//  CCVMainViewControllerTests.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVMainViewControllerTests.h"
#import "CCVCurrencyConverterStub.h"

@implementation CCVMainViewControllerTests

- (void)setUp {
    _viewController = [[CCVMainViewController alloc] initWithCurrencyConverter:nil];
}

- (void)testIBOutletConnections {
    [_viewController view];
    
    STAssertNotNil(_viewController.fromAmountLabel, nil);
    STAssertNotNil(_viewController.toAmountLabel, nil);
    STAssertNotNil(_viewController.fromCurrencySegControl, nil);
    STAssertNotNil(_viewController.toCurrencySegControl, nil);
    STAssertNotNil(_viewController.activityIndicator, nil);
}

- (void)testAssignsConversionResultToLabel {
    [_viewController view];
    id converterStub = [self stubWithConversionResult:10.f];
    _viewController.currencyConverter = converterStub;
    
    [_viewController.toCurrencySegControl setSelectedSegmentIndex:0]; // DKK
    [_viewController convert];
    
    STAssertEqualObjects(@"DKK10.00", _viewController.toAmountLabel.text, nil);
}

- (void)testOnlyOneCommaAllowedInAmount {
    [_viewController view];
    [_viewController.fromCurrencySegControl setSelectedSegmentIndex:0]; // DKK
    _viewController.fromAmountLabel.text = @"150";
    
    [_viewController keyboard:nil didTapButtonWithType:KeyboardButtonTypeComma];
    STAssertEqualObjects(@"DKK150.", _viewController.fromAmountLabel.text, nil);
    
    [_viewController keyboard:nil didTapButtonWithType:KeyboardButtonTypeComma];
    STAssertEqualObjects(@"DKK150.", _viewController.fromAmountLabel.text, nil);
}

#pragma mark -
#pragma mark Helpers

- (CCVCurrencyConverterStub *)stubWithConversionResult:(CGFloat)result {
    CCVCurrencyConverterStub *converterStub = [[CCVCurrencyConverterStub alloc] init];
    converterStub.conversionResult = result;
    
    return converterStub;
}

@end
