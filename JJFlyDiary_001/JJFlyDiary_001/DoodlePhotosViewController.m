//
//  DoodlePhotosViewController.m
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-19.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DoodlePhotosViewController.h"
#import "PhotoDetailViewController.h"
#import "GBPathImageView.h"
@interface DoodlePhotosViewController ()
{
    NSMutableArray *_imageArray;
    NSMutableArray *_doodleTimeArray;
    iCarousel *_icarousel;
    FMDatabase *_db;
}
@end

@implementation DoodlePhotosViewController
-(void)dealloc
{
    [_imageArray release];
    [_doodleTimeArray release];
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
    _icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 64)];
    _icarousel.delegate = self;
    _icarousel.dataSource = self;
    //取本地样式
    NSInteger photoStyleIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"phtotStyle"]intValue];
    if (0 != photoStyleIndex) {
        _icarousel.type = photoStyleIndex - 100;
    }else
        _icarousel.type = iCarouselTypeCoverFlow2;

    [self.view addSubview:_icarousel];
    [_icarousel release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"涂鸦相册";
    self.view.backgroundColor = [UIColor colorWithRed:0.819 green:1.000 blue:0.805 alpha:1.000];
    
    //添加样式按钮
    UIBarButtonItem *picsStyleBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"相册样式" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedPicsStyleBtnItemAction:)];
    self.navigationItem.rightBarButtonItem = picsStyleBtnItem;
    [picsStyleBtnItem release];
    
    
    
    [self loadDatasourceFromQuerySqlite];
    [self addSubviews];
}
#pragma mark ---- 数据库查询赋值给数据源-----
- (void)loadDatasourceFromQuerySqlite
{
    /**
     保存到数据库
     */
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
    if ( ![_db tableExists:@"MyDoodle"] ) {
        [_db executeUpdate:@"CREATE TABLE MyDoodle (doodleTime text NOT NULL PRIMARY KEY UNIQUE,ImageDate blob NOT NULL)"];
    }
    //3、查询并加载好数据源
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM MyDoodle ORDER BY doodleTime desc"];
    while ([resultSet next]) {
        
        NSString *doodleTimeStr = [resultSet stringForColumn:@"doodleTime"];
        if (nil == _doodleTimeArray) {
            _doodleTimeArray = [[NSMutableArray alloc] initWithCapacity:1];
        }
        [_doodleTimeArray addObject:doodleTimeStr];
        
        
        NSData *imageData = [resultSet dataForColumn:@"ImageDate"];
        UIImage *doodleImage = [UIImage imageWithData:imageData];
        if (nil == _imageArray) {
            _imageArray = [[NSMutableArray alloc] initWithCapacity:10];
        }
        [_imageArray addObject:doodleImage];
    }
    
}
#pragma mark ----- barBtnItemAction-----
- (void)didClickedPicsStyleBtnItemAction:(UIBarButtonItem *)picsStyleBtnItem
{
    /**
     iCarouselTypeLinear = 0,
     iCarouselTypeRotary,
     iCarouselTypeInvertedRotary,
     iCarouselTypeCylinder,
     iCarouselTypeInvertedCylinder,
     iCarouselTypeWheel,
     iCarouselTypeInvertedWheel,
     iCarouselTypeCoverFlow,
     iCarouselTypeCoverFlow2,
     iCarouselTypeTimeMachine,
     iCarouselTypeInvertedTimeMachine,
     */
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择您想要的相册样式", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Linear", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeLinear;
                                [_icarousel reloadData];
                                //永久保存相册样式
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:0+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Rotary", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeRotary;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:1+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"InvertedRotary", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeInvertedRotary;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:2+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Cylinder", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeCylinder;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:3+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    [actionSheet addButtonWithTitle:NSLocalizedString(@"InvertedCylinder", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeInvertedCylinder;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:4+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Wheel", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeWheel;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:5+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"InvertedWheel", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeInvertedWheel;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:6+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Flow", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeCoverFlow;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:7+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    [actionSheet addButtonWithTitle:NSLocalizedString(@"CoverFlow2", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeCoverFlow2;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:8+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"TimeMachine", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeTimeMachine;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:9+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    [actionSheet addButtonWithTitle:NSLocalizedString(@"InvertedTimeMachine", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                _icarousel.type = iCarouselTypeInvertedTimeMachine;
                                [_icarousel reloadData];
                                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:10+100] forKey:@"phtotStyle"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }];
    
    [actionSheet show];

}



#pragma mark ----iCarouselDelegate,iCarouselDataSource代理的实现 -------
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return [_imageArray count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[GBPathImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 300.0f) image:_imageArray[index] pathType:GBPathImageViewTypeSquare pathColor:[UIColor colorWithRed:1.000 green:0.559 blue:0.000 alpha:1.000] borderColor:[UIColor colorWithRed:0.492 green:0.458 blue:1.000 alpha:1.000] pathWidth:6.0];
        view.userInteractionEnabled = YES;
        
        //加下扫删除手势
        UISwipeGestureRecognizer * swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction:)];
        swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
        [view addGestureRecognizer:swipeDown];
        
        //显示时间
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        label.font = [UIFont fontWithName:@"Thonburi-Bold" size:15];
        label.tag = 1000000;
        [view addSubview:label];
        [label release];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1000000];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //iews outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = _doodleTimeArray[index];
    
    return view;
}

-(void)swipeDownAction:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSInteger index = _icarousel.currentItemIndex;
    //UI下滑效果
    [UIView animateWithDuration:0.5 animations:^{
        CGRect theRect =  gestureRecognizer.view.frame;
        theRect.origin.y = kMainScreenHeight / 2;
        gestureRecognizer.view.alpha = 0.4;
        gestureRecognizer.view.frame = theRect;
    } completion:^(BOOL finished) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"确定删除该图片？" leftButtonTitle:@"取消" rightButtonTitle:@"删除"];
        [alert show];
        alert.leftBlock = ^() {
            CGRect theRect =  gestureRecognizer.view.frame;
            theRect.origin.y = 0;
            gestureRecognizer.view.alpha = 1;
            gestureRecognizer.view.frame = theRect;
        };
        alert.rightBlock = ^() {
            if (_icarousel.numberOfItems > 0)
            {
                
                //数据库删除
                [_db executeUpdateWithFormat:@"delete from MyDoodle where doodleTime = %@",_doodleTimeArray[index]];
                //数据源删除
                [_imageArray removeObjectAtIndex:(NSUInteger)index];
                [_doodleTimeArray removeObjectAtIndex:(NSUInteger)index];
                //UI删除
                [_icarousel removeItemAtIndex:index animated:YES];
            }
        };
    }];
}
#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    PhotoDetailViewController *photoDetailVC = [[PhotoDetailViewController alloc] init];
    photoDetailVC.senderImage = _imageArray[(NSUInteger)index];
    [self.navigationController pushViewController:photoDetailVC animated:YES];
    [photoDetailVC release];
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
