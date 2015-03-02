//
//  PhotoDetailViewController.m
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-19.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "PhotoDetailViewController.h"
@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController
-(void)dealloc
{
    [_senderImage release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加寸相册按钮
    UIBarButtonItem *saveToAlbumBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"存相册" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedSaveToAlbumBtnItemAction:)];
    self.navigationItem.rightBarButtonItem = saveToAlbumBtnItem;
    [saveToAlbumBtnItem release];
    
    
    
    [self addSubviews];
}
- (void)addSubviews
{
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    myImageView.image = _senderImage;
    [self.view addSubview:myImageView];
    [myImageView release];
}

- (void)didClickedSaveToAlbumBtnItemAction:(UIBarButtonItem *)saveToAlbumBtnItem
{
    UIImageWriteToSavedPhotosAlbum(self.senderImage, self,  nil , nil );
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"保存成功" leftButtonTitle:nil rightButtonTitle:@"确定"];
    [alert show];
    [alert release];
    alert.rightBlock = ^() {
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
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
