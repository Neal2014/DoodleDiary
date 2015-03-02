//
//  DoodleBgColorPickerView.h
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-19.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DoodleBgColorPickerViewDelegate <NSObject>

- (void)changeDoodleBackgroundColorWith:(UIColor *)color;

@end
@interface DoodleBgColorPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_colorArray;
}
@property (nonatomic,assign)id<DoodleBgColorPickerViewDelegate>bgDelegate;
@end
