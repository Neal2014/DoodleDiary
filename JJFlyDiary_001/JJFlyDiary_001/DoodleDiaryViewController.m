//
//  DoodleDiaryViewController.m
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DoodleDiaryViewController.h"
#import "DoodleStrokeInfoPickerView.h"
#import "TypeFaceInfoPickerView.h"
#import "ExchaneSateView.h"
#import "DoodleView.h"
#import "DoodleScrollView.h"
#import "GBPathImageView.h"
#define kBackgroundImage 10;
#define kAddToDoodleScrollView 50;
@interface DoodleDiaryViewController ()
{
    DoodleStrokeInfoPickerView *_doodleStrokePV;
    TypeFaceInfoPickerView *_typeFaceInfoPV;
    UIView *_changeBgColorView;
    ExchaneSateView *_exchangeStateView;
    DoodleScrollView *_doodleScrollView;
    DoodleView *_doodleView;
    UIImageView *_backgroundImageView;
    UIActionSheet *_addPhotoActionSheet;
    UIActionSheet *_changeBgActionSheet;
    NSInteger _flag;
    
}
@end

@implementation DoodleDiaryViewController
-(void)dealloc
{
    [_addPhotoActionSheet release];
    [_changeBgActionSheet release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor orangeColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (void)addSubviews
{
    //添加MyScrollView
    _doodleScrollView = [[DoodleScrollView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight )];
    _doodleScrollView.myBlock = ^{
        _exchangeStateView.frame = CGRectMake(-48, (kMainScreenHeight - 350) /2, 50, 350);
        
        [self hiddenAllAccessoryView];
    };
    //给_doodleScrollView添加边缘手势，方便调出切换状态栏
    UIScreenEdgePanGestureRecognizer *screenEdgePan= [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(showExchaneStateView)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [_doodleScrollView addGestureRecognizer:screenEdgePan];
    [screenEdgePan release];
    
    //给MyScrollView添加涂鸦视图
    _doodleView = [[DoodleView alloc] initWithFrame:_doodleScrollView.bounds];
    _doodleView.myBlock = ^{
        _exchangeStateView.frame = CGRectMake(-48, (kMainScreenHeight - 350) /2, 50, 350);
        [self hiddenAllAccessoryView];
    };
    [_doodleScrollView insertSubview:_doodleView atIndex:0];
    [_doodleView release];
    [self.view addSubview:_doodleScrollView];
    [_doodleScrollView release];
    
    //添加切换状态框
    _exchangeStateView = [[ExchaneSateView alloc] initWithFrame:CGRectMake(0, (kMainScreenHeight - 350) /2, 50, 350)];
    _exchangeStateView.backgroundColor = [UIColor colorWithRed:0.971 green:1.000 blue:0.939 alpha:1.000];
    //设置圆角:
    _exchangeStateView.layer.masksToBounds = YES;
    _exchangeStateView.layer.cornerRadius = 8;
    _exchangeStateView.layer.borderWidth = 4;
    _exchangeStateView.layer.borderColor = [UIColor redColor].CGColor;
    _exchangeStateView.clipsToBounds = YES;
    
    _exchangeStateView.exchangeState.isFront = YES;
    _exchangeStateView.exchangeState.delegate = self;

    [_exchangeStateView.chooseInfoBtn addTarget:self action:@selector(didClickedChooseInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_exchangeStateView.addPhotoBtn addTarget:self action:@selector(didClickedAddPhotoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_exchangeStateView.changeBgBtn addTarget:self action:@selector(didClickedChangeBgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_exchangeStateView.saveBtn addTarget:self action:@selector(didClickedSaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_exchangeStateView.cancelBtn addTarget:self action:@selector(didClickedCancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_exchangeStateView.hideBtn addTarget:self action:@selector(didClickedHideBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_doodleScrollView addSubview:_exchangeStateView];
    [_exchangeStateView release];
    
    //添加辅助视图
    _doodleStrokePV = [[DoodleStrokeInfoPickerView alloc] initWithFrame:CGRectMake(- 140, (kMainScreenHeight - 300 - 20) /2, 140, 216)];
    _doodleStrokePV.doodleStrokeDelegate = _doodleView; //设置代理
    [self.view addSubview:_doodleStrokePV];
    [_doodleStrokePV release];
    
    _typeFaceInfoPV = [[TypeFaceInfoPickerView alloc] initWithFrame:CGRectMake(kMainScreenWidth, (kMainScreenHeight - 300 - 20) /2, 270, 216)];
    _typeFaceInfoPV.typefaceDelegate = _doodleScrollView;//设置代理
    [self.view addSubview:_typeFaceInfoPV];
    [_typeFaceInfoPV release];
    
    //添加背景选纯色选择视图
    _changeBgColorView = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenWidth, (kMainScreenHeight - 300 - 20) /2, 70, 256)];
    
    DoodleBgColorPickerView *_doodleBgColorPV = [[DoodleBgColorPickerView alloc] initWithFrame:CGRectMake(0, 0, 70, 216)];
    _doodleBgColorPV.bgDelegate = self;
    [_changeBgColorView addSubview:_doodleBgColorPV];
    [_doodleBgColorPV release];
    //加确定按钮
    UIButton *_sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.layer.cornerRadius = 6;
    _sureBtn.layer.borderWidth = 2;
    _sureBtn.layer.borderColor = [UIColor clearColor].CGColor;
    _sureBtn.clipsToBounds = YES;
    _sureBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
    _sureBtn.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:20];
    
    _sureBtn.frame = CGRectMake(0, 216, 70, 40);
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(didClickedSureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_changeBgColorView addSubview:_sureBtn];
    
    [self.view addSubview:_changeBgColorView];
    [_changeBgColorView release];
    //添加背景视图
    _backgroundImageView = [[UIImageView alloc] initWithFrame:_doodleScrollView.bounds];
    _backgroundImageView.backgroundColor = [UIColor colorWithRed:0.232 green:1.000 blue:0.462 alpha:1.000];
    [_doodleScrollView insertSubview:_backgroundImageView atIndex:0];
    [_backgroundImageView release];
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviews];
    [self.view bringSubviewToFront:_exchangeStateView];
}
//隐藏所有辅助页面的方法
- (void)hiddenAllAccessoryView
{
    _doodleStrokePV.frame = CGRectMake(- 140, (kMainScreenHeight - 300 - 20) /2, 140, 216);
    _typeFaceInfoPV.frame = CGRectMake(kMainScreenWidth, (kMainScreenHeight - 300 - 20) /2, 280, 216);
    _changeBgColorView.frame = CGRectMake(kMainScreenWidth, (kMainScreenHeight - 300 - 20) /2, 70, 256);
    if (_exchangeStateView.exchangeState.isFront ) {
        [_exchangeStateView.chooseInfoBtn setTitle:@"画笔" forState:UIControlStateNormal];
        _exchangeStateView.chooseInfoBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
        _doodleView.undoButto.alpha = 1;
    }else{
        [_exchangeStateView.chooseInfoBtn setTitle:@"字体" forState:UIControlStateNormal];
        _exchangeStateView.chooseInfoBtn.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
//        _doodleView.undoButto.alpha = 0;
    }
//    _doodleScrollView.userInteractionEnabled = YES;
}
#pragma mark -----按钮的点击事件------
//RS_Switch的代理事件----
-(void)clicked:(BOOL)isFront
{
    [self hiddenAllAccessoryView];
    if (isFront) {
        NSLog(@"front button selected");
        [_exchangeStateView.chooseInfoBtn setTitle:@"画笔" forState:UIControlStateNormal];
        _doodleScrollView.inputStae = NO;
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        _doodleView.userInteractionEnabled = YES;
        _doodleView.undoButto.alpha = 1;
    } else {
        NSLog(@"back button selected");
        [_exchangeStateView.chooseInfoBtn setTitle:@"字体" forState:UIControlStateNormal];
        _doodleScrollView.inputStae = YES;
        _doodleView.userInteractionEnabled = NO;

    }
}

- (void)didClickedChooseInfoBtnAction:(UIButton *)button
{
    [self hiddenAllAccessoryView];
    if ([button.titleLabel.text isEqualToString:@"画笔"]) {
//        NSLog(@"画笔");
        _doodleStrokePV.frame =CGRectMake(50, (kMainScreenHeight - 300 - 20) /2, 140, 216);
        [self.view bringSubviewToFront:_doodleStrokePV];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:1.000 green:0.955 blue:0.082 alpha:1.000];
    }else if ([button.titleLabel.text isEqualToString:@"字体"]){
//        NSLog(@"字体");
        _typeFaceInfoPV.frame = CGRectMake(50, (kMainScreenHeight - 300 - 20) /2, 270, 216);
        [self.view bringSubviewToFront:_typeFaceInfoPV];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:1.000 green:0.955 blue:0.082 alpha:1.000];
    }else{
        if (_exchangeStateView.exchangeState.isFront ) {
            NSLog(@"11111");
            _doodleStrokePV.frame =CGRectMake(- 140, (kMainScreenHeight - 300 - 20) /2, 140, 216);
            [_exchangeStateView.chooseInfoBtn setTitle:@"画笔" forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
            _doodleView.undoButto.alpha = 1;
        }else{
            NSLog(@"22222");
            _typeFaceInfoPV.frame = CGRectMake(kMainScreenWidth, (kMainScreenHeight - 300 - 20) /2, 280, 216);
            [_exchangeStateView.chooseInfoBtn setTitle:@"字体" forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:1.000 green:0.824 blue:0.606 alpha:1.000];
        }
        _exchangeStateView.frame = CGRectMake(-48, (kMainScreenHeight - 350) /2, 50, 350);

    }
}

- (void)didClickedAddPhotoBtnAction:(UIButton *)button
{
    [self hiddenAllAccessoryView];
    _flag = kAddToDoodleScrollView;
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"添加图片", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相册", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                [self goPhoto];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相机", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                [self goCamera];
                            }];
    [actionSheet show];
    
}
- (void)didClickedChangeBgBtnAction:(UIButton *)button
{
    [self hiddenAllAccessoryView];
    _flag = kBackgroundImage;
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"更改画板背景", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"纯色画板", nil)
                              image:[UIImage imageNamed:@"Icon1"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                [self showChangeBgColorView];
                                NSLog(@"纯色画板");
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相册", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                [self goPhoto];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相机", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                [self goCamera];
                            }];
    
    [actionSheet show];
}

