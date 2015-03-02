//
//  LetterPaperFrameView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LetterPaperFrameViewBlock)(UIImage *letterPaperImage);
@interface LetterPaperFrameView : UIView

@property (nonatomic,copy)LetterPaperFrameViewBlock letterPaperFrameBlock;

@end
