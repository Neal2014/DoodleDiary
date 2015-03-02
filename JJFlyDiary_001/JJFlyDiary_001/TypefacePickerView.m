//
//  TypefacePickerView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "TypefacePickerView.h"
#import "TypefaceModel.h"
@implementation TypefacePickerView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self prepareData];
    }
    return self;
}
-(void)prepareData
{
    //设置所有字体
    _fontArray=[[NSArray alloc] initWithArray:[UIFont familyNames]];
    
    //设置字体大小数组
    _sizeArray=[[NSArray alloc] initWithObjects:
                @"12",
                @"14",
                @"16",
                @"18",
                @"20",
                @"22",
                @"24",
                @"26",
                @"28",
                @"30",
                @"32",
                @"34",
                @"36",
                @"38",
                @"40",nil];
    
    //设置颜色数组
    _colorArray=[[NSArray alloc] initWithObjects:
                 [UIColor colorWithRed:0.524 green:1.000 blue:0.090 alpha:1.000],
                 [UIColor colorWithRed:0.268 green:1.000 blue:0.519 alpha:1.000],
                 [UIColor colorWithRed:0.539 green:1.000 blue:0.035 alpha:1.000],
                 [UIColor colorWithRed:0.142 green:0.820 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:0.278 green:0.573 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.806 blue:0.331 alpha:1.000],
                 [UIColor colorWithRed:0.659 green:0.555 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:0.806 green:1.000 blue:0.652 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.466 blue:0.464 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.479 blue:0.903 alpha:1.000],
                 [UIColor colorWithRed:0.671 green:0.372 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.201 blue:0.807 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.000 blue:0.525 alpha:1.000],
                 [UIColor colorWithRed:0.000 green:0.826 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.789 blue:0.661 alpha:1.000],
                 [UIColor whiteColor],
                 [UIColor blackColor],
                 [UIColor colorWithRed:0.502 green:0.502 blue:0.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000],
                 [UIColor colorWithRed:0.502 green:0.000 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.435 blue:0.812 alpha:1.000],
                 [UIColor colorWithRed:0.800 green:0.400 blue:1.000 alpha:1.000],
                 [UIColor colorWithWhite:0.298 alpha:1.000],
                 [UIColor magentaColor],
                 [UIColor redColor],
                 [UIColor yellowColor],
                 [UIColor greenColor],
                 [UIColor cyanColor],
                 [UIColor blueColor],
                 [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:0.517 green:1.000 blue:0.110 alpha:1.000],
                 [UIColor colorWithRed:0.000 green:1.000 blue:0.502 alpha:1.000],
                 [UIColor colorWithRed:0.502 green:1.000 blue:0.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:1.000 blue:0.400 alpha:1.000],
                 [UIColor colorWithRed:0.400 green:1.000 blue:0.400 alpha:1.000],
                 [UIColor colorWithRed:0.400 green:1.000 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000],
                 [UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000],
                 [UIColor colorWithRed:0.800 green:1.000 blue:0.400 alpha:1.000],
                 [UIColor colorWithRed:1.000 green:0.800 blue:0.400 alpha:1.000],
                 [UIColor lightGrayColor], nil];
}
#pragma mark ------ TypefacePickerView的UIPickerViewDelegate  UIPickerViewDataSource处理------

//以下是适配器部分，即数据源

//返回有几列
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回指定列的行数
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return  [_fontArray count];
    } else if(component==1){
        return  [_colorArray count];
    }
    else if(component==2){
        return [_sizeArray count];
    }
    return 0;
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return  40;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==0) {
        //第0列，宽为180
        return  180;
    } else if(component==1){
        //第1列，宽为80
        return  80;
    }
    else{
        //第三列宽为60
        return 60;
    }
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //思想就是：先创建一个View以指定列的宽度，和所在列行的高度，为尺寸
    //再建立一个label,在这个view上显示字体，字体颜色，字体大小，然后，把这个label添加到view中
    //返回view，作为指定列的每行的视图
    
    //取得指定列的宽度
    CGFloat width=[self pickerView:pickerView widthForComponent:component];
    //取得指定列，行的高度
    CGFloat height=[self pickerView:pickerView rowHeightForComponent:component];
    //定义一个视图
    UIView *myView=[[UIView alloc] init];
    //指定视图frame
    myView.frame=CGRectMake(0, 0, width, height);
    UILabel *labelOnComponent=[[UILabel alloc] init];
    labelOnComponent.frame=myView.frame;
    labelOnComponent.tag=200;
    
    if (component==0) {
        //如果是第0列
        
        //以行为索引，取得字体
        UIFont *font=[_fontArray objectAtIndex:row];
        //在label上显示改字体
        labelOnComponent.text=[NSString stringWithFormat:@"%@",font];//到时候这里固定文字，设置font就OK
    }
    else if(component==1){
        //如果是第1列
        //以说选择行为索引，取得颜色数组中的颜色，并把label的背景色设为该颜色
        labelOnComponent.backgroundColor=[_colorArray objectAtIndex:row];
    }
    else if(component==2){
        //如果是第2列
        //label 上显示的是相应字体
        labelOnComponent.text=[_sizeArray objectAtIndex:row];
    }
    [myView addSubview:labelOnComponent];
    //内存管理，建立后释放
    [labelOnComponent release];
    [myView autorelease];
    return myView;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    //取得选择的是第0列的哪一行
    NSInteger rowOfFontComponent = [pickerView selectedRowInComponent:0];
    //取得选择的是第1列的哪一行
    NSInteger rowOfColorComponent = [pickerView selectedRowInComponent:1];
    //取得选择的是第2列的哪一行
    NSInteger rowOfSizeComponent = [pickerView selectedRowInComponent:2];
    //取得所选列所选行的视图
    UIView *ViewOfFontComponent = [pickerView viewForRow:rowOfFontComponent forComponent:0];
    UIView *ViewOfColorComponent = [pickerView viewForRow:rowOfColorComponent forComponent:1];
    UIView *ViewOfSizeComponent = [pickerView viewForRow:rowOfSizeComponent forComponent:2];
    //取得取得所选行所选列上的视图的子视图
    UILabel *viewOnViewofFontComponent=(UILabel *)[ViewOfFontComponent viewWithTag:200];
    UILabel *viewOnViewOfColorComponent=(UILabel *)[ViewOfColorComponent viewWithTag:200];
    UILabel *viewOnViewOfSizeComponent=(UILabel *)[ViewOfSizeComponent viewWithTag:200];
    
    //最后将所选择的结果展现在label上，即字体样式，字体颜色，字体大小
    //创建model
    TypefaceModel *typefaceModel = [TypefaceModel shareTypefaceModel];
    
    typefaceModel.typefaceFont=[UIFont fontWithName:viewOnViewofFontComponent.text size:[viewOnViewOfSizeComponent.text floatValue]];
    typefaceModel.typefaceColor=viewOnViewOfColorComponent.backgroundColor;
    
    //代理传值
    if (nil != _typefaceDelegate && [_typefaceDelegate respondsToSelector:@selector(changeTypefaceInfoForEdtingDiaryTextView:)]) {
        [_typefaceDelegate changeTypefaceInfoForEdtingDiaryTextView:typefaceModel];
    }
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
