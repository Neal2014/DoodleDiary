//
//  SubFaceFrameScrollView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-12.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SubFaceFrameScrollViewDelegate <NSObject>
- (void)changeFacePageControlCurrentPageWithContentOffset:(NSInteger )currentPage;
-(void)addElementToCustomKeyView:(id)object;
@end
@interface SubFaceFrameScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,retain)NSMutableArray *dataSourceArray;
@property (nonatomic,assign)id<SubFaceFrameScrollViewDelegate>changPageDelegate;

//根据数据重新加载子视图表情
-(void)setSubviewsInfoWithDataSourceArray:(NSArray *)dataSourceArray;

@end

