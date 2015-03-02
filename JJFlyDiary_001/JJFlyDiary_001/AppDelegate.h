//
//  AppDelegate.h
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-16.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StartpageViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
    StartpageViewController *controller;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)StartpageViewController *controller;

@end
