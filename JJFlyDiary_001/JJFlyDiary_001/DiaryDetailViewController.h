//
//  DiaryDetailViewController.h
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-17.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryModel.h"
@interface DiaryDetailViewController : UIViewController
@property (nonatomic,retain)DiaryModel *detailDiaryModel;
@property (nonatomic,assign)BOOL isComeFromeCalendar;
@end
