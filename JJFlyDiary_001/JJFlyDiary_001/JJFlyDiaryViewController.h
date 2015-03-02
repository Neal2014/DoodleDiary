//
//  JJFlyDiaryViewController.h
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-16.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PAPasscodeViewController.h"
//#import "PAPasscodeViewController2.h"
//#import "PAPViewController.h"
@interface JJFlyDiaryViewController : UIViewController<PAPasscodeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
//显示密码
@property(nonatomic,retain)UILabel *passwordLabel;
@property (assign) BOOL simple;
@end
