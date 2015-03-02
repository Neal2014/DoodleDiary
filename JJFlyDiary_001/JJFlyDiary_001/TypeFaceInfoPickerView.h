//
//  TypeFaceInfoPickerView.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DoodleModel;
@protocol TypeFaceInfoPickerViewDelegate <NSObject>

-(void)changeTypefaceInfoForDoodleDiaryTextView:(DoodleModel *)doodleModel;

@end
@interface TypeFaceInfoPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_fontArray;
    NSArray *_colorArray;
    NSArray *_sizeArray;
}
@property (nonatomic,assign) id<TypeFaceInfoPickerViewDelegate>typefaceDelegate;
@property (nonatomic,retain)UIButton *saveBtn;
@end

