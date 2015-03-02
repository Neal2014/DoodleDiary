//
//  DiaryModel.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DiaryModel.h"

@implementation DiaryModel
-(void)dealloc
{
    [_letterPaperImageData release];
    [_imageArray release];
    [_imageViewRectArray release];
    [_diaryText release];
    [_dateLabelStr release];
    [_weatherBtnImageData release];
    [_feelingBtnImageData release];
    [_letterPaperBtnImageData release];
    [_diaryTextFontArray release];
    [_diaryTextRGBArray release];
    [_imageRotationArray release];
    [super dealloc];
}
//实现NSCoding协议的两个方法
//归档方法  -- 实际对Person所有属性进行编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //对属性进行编码过程
    [aCoder encodeObject:self.letterPaperImageData forKey:@"letterPaperImageData"];
    [aCoder encodeObject:self.imageViewRectArray forKey:@"imageViewRectArray"];
    [aCoder encodeObject:self.imageArray forKey:@"imageArray"];
    [aCoder encodeObject:self.diaryText forKey:@"diaryText"];
    [aCoder encodeObject:self.weatherBtnImageData forKey:@"weatherBtnImageData"];
    [aCoder encodeObject:self.feelingBtnImageData forKey:@"feelingBtnImageData"];
    [aCoder encodeObject:self.letterPaperBtnImageData forKey:@"letterPaperBtnImageData"];
    [aCoder encodeObject:self.dateLabelStr forKey:@"dateLabelStr"];
    [aCoder encodeObject:self.diaryTextFontArray forKey:@"diaryTextFontArray"];
    [aCoder encodeObject:self.diaryTextRGBArray forKey:@"diaryTextRGBArray"];
    [aCoder encodeObject:self.imageRotationArray forKey:@"imageRotationArray"];
}
//反归档 --
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.letterPaperImageData = [aDecoder decodeObjectForKey:@"letterPaperImageData"];
        self.imageViewRectArray = [aDecoder decodeObjectForKey:@"imageViewRectArray"];
        self.imageArray = [aDecoder decodeObjectForKey:@"imageArray"];
        self.diaryText = [aDecoder decodeObjectForKey:@"diaryText"];
        self.weatherBtnImageData = [aDecoder decodeObjectForKey:@"weatherBtnImageData"];
        self.feelingBtnImageData = [aDecoder decodeObjectForKey:@"feelingBtnImageData"];
        self.letterPaperBtnImageData = [aDecoder decodeObjectForKey:@"letterPaperBtnImageData"];
        self.dateLabelStr = [aDecoder decodeObjectForKey:@"dateLabelStr"];
        self.diaryTextFontArray = [aDecoder decodeObjectForKey:@"diaryTextFontArray"];
        self.diaryTextRGBArray = [aDecoder decodeObjectForKey:@"diaryTextRGBArray"];
        self.imageRotationArray = [aDecoder decodeObjectForKey:@"imageRotationArray"];
    }
    
    return self;
}
@end