#pragma mark ---- 去相机相册点击事件处理 -----
//去相册/相机方法
-(void)goPhoto
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
    [pickerController release];
}

-(void)goCamera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *myimagePicker = [[UIImagePickerController alloc] init];
        myimagePicker.delegate = self;
        myimagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        myimagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        myimagePicker.allowsEditing = YES;
        [self presentViewController:myimagePicker animated:YES completion:nil];
    }
    else {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您的设备没有摄像头！" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
        alert.rightBlock = ^() {
            
        };
    }
}
//去相册/相机选中图片执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info[UIImagePickerControllerOriginalImage] retain];
    
    //加载到视图上
    [self addImageViewInDoodleScrollViewWith:image withFlag:_flag];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//根据选择的图片做处理并加载到视图
-(void) addImageViewInDoodleScrollViewWith:(UIImage *)photo withFlag:(NSInteger )flag
{
    NSData *photoData = UIImageJPEGRepresentation(photo, 0.3);
    UIImage *image = [UIImage imageWithData:photoData];
    //做出判断，是加图还是换背景
    if (_flag == 50) {
        //给加上去的图片加相框的感觉
        GBPathImageView *addImageView = [[GBPathImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200) image:image pathType:GBPathImageViewTypeSquare pathColor:[UIColor orangeColor] borderColor:[UIColor redColor] pathWidth:6.0];
        addImageView.userInteractionEnabled = YES;
        
        //加移动手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        [addImageView addGestureRecognizer:panGesture];
        [panGesture release];
        //加长按手势
        UILongPressGestureRecognizer *lpGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lpGesture:)];
        [addImageView addGestureRecognizer:lpGesture];
        [lpGesture release];
        //加粘合手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
        [addImageView addGestureRecognizer:pinchGesture];
        [pinchGesture release];
        //加旋转手势
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
        [addImageView addGestureRecognizer:rotationGesture];
        [rotationGesture release];
        
        [_doodleScrollView addSubview:addImageView];
        [addImageView release];
        [photo release];
    }else{
        _backgroundImageView.image = image;
    }
    
    
}
- (void)didClickedSaveBtnAction:(UIButton *)button
{
    [self hiddenAllAccessoryView];
    [self didClickedHideBtnAction:nil];
    _exchangeStateView.alpha = 0;
    _doodleView.undoButto.alpha = 0;
    [self performSelector:@selector(showScreenshotImageView) withObject:nil afterDelay:0.2];
}
- (void)showScreenshotImageView
{
    UIImage *screenImage = [self screenshot:UIDeviceOrientationPortrait isOpaque:YES usePresentationLayer:YES];
    UIImageView *scrrenImageView = [[UIImageView alloc] initWithFrame:_doodleScrollView.bounds];
    scrrenImageView.image = screenImage;
    scrrenImageView.transform = CGAffineTransformScale(scrrenImageView.transform,0.8, 0.8);
    scrrenImageView.transform = CGAffineTransformRotate(scrrenImageView.transform,M_PI / 18);
    //设边框
    scrrenImageView.layer.borderWidth =3;
    scrrenImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    scrrenImageView.layer.masksToBounds = YES;
    scrrenImageView.layer.cornerRadius = 5;
    scrrenImageView.clipsToBounds = YES;
    
    [self.view addSubview:scrrenImageView];
    [scrrenImageView release];
    
    _doodleScrollView.backgroundColor = [UIColor grayColor];
    _doodleScrollView.alpha = 0.3;
    _doodleScrollView.userInteractionEnabled = NO;
    
    DXAlertView *imageAlertView = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"保存后不能修改,确定保存？" leftButtonTitle:@"修改" rightButtonTitle:@"确定"];
    [imageAlertView show];
    imageAlertView.leftBlock = ^() {
        [scrrenImageView removeFromSuperview];
        _doodleScrollView.backgroundColor = [UIColor clearColor];
        _doodleScrollView.alpha = 1;
        _doodleScrollView.userInteractionEnabled = YES;
        _doodleView.undoButto.alpha = 1;
        _exchangeStateView.alpha = 1;
    };
    imageAlertView.rightBlock = ^() {
        //保存到数据库
        [self updateSqliteWith:screenImage];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}
