//
//  DoodleViewModel.h
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DoodleViewModel : NSObject

@property (retain, nonatomic) UIColor *color;

@property (retain, nonatomic) UIBezierPath *path;

@property (assign, nonatomic) CGFloat width;

+ (id)viewModelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width;
@end
