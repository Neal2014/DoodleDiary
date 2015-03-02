//
//  DoodleStrokeInfoPickerView.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DoodleModel;

@protocol DoodleStrokeInfoPickerViewDelegate <NSObject>

-(void)changeDoodleStrokeInfoForDoodleView:(DoodleModel *)doodleModel;

@end
@interface DoodleStrokeInfoPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_colorArray;
    NSArray *_sizeArray;
}
//设置代理
@property (nonatomic,assign) id<DoodleStrokeInfoPickerViewDelegate>doodleStrokeDelegate;
@property (nonatomic,retain)UIButton *saveBtn;
@end
