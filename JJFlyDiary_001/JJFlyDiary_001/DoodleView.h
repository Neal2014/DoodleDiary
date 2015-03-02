//
//  DoodleView.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoodleStrokeInfoPickerView.h"
typedef void (^MyBlock)();
@interface DoodleView : UIView<DoodleStrokeInfoPickerViewDelegate>
{
    
    CGFloat _strokeLineWidth;
}
@property (nonatomic,retain) UIButton *undoButto;
@property (assign, nonatomic) CGMutablePathRef path;
@property (strong, nonatomic) NSMutableArray *pathArray;
@property (assign, nonatomic) BOOL isHavePath;
@property (retain,nonatomic) UIColor *strokeLineColor;
@property (nonatomic,copy)MyBlock myBlock;
@end