- (void)didClickedCancelBtnAction:(UIButton *)button
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self hiddenAllAccessoryView];
    DXAlertView *backAlertView = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"返回后将丢失编辑" leftButtonTitle:@"留在此页" rightButtonTitle:@"返回"];
    [backAlertView show];
   
    backAlertView.rightBlock = ^() {
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark -------将图片添加到数据库--------
- (void)updateSqliteWith:(UIImage *)doodleImage
{
    /**
     保存到数据库
     */
    //1、打开数据库
    //设置数据库路劲
    NSString *sqPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"JJFlyDiary_001.sqlite"];
    FMDatabase *_db = [[FMDatabase alloc]initWithPath:sqPath];
    
    //打开数据库
    if (![_db open]) {
        [_db release];
        return;
    }
    //2、判断表是否存在，不存在创建
    if ( ![_db tableExists:@"MyDoodle"] ) {
        [_db executeUpdate:@"CREATE TABLE MyDoodle (doodleTime text NOT NULL PRIMARY KEY UNIQUE,ImageDate blob NOT NULL)"];
    }
    //3、判断此数据库中是否有该日期日记，有的话修改，没有的话添加
    //获取当天日期
    NSDate *doodleDay = [NSDate date];
    NSDateFormatter *theFormatter = [[NSDateFormatter alloc] init];
    theFormatter.dateFormat = kDoodleDateFormat;
    NSString *doodleDayStr = [theFormatter stringFromDate:doodleDay];
    [theFormatter release];
    
    //数据库操作
    [_db executeUpdateWithFormat:@"INSERT INTO MyDoodle VALUES(%@,%@)",doodleDayStr,UIImagePNGRepresentation(doodleImage),nil];//添加
}

