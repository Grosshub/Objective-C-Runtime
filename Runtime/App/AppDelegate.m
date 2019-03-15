//
//  AppDelegate.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "AppDelegate.h"
#import "InfoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    InfoViewController * viewController = [[InfoViewController alloc] init];
    _rootNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:_rootNavigationController];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
