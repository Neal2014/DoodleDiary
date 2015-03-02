//
//  ExchaneSateView.m
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "ExchaneSateView.h"
@implementation ExchaneSateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self adSubviews];
    }
    return self;
}
- (void)adSubviews
{

    
    self.exchangeState = [[RSCameraRotator alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
    self.exchangeState.transform = CGAffineTransformRotate(self.exchangeState.transform, M_PI / 2);
    _exchangeState.center = CGPointMake(25, 35);
    self.exchangeState.offColor = [UIColor colorWithRed:0.587 green:1.000 blue:0.244 alpha:1.000];
    self.exchangeState.onColorLight = [UIColor colorWithRed:1.000 green:0.652 blue:0.188 alpha:1.000];
    self.exchangeState.onColorDark = [UIColor colorWithRed:0.383 green:0.671 blue:1.000 alpha:1.000];
    [self addSubview:self.exchangeState];
    
    
    
    _chooseInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _chooseInfoBtn.layer.masksToBounds = YES;
    _chooseInfoBtn.layer.cornerRadius = 6;
    _chooseInfoBtn.layer.borderWidth = 2;
    _chooseInfoBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _chooseInfoBtn.clipsToBounds = YES;
    _chooseInfoBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _chooseInfoBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _chooseInfoBtn.frame = CGRectMake(0, 75, 45, 30);
    [_chooseInfoBtn setTitle:@"画笔" forState:UIControlStateNormal];
    [_chooseInfoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_chooseInfoBtn];
    
    
    
    _addPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _addPhotoBtn.layer.masksToBounds = YES;
    _addPhotoBtn.layer.cornerRadius = 6;
    _addPhotoBtn.layer.borderWidth = 2;
    _addPhotoBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _addPhotoBtn.clipsToBounds = YES;
    _addPhotoBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _addPhotoBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _addPhotoBtn.frame = CGRectMake(0, 120, 45, 30);
    [_addPhotoBtn setTitle:@"加图" forState:UIControlStateNormal];
    [_addPhotoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_addPhotoBtn];
    
    _changeBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _changeBgBtn.layer.masksToBounds = YES;
    _changeBgBtn.layer.cornerRadius = 6;
    _changeBgBtn.layer.borderWidth = 2;
    _changeBgBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _changeBgBtn.clipsToBounds = YES;
    _changeBgBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _changeBgBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _changeBgBtn.frame = CGRectMake(0, 170, 45, 30);
    [_changeBgBtn setTitle:@"背景" forState:UIControlStateNormal];
    [_changeBgBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_changeBgBtn];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 6;
    _saveBtn.layer.borderWidth = 2;
    _saveBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _saveBtn.clipsToBounds = YES;
    _saveBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _saveBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _saveBtn.frame = CGRectMake(0, 220, 45, 30);
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_saveBtn];
    
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 6;
    _cancelBtn.layer.borderWidth = 2;
    _cancelBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _cancelBtn.clipsToBounds = YES;
    _cancelBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _cancelBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _cancelBtn.frame = CGRectMake(0, 270, 45, 30);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
    
    _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _hideBtn.layer.masksToBounds = YES;
    _hideBtn.layer.cornerRadius = 6;
    _hideBtn.layer.borderWidth = 2;
    _hideBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _hideBtn.clipsToBounds = YES;
    _hideBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _hideBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _hideBtn.frame = CGRectMake(0, 320, 45, 30);
    [_hideBtn setTitle:@"隐藏" forState:UIControlStateNormal];
    [_hideBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_hideBtn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
