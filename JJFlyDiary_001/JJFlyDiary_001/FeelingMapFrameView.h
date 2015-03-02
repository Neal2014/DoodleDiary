//
//  FeelingMapFrameView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FeelngMapFrameBlock)(UIImage *feelingImage);
@interface FeelingMapFrameView : UIView

@property (nonatomic,copy)FeelngMapFrameBlock feelingMapFrameBlock;

@end
