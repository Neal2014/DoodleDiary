//
//  DoodleModel.m
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DoodleModel.h"

@implementation DoodleModel
-(void)dealloc
{
    [_doodleStrokeColor release];
    [_typefaceFont release];
    [_typefaceColor release];
    [super dealloc];
}
static DoodleModel *doodleModel = nil;
+(DoodleModel *)shareDoodleDiaryModel
{
    if (!doodleModel) {
        doodleModel = [[DoodleModel alloc] init];
    }
    return doodleModel;
}
@end
