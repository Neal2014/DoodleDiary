//
//  AppDelegate.m
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-16.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "AppDelegate.h"
//#import "JJFlyDiaryViewController.h"
#import "StartpageViewController.h"
#import "UserGuideViewController.h"
@implementation AppDelegate
@synthesize controller;
- (void)dealloc
{
    [_window release];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
//    JJFlyDiaryViewController *_jjflyDiaryVC = [[JJFlyDiaryViewController alloc] init];
//    UINavigationController *_jjflyDiaryNC = [[UINavigationController alloc] initWithRootViewController:_jjflyDiaryVC];
//    [_jjflyDiaryVC release];
//    self.window.rootViewController = _jjflyDiaryNC;
//    [_jjflyDiaryNC release];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        UserGuideViewController *userGuideViewController = [[UserGuideViewController alloc] init];
        self.window.rootViewController = userGuideViewController;
        [userGuideViewController release];
    }
    else
    {
        //
        NSLog(@"不是第一次启动");
        controller=[[StartpageViewController alloc] initWithNibName:nil bundle:nil];
        [self.window setRootViewController:controller];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