#pragma mark -----截屏方法------
- (UIImage *)screenshot:(UIDeviceOrientation)orientation isOpaque:(BOOL)isOpaque usePresentationLayer:(BOOL)usePresentationLayer
{
    CGSize size;
    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        size = CGSizeMake(self.view.frame.size.width, _doodleScrollView.frame.size.height);
    } else {
        size = CGSizeMake(self.view.frame.size.height, _doodleScrollView.frame.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0.0);
    
    if (usePresentationLayer) {
        [self.view.layer.presentationLayer renderInContext:UIGraphicsGetCurrentContext()];
    } else {
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didClickedHideBtnAction:(UIButton *)button
{
    _doodleScrollView.userInteractionEnabled = YES;
    _exchangeStateView.frame = CGRectMake(-48, (kMainScreenHeight - 350) /2, 50, 350);
}
- (void)showChangeBgColorView
{
    _changeBgColorView.frame = CGRectMake(kMainScreenWidth - 70, (kMainScreenHeight - 300 - 20) /2, 70, 256);
}
- (void)didClickedSureBtnAction:(UIButton *)sureBtn
{
    _changeBgColorView.frame = CGRectMake(kMainScreenWidth , (kMainScreenHeight - 300 - 20) /2, 70, 256);
}

#pragma mark ---------DoodleBgColorPickerViewDelegate事件实现 ---------
-(void)changeDoodleBackgroundColorWith:(UIColor *)color
{
    _backgroundImageView.image = nil;
    _backgroundImageView.backgroundColor = color;
    NSLog(@"11111");
}

#pragma mark ---------手势事件实现 ---------
-(void)panView:(UIPanGestureRecognizer *)gesture
{
//    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint offsetPoint = [gesture translationInView:gesture.view];
        //判断上左右边距，不让移出边框;
        //        if ((gesture.view.frame.origin.x + gesture.view.frame.size.width  + offsetPoint.x< kMainScreenWidth -1)&& (gesture.view.frame.origin.x  + offsetPoint.x > 1) && (gesture.view.frame.origin.y + offsetPoint.y > 1)){
        gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, offsetPoint.x, offsetPoint.y);
        [gesture setTranslation:CGPointZero inView:gesture.view];
        //        }

//    }
}
-(void )lpGesture:(UILongPressGestureRecognizer *)lpGesture
{
    if (lpGesture.state == UIGestureRecognizerStateBegan) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Tips" contentText:@"确定删除本照片？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [alert show];
        alert.rightBlock = ^() {
            [lpGesture.view removeFromSuperview];
        };
    }
}

