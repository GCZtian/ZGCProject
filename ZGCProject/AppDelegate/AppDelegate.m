//
//  AppDelegate.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/6.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "FirstLaunchesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc
{
    self.window = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSUserDefaults *firstLaunch = [NSUserDefaults standardUserDefaults];
    if (![firstLaunch objectForKey:@"first"]) {
        [firstLaunch setBool:YES forKey:@"first"];
        [firstLaunch synchronize];
        
        FirstLaunchesViewController *firstVC = [[FirstLaunchesViewController alloc] init];
        self.window.rootViewController = firstVC;
        [firstVC release];
    } else  {
        NSDictionary *dictionary = [firstLaunch dictionaryRepresentation];
        for (NSString *key in [dictionary allKeys]) {
            [firstLaunch removeObjectForKey:key];
            [firstLaunch synchronize];
            
        }
            //通过NSUserDefaults,将写入到plist文件中的文件删除
        RootViewController *rootVC = [[RootViewController alloc] init];
        self.window.rootViewController = rootVC;
        [rootVC release];
        [firstLaunch setBool:YES forKey:@"first"];
        [firstLaunch synchronize];
        
    }    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
