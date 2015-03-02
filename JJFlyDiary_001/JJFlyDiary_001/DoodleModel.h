//
//  DoodleModel.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoodleModel : NSObject
//画笔用
@property (nonatomic,retain) UIColor *doodleStrokeColor;
@property (nonatomic,assign) CGFloat doodleStrokeWidth;
//字体用
@property (nonatomic,retain) UIColor *typefaceColor;
@property (nonatomic,retain) UIFont  *typefaceFont;

+ (DoodleModel *)shareDoodleDiaryModel;
@end
