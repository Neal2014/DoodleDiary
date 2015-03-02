//
//  DoodleScrollView.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeFaceInfoPickerView.h"
typedef void (^MyBlock)();
@interface DoodleScrollView : UIScrollView<UITextViewDelegate,TypeFaceInfoPickerViewDelegate>
{
    BOOL _isInPuting;
    BOOL _isEdge;
    
}
@property (nonatomic,assign)BOOL inputStae;
@property (nonatomic,copy)MyBlock myBlock;
@property (nonatomic,retain)UIFont *fontOftextView;
@property (nonatomic,retain)UIColor *textColorOfTextView;
@end
