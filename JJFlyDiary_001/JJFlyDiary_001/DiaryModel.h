//
//  DiaryModel.h
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DiaryModel : NSObject<NSCoding>
//信纸图片
@property (nonatomic,retain) NSData *letterPaperImageData;
//图片和图片frame
@property (nonatomic,retain) NSArray *imageViewRectArray;
@property (nonatomic,retain) NSArray *imageArray;
//日记正文
@property (nonatomic,retain) NSString *diaryText;
//日记日期
@property (nonatomic,retain) NSString *dateLabelStr;
//日记天气图片
@property (nonatomic,retain) NSData *weatherBtnImageData;
//日记心情图片
@property (nonatomic,retain) NSData *feelingBtnImageData;
//日记背景图片
@property (nonatomic,retain) NSData *letterPaperBtnImageData;
//日记字体字典
@property (nonatomic,retain) NSArray *diaryTextFontArray;
//日记字体颜色
@property (nonatomic,retain) NSArray *diaryTextRGBArray;
//图片旋转状态
@property (nonatomic,retain) NSArray *imageRotationArray;
@end