-(void)pinchAction:(UIPinchGestureRecognizer *)pinchGesture
{
    pinchGesture.view.transform = CGAffineTransformScale(pinchGesture.view.transform,pinchGesture.scale, pinchGesture.scale);
    pinchGesture.scale = 1;
}

-(void)rotationAction:(UIRotationGestureRecognizer *)rotationGesture
{
    rotationGesture.view.transform = CGAffineTransformRotate(rotationGesture.view.transform, rotationGesture.rotation);
    rotationGesture.rotation = 0;
}
- (void)showExchaneStateView
{
    _exchangeStateView.frame = CGRectMake(0, (kMainScreenHeight - 350) /2, 50, 350);
}
#pragma mark  ------ 键盘监听及处理 -----
- (void) viewDidAppear:(BOOL)paramAnimated{
    [super viewDidAppear:paramAnimated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(handleKeyboardWillShow:)
                   name:UIKeyboardWillShowNotification //键盘将出现事件监听
                 object:nil];
    
    [center addObserver:self selector:@selector(handleKeyboardWillHide:)
                   name:UIKeyboardWillHideNotification //键盘将隐藏事件监听
                 object:nil];
    
    [center addObserver:self selector:@selector(handleKeyboardWillChange:)
                   name:UIKeyboardWillChangeFrameNotification//键盘将改变高度事件监听
                 object:nil];
}
- (void) viewDidDisappear:(BOOL)paramAnimated {
    [super viewDidDisappear:paramAnimated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘相应变化时候走的方法
- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *keyboardEndRectObject =[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndRect = CGRectMake(0,0, 0, 0);
    [keyboardEndRectObject getValue:&keyboardEndRect];
    CGFloat keyHeight = keyboardEndRect.size.height;
    CGRect tmpRect = _doodleScrollView.frame;
    
    tmpRect.size.height = kMainScreenHeight - keyHeight;
    _doodleScrollView.frame = tmpRect;
//    [_doodleScrollView flashScrollIndicators];
}

- (void)handleKeyboardWillChange:(NSNotification *)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *keyboardEndRectObject =[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndRect = CGRectMake(0,0, 0, 0);
    [keyboardEndRectObject getValue:&keyboardEndRect];
    CGFloat keyHeight = keyboardEndRect.size.height;
    CGRect tmpRect = _doodleScrollView.frame;
    tmpRect.size.height = kMainScreenHeight - keyHeight;
    _doodleScrollView.frame = tmpRect;
}

- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    _doodleScrollView.contentOffset = CGPointMake(0, 0);
    _doodleScrollView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight );
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
