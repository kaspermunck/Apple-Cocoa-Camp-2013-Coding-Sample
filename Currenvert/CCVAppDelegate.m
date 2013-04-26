//
//  CCVAppDelegate.m
//  Currenvert
//
//  Created by Kasper Munck on 4/5/13.
//  Copyright (c) 2013 KAPPS. All rights reserved.
//

#import "CCVAppDelegate.h"
#import "CCVMainViewController.h"
#import "CCVAppSpotCurrencyConverter.h"

@implementation CCVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CCVAppSpotCurrencyConverter *currencyConverter = [[CCVAppSpotCurrencyConverter alloc] init];
    self.viewController = [[CCVMainViewController alloc] initWithCurrencyConverter:currencyConverter];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
