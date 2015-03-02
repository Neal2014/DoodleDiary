//
//  ExchaneSateView.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSCameraRotator.h"
@interface ExchaneSateView : UIView
@property (nonatomic,retain) RSCameraRotator *exchangeState;//切换到涂鸦、写字状态按钮
@property (nonatomic,retain) UIButton *chooseInfoBtn;// 选择画笔、字体属性按钮
@property (nonatomic,retain) UIButton *addPhotoBtn;//选择照片按钮
@property (nonatomic,retain) UIButton *changeBgBtn;//换背景色按钮
@property (nonatomic,retain) UIButton *saveBtn; //保存按钮
@property (nonatomic,retain) UIButton *cancelBtn; //取消按钮
@property (nonatomic,retain) UIButton *hideBtn;//隐藏按钮
@end
