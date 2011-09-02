//
//  AppDelegate.m
//  GHPieChartProgressViewSample
//
//  Created by Oliver Letterer on 02.09.11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "AppDelegate.h"
#import "SampleViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[SampleViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
