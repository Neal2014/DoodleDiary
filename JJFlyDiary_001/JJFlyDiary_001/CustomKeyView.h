//
//  CustomKeyView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubFaceFrameScrollView.h"
@protocol CustomKeyViewDelegate <NSObject>

-(void)addElementToEdtingDiaryTextView:(id)object;

@end
@interface CustomKeyView : UIView<UIScrollViewDelegate,SubFaceFrameScrollViewDelegate>
{
   
    UIScrollView *_faceFrameScrollView;
    SubFaceFrameScrollView *_subFrameScrollView1;
    SubFaceFrameScrollView *_subFrameScrollView2;
    SubFaceFrameScrollView *_subFrameScrollView3;
    UIView *_selectFaceView;
    UIPageControl *_facePageControl;
    
    NSMutableArray *_faceSourceArray;
    
    NSMutableArray *_face1Array;
    NSMutableArray *_face2Array;
    NSMutableArray *_face3Array;
    NSMutableArray *_face4Array;
    NSMutableArray *_face5Array;
    NSMutableArray *_face6Array;
    NSMutableArray *_face7Array;
    NSMutableArray *_face8Array;
}
@property (nonatomic,assign) id<CustomKeyViewDelegate>delegate;
@property (nonatomic,retain)UIScrollView *faceScrollView;
@property (nonatomic,retain)UIView *selectFaceBtnStateView;
@end
