//
//  UserGuideViewController.m
//  JJFlyDiary_001
//
//  Created by 雷江 on 14-11-19.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "UserGuideViewController.h"
#import "JJFlyDiaryViewController.h"
@interface UserGuideViewController ()

@end

@implementation UserGuideViewController
@synthesize nav;
@synthesize rootVC;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];
}
- (void)initGuide
{
    
    rootVC=[[[JJFlyDiaryViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.nav=[[UINavigationController alloc] initWithRootViewController:rootVC];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    [scrollView setContentSize:CGSizeMake(1280, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    [imageview setImage:[UIImage imageNamed:@"22.jpg"]];
    [scrollView addSubview:imageview];
    [imageview release];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, kMainScreenWidth, kMainScreenHeight)];
    [imageview1 setImage:[UIImage imageNamed:@"23.jpg"]];
    [scrollView addSubview:imageview1];
    [imageview1 release];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, kMainScreenWidth, kMainScreenHeight)];
    [imageview2 setImage:[UIImage imageNamed:@"26.jpg"]];
    [scrollView addSubview:imageview2];
    [imageview2 release];
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(960, 0, kMainScreenWidth, kMainScreenHeight)];
    [imageview3 setImage:[UIImage imageNamed:@"27.jpg"]];
    imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
    [scrollView addSubview:imageview3];
    [imageview3 release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    [button setTitle:@"进入首页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.704 green:1.000 blue:0.177 alpha:1.000] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(46, 371, 230, 37)];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    [imageview3 addSubview:button];
    
    [self.view addSubview:scrollView];
    [scrollView release];
}
 - (void)firstpressed
 {
//         [self presentModalViewController:[[[JJFlyDiaryViewController alloc] init] autorelease] animated:YES];  //点击button跳转到根视图
     [self presentModalViewController:self.nav animated:NO];
//     JJFlyDiaryViewController *controller = [[JJFlyDiaryViewController alloc] init];
//     [self presentModalViewController:controller animated:YES];
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
