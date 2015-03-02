//
//  LetterPaperFrameView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "LetterPaperFrameView.h"

@implementation LetterPaperFrameView

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
    UIScrollView *letterPaperScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    letterPaperScrollView.pagingEnabled = YES;
    letterPaperScrollView.contentSize = CGSizeMake(((40 - 1) / 10 + 1)* 320, 150);
    //循环放背景图
    for (int i = 1; i < 23; i++) {
        UIImageView *letterPaperImageView = [[UIImageView alloc] init];
        letterPaperImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"letterPage%d.jpg",i]];
        //配置坐标
        letterPaperImageView.frame = CGRectMake((i -1)%5*60 + 12 + ((i-1)/10)*320, ((i -1)%10) / 5 * 70 + 15, 50, 50);
        //加轻拍手势--响应点击选中事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGetureAction:)];
        [letterPaperImageView addGestureRecognizer:tapGesture];
        [tapGesture release];
        letterPaperImageView.userInteractionEnabled = YES;
        [letterPaperScrollView addSubview:letterPaperImageView];
        [letterPaperImageView release];
    }
    [self addSubview:letterPaperScrollView];
    [letterPaperScrollView release];
}

- (void)tapGetureAction:(UITapGestureRecognizer *)tapGesture
{
    _letterPaperFrameBlock(((UIImageView *)tapGesture.view).image);
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
