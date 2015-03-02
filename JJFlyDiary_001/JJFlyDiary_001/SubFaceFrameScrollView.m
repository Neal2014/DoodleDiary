//
//  SubFaceFrameScrollView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-12.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "SubFaceFrameScrollView.h"
#import "FaceButton.h"
@implementation SubFaceFrameScrollView
-(void)dealloc
{
    [_dataSourceArray release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator =NO;
        self.delegate = self;
        _dataSourceArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}
//根据数据加载视图
- (void)setSubviewsInfoWithDataSourceArray:(NSArray *)dataSourceArray
{
    //先替换本身数据
    [_dataSourceArray removeAllObjects];
    [_dataSourceArray addObjectsFromArray:dataSourceArray];
    
    //重新设定contentSize
    self.contentSize = CGSizeMake(((_dataSourceArray.count - 1)/ 21 + 1)* 320, 160);
    //设置显示点
    self.contentOffset = CGPointMake(0, 0);
    //移除之前所有的表情子视图
    for(UIView *mylabelview in self.subviews)
    {
        if ([mylabelview isKindOfClass:[UIButton class]]) {
            [mylabelview removeFromSuperview];
        }
    }
    //加新视图
    for (int i = 0; i<_dataSourceArray.count; i++) {
        FaceButton *faceButton = [FaceButton buttonWithType:UIButtonTypeCustom];
        NSString *str = _dataSourceArray[i];
        [faceButton setTitle:str forState:UIControlStateNormal];
        [faceButton addTarget:self action:@selector(didClickedFaceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        //计算每一个表情按钮的坐标和在哪一屏
        faceButton.frame = CGRectMake((i%7)*45 + 5 +(i/21*320),((i%21)/7)*45 +20, 40, 40);
        faceButton.titleLabel.font = [UIFont systemFontOfSize:30];
        [self addSubview:faceButton];
    }
}
#pragma mark  ----实现UIScrollViewDelegate代理方法-----
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_changPageDelegate changeFacePageControlCurrentPageWithContentOffset:self.contentOffset.x / 320];
}
#pragma mark ---- 实现点击方法 -----
- (void)didClickedFaceButtonAction:(UIButton *)faceBtn {
    NSString *senderStr = faceBtn.titleLabel.text;
    [_changPageDelegate addElementToCustomKeyView:senderStr];
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
