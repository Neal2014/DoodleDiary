//
//  TypefacePickerView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TypefaceModel;
@protocol TypefacePickerViewDelegate <NSObject>

-(void)changeTypefaceInfoForEdtingDiaryTextView:(TypefaceModel *)typefaceModel;

@end
@interface TypefacePickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_fontArray;
    NSArray *_colorArray;
    NSArray *_sizeArray;
}
//设置代理
@property (nonatomic,assign) id<TypefacePickerViewDelegate>typefaceDelegate;
@end
