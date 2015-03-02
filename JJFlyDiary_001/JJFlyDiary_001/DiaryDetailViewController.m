//
//  DiaryDetailViewController.m
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-17.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DiaryDetailViewController.h"
#import "HeaderInfoView.h"
#import "EdtingDiaryTextView.h"
@interface DiaryDetailViewController ()
{
    HeaderInfoView *_headerInfoView;
    UITextView *_detailDiaryTV;
    UIImageView *_letterPaperImageView;
    NSMutableArray *exclusionPaths;
    FMDatabase *_db;;
}
@end

@implementation DiaryDetailViewController
-(void)dealloc
{
    [exclusionPaths release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)addSubviews
{
    //加载头View
    _headerInfoView = [[HeaderInfoView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    _headerInfoView.backgroundColor = [UIColor clearColor];
    _headerInfoView.userInteractionEnabled = NO;
    [self.view addSubview:_headerInfoView];
    [_headerInfoView release];
    
    //背景
    _letterPaperImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64)];
    [self.view insertSubview:_letterPaperImageView atIndex:0];
    [_letterPaperImageView release];
    
    //加载编辑框
    _detailDiaryTV = [[EdtingDiaryTextView alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight- 60 - 64)];
    _detailDiaryTV.editable = NO;
    _detailDiaryTV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_detailDiaryTV];
    [_detailDiaryTV release];
    
}

- (void)loadDataFromDetailDiaryModel
{
    _headerInfoView.dateLabel.text = _detailDiaryModel.dateLabelStr;
    [_headerInfoView.weatherBtn setBackgroundImage:[UIImage imageWithData:_detailDiaryModel.weatherBtnImageData] forState:UIControlStateNormal];
    [_headerInfoView.feelingBtn setBackgroundImage:[UIImage imageWithData:_detailDiaryModel.feelingBtnImageData] forState:UIControlStateNormal];
    [_headerInfoView.letterPaperBtn setBackgroundImage:[UIImage imageWithData:_detailDiaryModel.letterPaperBtnImageData] forState:UIControlStateNormal];
    
    
    _detailDiaryTV.text = _detailDiaryModel.diaryText;
    
    _detailDiaryTV.font = [UIFont fontWithName:_detailDiaryModel.diaryTextFontArray[0] size:[_detailDiaryModel.diaryTextFontArray[1] floatValue]];
    if (_detailDiaryModel.diaryTextRGBArray.count == 4) {
        CGFloat R = [_detailDiaryModel.diaryTextRGBArray[0] floatValue];
        CGFloat G = [_detailDiaryModel.diaryTextRGBArray[1] floatValue];
        CGFloat B = [_detailDiaryModel.diaryTextRGBArray[2] floatValue];
        CGFloat alph = [_detailDiaryModel.diaryTextRGBArray[3] floatValue];
        _detailDiaryTV.textColor = [UIColor colorWithRed:R green:G blue:B alpha:alph];
    }
    
    _letterPaperImageView.image = [UIImage imageWithData:_detailDiaryModel.letterPaperImageData];
    
    //设置照片及环绕路径
    exclusionPaths = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0 ; i < _detailDiaryModel.imageArray.count; i++) {
        UIImage *image = [UIImage imageWithData:_detailDiaryModel.imageArray[i]];
        CGRect imageRect = CGRectFromString(_detailDiaryModel.imageViewRectArray[i]);
        UIImageView *myImageView = [[UIImageView alloc] init];

        
        myImageView.frame = imageRect;
        
        myImageView.image = image;
        //设置旋转角度
        CGFloat degree = [_detailDiaryModel.imageRotationArray[i] floatValue];
        if (degree > 180) {
            degree = degree - 360;
        }
        
        myImageView.transform = CGAffineTransformRotate(myImageView.transform, M_PI * degree / 180);

        [_detailDiaryTV addSubview:myImageView];
        [myImageView release];
        [exclusionPaths addObject:[self translatedBzierPath:myImageView.frame]];
    }
    _detailDiaryTV.textContainer.exclusionPaths = exclusionPaths;
}
#pragma mark ---gif,image的坏绕路径
-(UIBezierPath *)translatedBzierPath:(CGRect )rect
{
    CGRect imageRect = [_detailDiaryTV convertRect:CGRectMake(rect.origin.x -3 , rect.origin.y - 5, rect.size.width, rect.size.height-3) fromView:_detailDiaryTV];
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:imageRect];
    return newPath;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"日记详情";
    UIBarButtonItem *cancelBarBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(didClickedCancelBarBtnItemAction)];
    self.navigationItem.rightBarButtonItem = cancelBarBtnItem;
    [cancelBarBtnItem release];
    
    //重写返回按钮
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBackBarBtnItemAction:)];
    self.navigationItem.leftBarButtonItem = backBarBtnItem;
    [backBarBtnItem release];
    
    
    [self addSubviews];
    [self loadDataFromDetailDiaryModel];
    [self openDB];
}
- (void)openDB
{
    //到数据库中查询
    //1、打开数据库
    //设置数据库路劲
    NSString *sqPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"JJFlyDiary_001.sqlite"];
    
    _db = [[FMDatabase alloc]initWithPath:sqPath];
    //打开数据库
    if (![_db open]) {
        [_db release];
        return;
    }
    //2、判断表是否存在，不存在创建
    if ( ![_db tableExists:@"MyDiary"] ) {
        [_db executeUpdate:@"CREATE TABLE MyDiary (writeTime text NOT NULL PRIMARY KEY UNIQUE,writeDay text NOT NULL,diaryData blob,imageData blob)"];
    }
}

- (void)didClickedCancelBarBtnItemAction
{
    DXAlertView *cancelAlert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"删除后将无法找回，确定删除？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    [cancelAlert show];
    
    cancelAlert.rightBlock = ^() {
        //从数据库中删除对应数据，
        [_db executeUpdate:@"delete from MyDiary where writeTime = ?",_detailDiaryModel.dateLabelStr];
        //判断跳回，如果是从日历来的就跳回上一级，如果从编辑页面来的就跳回首页面
        if (_isComeFromeCalendar) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
            [self.navigationController popToRootViewControllerAnimated:YES];
    };

    
}

- (void)didClickedBackBarBtnItemAction:(UIBarButtonItem *)backBarBtnItem
{
    if (_isComeFromeCalendar) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
        [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
