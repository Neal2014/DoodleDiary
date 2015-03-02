//
//  PrivacyViewController.m
//  JJFlyDiary_001
//
//  Created by 雷江 on 14-11-22.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

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
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:rect];//rect是你设计好大小的矩形
    myWebView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:@"http://m.bjs140831.icoc.cc/index.jsp"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:req];
    [self.view addSubview:myWebView];
}
//返回
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
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
