////
////  JJFlyDiaryViewController.m
////  JJFlyDiary_001
////
////  Created by Neal Caffery on 14-11-16.
////  Copyright (c) 2014年 郝育新. All rights reserved.
////
//
//#import "JJFlyDiaryViewController.h"
//#import "EdtingDiaryViewController.h"
//#import "DoodleDiaryViewController.h"
//#import "CalendarViewController.h"
//#import "DoodlePhotosViewController.h"
//@interface JJFlyDiaryViewController ()
//{
//    FMDatabase *_db;
//}
//@end
//
//@implementation JJFlyDiaryViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
// -(void)addSubviews
//{
//    UIButton *doodleDiaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    doodleDiaryBtn.frame = CGRectMake(80, 100, 80, 60);
//    [doodleDiaryBtn setTitle:@"Doodle" forState:UIControlStateNormal];
//    [doodleDiaryBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [doodleDiaryBtn addTarget:self action:@selector(didClickedDoodleDiaryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:doodleDiaryBtn];
//    
//    UIButton *edtingDiaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    edtingDiaryBtn.frame = CGRectMake(180, 100, 80, 60);
//    [edtingDiaryBtn setTitle:@"edting" forState:UIControlStateNormal];
//    [edtingDiaryBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [edtingDiaryBtn addTarget:self action:@selector(didClickedEdtingDiaryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:edtingDiaryBtn];
//    
//    UIButton *doodlePicsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    doodlePicsBtn.frame = CGRectMake(80, 200, 80, 60);
//    [doodlePicsBtn setTitle:@"Pictures" forState:UIControlStateNormal];
//    [doodlePicsBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [doodlePicsBtn addTarget:self action:@selector(didClickedDoodlePicsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:doodlePicsBtn];
//    
//    UIButton *calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    calendarBtn.frame = CGRectMake(180, 200, 80, 60);
//    [calendarBtn setTitle:@"Calendar" forState:UIControlStateNormal];
//    [calendarBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [calendarBtn addTarget:self action:@selector(didClickedCalendarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:calendarBtn];
//    
//    UIButton *setingUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    setingUpBtn.frame = CGRectMake(120, 300, 100, 60);
//    [setingUpBtn setTitle:@"SetingUp" forState:UIControlStateNormal];
//    [setingUpBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [setingUpBtn addTarget:self action:@selector(didClickedSetingUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:setingUpBtn];
//    
//    
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
//    self.navigationController.navigationBar.translucent = NO;
//    [self addSubviews];
//    
//}
//#pragma mark --------btn点击事件处理-------
//- (void)didClickedDoodleDiaryBtnAction:(UIButton *)doodleDiaryBtn
//{
//    DoodleDiaryViewController *doodleDiaryVC = [[DoodleDiaryViewController alloc] init];
//    [self presentViewController:doodleDiaryVC animated:YES completion:nil];
//    [doodleDiaryVC release];
//}
//- (void)didClickedEdtingDiaryBtnAction:(UIButton *)edtingDiaryBtn
//{
//    EdtingDiaryViewController *edtingDirayVC = [[EdtingDiaryViewController alloc ] init];
//    [self.navigationController pushViewController:edtingDirayVC animated:YES];
//    [edtingDirayVC release];
//}
//- (void)didClickedDoodlePicsBtnAction:(UIButton *)doodlePicsBtn
//{
//    DoodlePhotosViewController *doodlePhotosVC = [[DoodlePhotosViewController alloc] init];
//    [self.navigationController pushViewController:doodlePhotosVC animated:YES];
//    [doodlePhotosVC release];
//}
//- (void)didClickedCalendarBtnAction:(UIButton *)calendarBtn
//{
//    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];
//    [self.navigationController pushViewController:calendarVC animated:YES];
//    [calendarVC release];
//}
//- (void)didClickedSetingUpBtnAction:(UIButton *)setingUpBtn
//{
//    
//}
//- (void)viewDidAppear:(BOOL)animated
//{
////    [self.navigationController setNavigationBarHidden:YES];
//
//}
//-(void)viewDidDisappear:(BOOL)animated
//{
////    [self.navigationController setNavigationBarHidden:NO];
//
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
//
//  JJFlyDiaryViewController.m
//  JJFlyDiary_001
//
//  Created by Neal Caffery on 14-11-16.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "JJFlyDiaryViewController.h"
#import "EdtingDiaryViewController.h"
#import "DoodleDiaryViewController.h"
#import "CalendarViewController.h"
#import "PAPasscodeViewController.h"
#import "WifiViewController.h"
#import "CHTumblrMenuView.h"
#import "UIButton+NMCategory.h"
#import "DoodlePhotosViewController.h"
#import "PrivacyViewController.h"
//#import "PAPasscodeViewController2.h"

