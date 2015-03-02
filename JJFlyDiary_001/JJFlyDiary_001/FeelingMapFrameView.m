//
//  FeelingMapFrameView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "FeelingMapFrameView.h"

@implementation FeelingMapFrameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    for (int i = 1; i < 11; i++) {
        UIImageView *feelingImageView = [[UIImageView alloc] init];
        feelingImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"diary-mood%d",i]];
        //配置坐标
        feelingImageView.frame = CGRectMake((i - 1) % 5 * 60 + 12 , (i -1) / 5 * 70 + 15, 50, 50);
        //加轻拍手势--响应点击选中事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGetureAction:)];
        [feelingImageView addGestureRecognizer:tapGesture];
        [tapGesture release];
        feelingImageView.userInteractionEnabled = YES;
        [self addSubview:feelingImageView];
        [feelingImageView release];
    }
}
//tap点击方法
- (void)tapGetureAction:(UITapGestureRecognizer *)tapGesture
{
    _feelingMapFrameBlock(((UIImageView *)tapGesture.view).image);
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
