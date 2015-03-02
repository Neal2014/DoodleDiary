//
//  StartpageViewController.m
//  PassWord1
//
//  Created by 雷江 on 14-11-12.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "StartpageViewController.h"
#import "JJFlyDiaryViewController.h"


@interface StartpageViewController ()
@end

@implementation StartpageViewController

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

    
    rootVC=[[[JJFlyDiaryViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.nav=[[UINavigationController alloc] initWithRootViewController:rootVC];

    fView =[[UIImageView alloc]initWithFrame:self.view.frame];//初始化fView
    fView.image=[UIImage imageNamed:@"letterPage16.jpg"];//图片f.png 到fView
    
//    zView=[[UIImageView alloc]initWithFrame:self.view.frame];//初始化zView
//    zView.image=[UIImage imageNamed:@"5.jpg"];//图片z.png 到zView
//    
    rView=[[UIView alloc]initWithFrame:self.view.frame];//初始化rView
    
    [rView addSubview:fView];//add 到rView
//    [rView addSubview:zView];//add 到rView
    
    [self.view addSubview:rView];//add 到window
    
    [self performSelector:@selector(TheAnimation) withObject:nil afterDelay:0.5];//5秒后执行TheAnimation
    
}
- (void)TheAnimation{
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7 ;  // 动画持续时间(秒)
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;//淡入淡出效果
    
    NSUInteger f = [[rView subviews] indexOfObject:fView];
//    NSUInteger z = [[rView subviews] indexOfObject:zView];
//    [rView exchangeSubviewAtIndex:self withSubviewAtIndex:f];
    [self.view insertSubview:rView atIndex:f];
    
    [[rView layer] addAnimation:animation forKey:@"animation"];
    
    [self performSelector:@selector(ToUpSide) withObject:nil afterDelay:0.5];//2秒后执行TheAnimation
}

#pragma mark - 上升效果
- (void)ToUpSide {
    
    [self moveToUpSide];//向上拉界面
    
}

- (void)moveToUpSide {
    [UIView animateWithDuration:0.7 //速度0.7秒
                     animations:^{//修改rView坐标
                         rView.frame = CGRectMake(self.view.frame.origin.x,
                                                  -self.view.frame.size.height,
                                                  self.view.frame.size.width,
                                                  self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self presentModalViewController:self.nav animated:NO];
                     }];
    
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
