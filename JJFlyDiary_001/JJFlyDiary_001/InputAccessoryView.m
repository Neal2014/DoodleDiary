//
//  InputAccessoryView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "InputAccessoryView.h"

@implementation InputAccessoryView
-(void)dealloc
{
    [_typefacePV release];
    [_faceMapKBV release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        _typefacePVState      = NO;
        _faceMapKBVState      = NO;
        [self addSubviews];
        
        _tmpInputView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return self;
}
-(void)addSubviews
{
    //字体按钮
    _typefaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _typefaceBtn.frame = CGRectMake(10, 0, 60, 30);
    [_typefaceBtn setTitle:@"字体" forState:UIControlStateNormal];
    [_typefaceBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_typefaceBtn addTarget:self action:@selector(didClickedTypefaceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_typefaceBtn];
    
    //表情按钮
    _faceMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _faceMapBtn.frame = CGRectMake(90, 0, 60, 30);
    [_faceMapBtn setTitle:@"表情" forState:UIControlStateNormal];
    [_faceMapBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_faceMapBtn addTarget:self action:@selector(didClickedFaceMapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_faceMapBtn];
    
    //照片按钮
    _choosePhotoBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    _choosePhotoBtn.frame = CGRectMake(170, 0, 60, 30);
    [_choosePhotoBtn setTitle:@"照片" forState:UIControlStateNormal];
    [_choosePhotoBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self addSubview:_choosePhotoBtn];
    
    //退出键盘按钮
    _returnKeyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnKeyboardBtn.frame = CGRectMake(250, 0, 60, 30);
    [_returnKeyboardBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_returnKeyboardBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_returnKeyboardBtn addTarget:self action:@selector(didClickedReturnKeyboardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_returnKeyboardBtn];

}

-(void)didClickedTypefaceBtnAction:(UIButton *)typefaceBtn
{
    [self cancleOhterButtonActionWhenTouchDown:typefaceBtn];
    if (_typefacePVState == NO) {
        _typefacePV.frame = CGRectMake(0, kMainScreenHeight - 216 - self.frame.size.height,kMainScreenWidth , 216 );
        [_delegate changeEdtingDiaryInputView:_tmpInputView];
        _typefacePVState = YES;
    }else{
        _typefacePV.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth , 216 );
        [_delegate changeEdtingDiaryInputView:nil];
        _typefacePV.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth , 216 );
        _typefacePVState = NO;
    }

}
-(void)didClickedFaceMapBtnAction:(UIButton *)faceMapBtn
{
    [self cancleOhterButtonActionWhenTouchDown:faceMapBtn];
    if (_faceMapKBVState == NO) {
        _faceMapKBV.frame = CGRectMake(0, kMainScreenHeight - 200 - self.frame.size.height, kMainScreenWidth , 200 );
        [_delegate changeEdtingDiaryInputView:_tmpInputView ];
        _faceMapKBVState = YES;
    }else{
        [_delegate changeEdtingDiaryInputView:nil];
        _faceMapKBV.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth , 200 );
        _faceMapKBVState = NO;
    }
}

-(void)didClickedReturnKeyboardBtnAction:(UIButton *)returnKeyboardBtn
{
    [self cancleOhterButtonActionWhenTouchDown:returnKeyboardBtn];
    //收起键盘并且隐藏所有附加视图
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    
}
#pragma mark ---封装在其他按钮点击状态下直接点击别的按钮取消其他所有按钮效果的方法
-(void)cancleOhterButtonActionWhenTouchDown:(UIButton *)currentButton
{
    if (currentButton != _typefaceBtn && _typefacePVState  == YES) {
        _typefacePV.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth , 216 );
        _typefacePVState  = NO;
        [_delegate changeEdtingDiaryInputView:nil];
    }
    if (currentButton != _faceMapBtn  && _faceMapKBVState  == YES){
        _faceMapKBV.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 200);
        _faceMapKBVState  = NO;
        [_delegate changeEdtingDiaryInputView:nil];
        
    }
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
