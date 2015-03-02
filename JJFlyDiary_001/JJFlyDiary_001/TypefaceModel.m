//
//  TypefaceModel.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "TypefaceModel.h"

@implementation TypefaceModel
-(void)dealloc
{
    [_typefaceFont release];
    [_typefaceColor release];
    [super dealloc];
}

static TypefaceModel *typefaceModel = nil;
+(TypefaceModel *)shareTypefaceModel
{
    if (!typefaceModel) {
        typefaceModel = [[TypefaceModel alloc] init];
    }
    return typefaceModel;
}
@end