@interface JJFlyDiaryViewController ()


// 头像
@property(nonatomic,retain)UIImageView *imageView;

@end

@implementation JJFlyDiaryViewController

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
    
    UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(50, 150, 100,100)];
    image1.userInteractionEnabled=YES;
    image1.image=[UIImage imageNamed:@"picture.png"];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedDoodleDiaryBtnAction:)];
    [image1 addGestureRecognizer:tap];
    [self.view addSubview:image1];
    
    UIImageView *image2=[[UIImageView alloc] initWithFrame:CGRectMake(180, 150, 100, 100)];
    image2.userInteractionEnabled=YES;
    image2.image=[UIImage imageNamed:@"clipboard.png"];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedEdtingDiaryBtnAction:)];
    [image2 addGestureRecognizer:tap2];
    [self.view addSubview:image2];
    
    UIImageView *image3=[[UIImageView alloc] initWithFrame:CGRectMake(50, 270, 100, 100)];
    image3.userInteractionEnabled=YES;
    image3.image=[UIImage imageNamed:@"camera.png"];
    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedDoodlePicsBtnAction:)];
    [image3 addGestureRecognizer:tap3];
    [self.view addSubview:image3];
    
    
    UIImageView *image4=[[UIImageView alloc] initWithFrame:CGRectMake(180, 270, 100, 100)];
    image4.userInteractionEnabled=YES;
    image4.image=[UIImage imageNamed:@"calendar.png"];
    UITapGestureRecognizer *tap4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedCalendarBtnAction:)];
    [image4 addGestureRecognizer:tap4];
    [self.view addSubview:image4];
    // 头像
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 50, 100, 100)];
    [_imageView.layer setMasksToBounds:YES];
    _imageView.clipsToBounds = YES;
    [_imageView.layer setCornerRadius:self.imageView.frame.size.height / 2];
    _imageView.layer.backgroundColor = [UIColor colorWithRed:0.374 green:0.500 blue:0.314 alpha:1.000].CGColor;
    _imageView.layer.borderWidth = 3.0f;
    _imageView.layer.borderColor = [UIColor redColor].CGColor;
    _imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:_imageView];
    // 点击手势
    UITapGestureRecognizer *tapImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClicktapImageViewAction)];
    [self.imageView addGestureRecognizer:tapImageView];

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 100,96,96)];
    [btn setBackgroundImage:[UIImage imageNamed:@"129.png"] forState:UIControlStateNormal];
    btn.tag = 0;
    btn.layer.cornerRadius = 8;
    [btn setDragEnable:YES];
    [btn setAdsorbEnable:YES];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}
- (void)showMenu
{
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    [menuView addMenuItemWithTitle:@"密码设置" andIcon:[UIImage imageNamed:@"password.png"] andSelectedBlock:^{
        NSLog(@"Text selected");
        WifiViewController *settingVC=[[WifiViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
        [settingVC release];
        
    }];
    [menuView addMenuItemWithTitle:@"关于软件" andIcon:[UIImage imageNamed:@"about128.png"] andSelectedBlock:^{
        
        
    }];
//    [menuView addMenuItemWithTitle:@"软件更新" andIcon:[UIImage imageNamed:@"update.png"] andSelectedBlock:^{
//        NSLog(@"Quote selected");
//    }];
    [menuView addMenuItemWithTitle:@"使用帮助" andIcon:[UIImage imageNamed:@"help128.png"] andSelectedBlock:^{
        NSLog(@"Link selected");
        
    }];
    [menuView addMenuItemWithTitle:@"隐私声明" andIcon:[UIImage imageNamed:@"preferences"] andSelectedBlock:^{
        NSLog(@"Chat selected");
        PrivacyViewController *settingVC=[[PrivacyViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
        [settingVC release];
    }];
//    [menuView addMenuItemWithTitle:@"我要评分" andIcon:[UIImage imageNamed:@"post_type_bubble_chat.png"] andSelectedBlock:^{
//        NSLog(@"Chat selected");
//
//        
//    }];
    [menuView show];
}


- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        //        [[[UIAlertView alloc] initWithTitle:nil message:@"Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        _passwordLabel.text = controller.passcode;
    }];
    //    WifiViewController *wi=[[WifiViewController alloc] init];
    //    [self.navigationController popToViewController:wi animated:YES];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        _passwordLabel.text = controller.passcode;
    }];
}
//验证密码
-(void)PassWord
{
    
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
    passcodeViewController.navigationController.navigationBarHidden = YES;
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    //    passcodeViewController.navigationItem.rightBarButtonItem=nil;
    //    passcodeViewController.views.navigationItem.rightBarButtonItem=nil;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (void) viewDidUnload {
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.837 blue:0.461 alpha:1.000];
    
    //    NSString *backgroudpath = [[NSBundle mainBundle] pathForResource:@"6" ofType:@"jpg"];
    //    UIImage  *backgroudImage = [UIImage imageWithContentsOfFile:backgroudpath];
    //    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroudImage] ;
    
    
    self.navigationController.navigationBar.translucent = NO;
    //    self.navigationItem.title=@"呵呵";
    //    self.navigationController.navigationItem.title=@"heh";
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"name"]!=nil) {
        [self PassWord];
        
        [self addSubviews];
    }else
    {
        [self addSubviews];
    }
    [self setheadImage];
    NSLog(@"第三个%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"name"]);
}

