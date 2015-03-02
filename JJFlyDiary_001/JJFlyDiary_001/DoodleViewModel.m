//
//  DoodleViewModel.m
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DoodleViewModel.h"

@implementation DoodleViewModel
-(void)dealloc
{
    [_path release];
    [_color release];
    [super dealloc];
}

+ (id)viewModelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width
{
    DoodleViewModel *myViewModel = [[DoodleViewModel alloc] init];
    
    myViewModel.color = color;
    myViewModel.path = path;
    myViewModel.width = width;
    
    return [myViewModel autorelease];
}
@end
