//
//  InputAccessoryView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypefacePickerView.h"
#import "CustomKeyView.h"
@protocol InputAccessoryViewDelegate <NSObject>
@optional
-(void)changeEdtingDiaryInputView:(UIView *)inputView;
-(void)addPhotofromPhoneToEdtingDiary:(UIImage *)photo;
@end

@interface InputAccessoryView : UIView
{
    BOOL _typefacePVState;
    BOOL _faceMapKBVState;
    UIView * _tmpInputView;
    UIButton *_typefaceBtn;
    UIButton *_faceMapBtn;
    UIButton *_returnKeyboardBtn;
}
@property (nonatomic,retain) TypefacePickerView         *typefacePV;
@property (nonatomic,retain) CustomKeyView              *faceMapKBV;
@property (nonatomic,assign) id<InputAccessoryViewDelegate> delegate;
@property (nonatomic,retain) UIButton *choosePhotoBtn;
//方便外面调用
-(void)didClickedReturnKeyboardBtnAction:(UIButton *)returnKeyboardBtn;

@end

