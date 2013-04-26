//
//  CAKeyframeAnimation+CCVAnimations.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CAKeyframeAnimation+CCVAnimations.h"

@implementation CAKeyframeAnimation (CCVAnimations)

+ (instancetype)CCVJumpInAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.2f;
    animation.values = @[@0, @1.25, @0.9, @1];
    
    return animation;
}

@end
