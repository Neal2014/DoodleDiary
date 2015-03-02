//
//  DiaryListTableViewCell.m
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-17.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DiaryListTableViewCell.h"

@implementation DiaryListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews
{
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    _dateLabel.backgroundColor = [UIColor yellowColor];
    _dateLabel.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
    _dateLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:11];;
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dateLabel];
    [_dateLabel release];
    
    _myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, kMainScreenWidth - 60, 50)];
    _myTextLabel.numberOfLines = 0;
    _myTextLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:15];;
    _myTextLabel.textAlignment = NSTextAlignmentLeft;
    _myTextLabel.backgroundColor = [UIColor greenColor];
    _myTextLabel.textColor = [UIColor colorWithRed:1.000 green:0.213 blue:0.484 alpha:1.000];
    [self addSubview:_myTextLabel];
    [_myTextLabel release];
    
    //设置圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1.5;
    self.layer.borderColor = [UIColor colorWithRed:1.000 green:0.435 blue:0.812 alpha:1.000].CGColor;
    self.clipsToBounds = YES;
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
