//
//  UIView+CCVNibLoading.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "UIView+CCVNibLoading.h"

@implementation UIView (CCVNibLoading)

+ (instancetype)viewFromNib
{
    NSString *className = NSStringFromClass([self class]);
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:className owner:self options:nil];
    
    id view = nil;
    for (id object in bundle) {
        if ([object isKindOfClass:[self class]]) {
            view = object;
        }
    }
    
    NSAssert(view != nil, @"Failed attempt to load %@ from nib", className);
    
    return view;
}

@end
