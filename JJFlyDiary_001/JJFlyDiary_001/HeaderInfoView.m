//
//  HeaderInfoView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "HeaderInfoView.h"
@implementation HeaderInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews
{
    //显示日期
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 60)];
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.numberOfLines = 0;
    //设置日期
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy/MM/dd\n   HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:date];
    _dateLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:15];
    _dateLabel.textColor = [UIColor colorWithRed:1.000 green:0.248 blue:0.143 alpha:1.000];
    _dateLabel.text = strDate;
    
    [self addSubview:_dateLabel];
    [_dateLabel release];
    [formatter release];
    
    //心情按钮
    _feelingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _feelingBtn.frame = CGRectMake(115, 0, 60, 60);
    [_feelingBtn setBackgroundImage:[UIImage imageNamed:@"diary-mood1"] forState:UIControlStateNormal];
    [self addSubview:_feelingBtn];
    
    //天气按钮
    _weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _weatherBtn.frame = CGRectMake(185, 0, 60, 60);
    [_weatherBtn setBackgroundImage:[UIImage imageNamed:@"newweather1"] forState:UIControlStateNormal];
    [self addSubview:_weatherBtn];
    
    //背景按钮
    _letterPaperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _letterPaperBtn.frame = CGRectMake(255, 2, 60, 58);
    [_letterPaperBtn setBackgroundImage:[UIImage imageNamed:@"letterPage1.jpg"] forState:UIControlStateNormal];
    [self addSubview:_letterPaperBtn];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
