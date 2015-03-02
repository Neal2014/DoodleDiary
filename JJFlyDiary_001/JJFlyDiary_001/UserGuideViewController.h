//
//  UserGuideViewController.h
//  JJFlyDiary_001
//
//  Created by 雷江 on 14-11-19.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJFlyDiaryViewController.h"
@interface UserGuideViewController : UIViewController
{
    UINavigationController *nav;
    JJFlyDiaryViewController *rootVC;
}


@property(nonatomic,retain) UINavigationController *nav;
@property(nonatomic,retain) JJFlyDiaryViewController *rootVC;
@end