- (void)setheadImage
{
    NSString *headImagefile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"headImagefile.png"];
    
    NSData *imageData = [NSData dataWithContentsOfFile:headImagefile];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    _imageView.image = image;
    
}





#pragma mark ------ 点击头像 调用系统相机 ------
- (void) didClicktapImageViewAction
{
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"设置头像", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相册", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                    picker.delegate = self;
                                    picker.allowsEditing = YES;//是否可以对原图进行编辑
                                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                    [self presentViewController:picker animated:YES completion:nil];
                                    
                                }
                                else{
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片库不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alertView show];
                                }

                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相机", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                    picker.delegate = self;//设置UIImagePickerController的代理，同时要遵循UIImagePickerControllerDelegate，UINavigationControllerDelegate协议
                                    picker.allowsEditing = YES;//设置拍照之后图片是否可编辑，如果设置成可编辑的话会在代理方法返回的字典里面多一些键值。PS：如果在调用相机的时候允许照片可编辑，那么用户能编辑的照片的位置并不包括边角。
                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    [self presentViewController:picker animated:YES completion:nil];
                                    
                                }else{
                                    // 没有摄像头
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"抱歉，没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                                    [alertView show];
                                    [alertView release];
                                }

                            }];
    [actionSheet show];

}
#pragma mark - UIImagePickerControllerDelegate
#pragma mark - 拍照/选择图片结束

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%s  %d",__FUNCTION__,__LINE__);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    NSLog(@"%s  %d",__FUNCTION__,__LINE__);
    // 创建图片文件夹
    NSString *headImagefile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"headImagefile.png"];
    NSLog(@"headImagefile:%@",headImagefile);
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // 写入Caches
    [imageData writeToFile:headImagefile atomically:YES];
    
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - 取消拍照/选择图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark --------btn点击事件处理-------
- (void)didClickedDoodleDiaryBtnAction:(UIButton *)doodleDiaryBtn
{
    DoodleDiaryViewController *doodleDiaryVC = [[DoodleDiaryViewController alloc] init];
    [self presentViewController:doodleDiaryVC animated:YES completion:nil];
    [doodleDiaryVC release];
}
- (void)didClickedEdtingDiaryBtnAction:(UIButton *)edtingDiaryBtn
{
    EdtingDiaryViewController *edtingDirayVC = [[EdtingDiaryViewController alloc ] init];
    [self.navigationController pushViewController:edtingDirayVC animated:YES];
    [edtingDirayVC release];
}
- (void)didClickedDoodlePicsBtnAction:(UIButton *)doodlePicsBtn
{
    DoodlePhotosViewController *doodlePhotosVC = [[DoodlePhotosViewController alloc] init];
    [self.navigationController pushViewController:doodlePhotosVC animated:YES];
    [doodlePhotosVC release];
}
- (void)didClickedCalendarBtnAction:(UIButton *)calendarBtn
{
    CalendarViewController *calendarVC = [[CalendarViewController alloc] init];
    [self.navigationController pushViewController:calendarVC animated:YES];
    [calendarVC release];
}

- (void)didClickedSetingUpBtnAction:(UIButton *)setingUpBtn
{
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //    NSLog(@"111");
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //    NSLog(@"2222");
    self.navigationController.navigationBarHidden = NO;
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

