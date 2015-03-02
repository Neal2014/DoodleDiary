//
//  TypefaceModel.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypefaceModel : NSObject
@property (nonatomic,retain) UIColor *typefaceColor;
@property (nonatomic,retain) UIFont  *typefaceFont;

+(TypefaceModel *)shareTypefaceModel;

@end
