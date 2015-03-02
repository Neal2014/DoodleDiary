//
//  EdtingDiaryTextView.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderInfoView.h"
#import "TypefacePickerView.h"
#import "CustomKeyView.h"
#import "InputAccessoryView.h"
@class EdtingDiaryViewController;
@interface EdtingDiaryTextView : UITextView<TypefacePickerViewDelegate,CustomKeyViewDelegate,InputAccessoryViewDelegate,UITextViewDelegate>
{
    NSMutableArray *_exclusionPathsArray;
    NSMutableArray *_imageViewRectArray;
    NSMutableArray *_imageArray;
    NSMutableArray *_webViewRectArray;
    NSMutableArray *_gifDataArray;
    id _currentBottomObject;
    NSInteger _lpGestureImageIndex;
}
@property (nonatomic,retain) NSMutableArray *imageArray;
@property (nonatomic,retain) NSMutableArray *imageViewRectArray;
@property (nonatomic,retain) NSMutableArray *imageViewArray;;
@end
