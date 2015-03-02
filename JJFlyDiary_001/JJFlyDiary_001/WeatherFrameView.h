//
//  WeatherFrameView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WeatherFrameBlock)(UIImage *weatherImage);
@interface WeatherFrameView : UIView

@property (nonatomic,copy)WeatherFrameBlock weatherFrameBlock;

@end
