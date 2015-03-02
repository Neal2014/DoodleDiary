//
//  EdtingDiaryViewController.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "EdtingDiaryViewController.h"
#import "HeaderInfoView.h"
#import "EdtingDiaryTextView.h"
#import "InputAccessoryView.h"
#import "DiaryModel.h"
#import "TypefacePickerView.h"
#import "CustomKeyView.h"
#import "TypefaceModel.h"
#import "FeelingMapFrameView.h"
#import "WeatherFrameView.h"
#import "LetterPaperFrameView.h"
#import "DiaryDetailViewController.h"
@interface EdtingDiaryViewController ()
{
    HeaderInfoView *_headerInfoView;
    EdtingDiaryTextView *_edtingDiaryTV;
    InputAccessoryView *_inputAccessoryView;
    TypefacePickerView *typefacePV;
    CustomKeyView *faceMapKBV;
    FeelingMapFrameView *_feelingMapFrameView;
    WeatherFrameView *_weatherFrameView;
    LetterPaperFrameView *_letterPaperFrameView;
    UIImageView *_letterPaperImageView;
    FMDatabase *_db;
    DiaryModel *_theMoedl;
}
@end

@implementation EdtingDiaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO; //防止scrollview内部受到坐标受到影响;
    }
    return self;
}
-(void)addSubviews
{
    //加载头View
    _headerInfoView = [[HeaderInfoView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 60)];
    _headerInfoView.backgroundColor = [UIColor clearColor];
    [_headerInfoView.feelingBtn addTarget:self action:@selector(didClickedFeelingBtnBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerInfoView.weatherBtn addTarget:self action:@selector(didClickedWeatherBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerInfoView.letterPaperBtn addTarget:self action:@selector(didClickedLetterPaperBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headerInfoView];
    [_headerInfoView release];
    
    //加载编辑框
    _edtingDiaryTV = [[EdtingDiaryTextView alloc] initWithFrame:CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight- 60 - 64)];
    _edtingDiaryTV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_edtingDiaryTV];
    [_edtingDiaryTV release];
    
    //加载键盘辅助视图
    _inputAccessoryView  = [[InputAccessoryView alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
    _edtingDiaryTV.inputAccessoryView = _inputAccessoryView;
    [_inputAccessoryView.choosePhotoBtn addTarget:self action:@selector(didClickedChoosePhotoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _inputAccessoryView.delegate = _edtingDiaryTV;
    [_inputAccessoryView release];
    
    
    //背景
    _letterPaperImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 62)];
    _letterPaperImageView.contentMode = UIViewContentModeScaleAspectFill; //设置图片放置方式，这里选填充
    _letterPaperImageView.image = [UIImage imageNamed:@"letterPage1.jpg"];//加载默认信纸
    [self.view insertSubview:_letterPaperImageView atIndex:0];
    [_letterPaperImageView release];
    
    //----------------------加载附件视图----------------------//
    //加载PickerView
    typefacePV = [[TypefacePickerView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth , 216)];
    typefacePV.typefaceDelegate = _edtingDiaryTV; //设代理
    [self.view addSubview:typefacePV];
    [typefacePV release];
    
    
    //加载CustomKeyboardView
    faceMapKBV = [[CustomKeyView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 200)];
    faceMapKBV.delegate = _edtingDiaryTV; //设代理
    [self.view addSubview:faceMapKBV];
    [faceMapKBV release];
    
    //将上面三个传值给键盘辅助视图，方便响应点击处理
    _inputAccessoryView.typefacePV = typefacePV;
    _inputAccessoryView.faceMapKBV = faceMapKBV;
    
    
    //------------------------加载心情、背景、天气框---------------------//
    //心情框
    _feelingMapFrameView = [[FeelingMapFrameView alloc] initWithFrame:CGRectMake(0, -150, 320, 150)];
    _feelingMapFrameView.backgroundColor = [UIColor cyanColor];
    //block传值
    _feelingMapFrameView.feelingMapFrameBlock = ^(UIImage *feelingimage){
        [_headerInfoView.feelingBtn setBackgroundImage:feelingimage forState:UIControlStateNormal];
        _feelingMapFrameView.frame = CGRectMake(0, -150, 320, 150);
        _edtingDiaryTV.userInteractionEnabled = YES;
    };
    [self.view addSubview:_feelingMapFrameView];
    [_feelingMapFrameView release];
    
    //天气框
    _weatherFrameView = [[WeatherFrameView alloc] initWithFrame:CGRectMake(0, -150, 320, 150)];
    _weatherFrameView.backgroundColor = [UIColor purpleColor];
    _weatherFrameView.weatherFrameBlock = ^(UIImage *weatherImage){
        [_headerInfoView.weatherBtn setBackgroundImage:weatherImage forState:UIControlStateNormal];
        _weatherFrameView.frame = CGRectMake(0, -150, 320, 150);
        _edtingDiaryTV.userInteractionEnabled = YES;
        
        
    };
    [self.view addSubview:_weatherFrameView];
    [_weatherFrameView release];
    
    //背景框
    _letterPaperFrameView = [[LetterPaperFrameView alloc] initWithFrame:CGRectMake(0, -150, 320, 150)];
    _letterPaperFrameView.backgroundColor = [UIColor redColor];
    _letterPaperFrameView.letterPaperFrameBlock = ^(UIImage *letterPaperImage){
        [_headerInfoView.letterPaperBtn setBackgroundImage:letterPaperImage forState:UIControlStateNormal];
        _letterPaperFrameView.frame = CGRectMake(0, -150, 320, 150);
        _edtingDiaryTV.userInteractionEnabled = YES;
        //设置背景色
        _letterPaperImageView.image = letterPaperImage;
    };
    [self.view addSubview:_letterPaperFrameView];
    [_letterPaperFrameView release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"编写日记";
    
    //保存按钮
    UIBarButtonItem *saveBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedSaveBarBtnItemAction:)];
    self.navigationItem.rightBarButtonItem = saveBarBtnItem;
    [saveBarBtnItem release];
    
    //重写返回按钮
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBackBarBtnItemAction:)];
    self.navigationItem.leftBarButtonItem = backBarBtnItem;
    [backBarBtnItem release];
    
    [self addSubviews];
    
}
#pragma mark ----ChoosePhotoBtn的点击事件处理-----
-(void)didClickedChoosePhotoBtnAction:(UIButton *)choosePhotoBtn
{
    //编辑框执行返回按钮操作
    [_inputAccessoryView didClickedReturnKeyboardBtnAction:nil];
    
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"为日记添加图片", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相册", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Info tapped");
                                UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                                pickerController.delegate = self;
                                [self presentViewController:pickerController animated:YES completion:nil];
                                [pickerController release];
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"相机", nil)
                              image:nil
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"相机");
                                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                {
                                    UIImagePickerController *myimagePicker = [[UIImagePickerController alloc] init];
                                    myimagePicker.delegate = self;
                                    myimagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    myimagePicker.modalTransitionStyle = UIModalTransitionStylePartialCurl;
                                    myimagePicker.allowsEditing = YES;
                                    [self presentViewController:myimagePicker animated:YES completion:nil];
                                }
                                else {
                                    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您的设备没有摄像头！" leftButtonTitle:nil rightButtonTitle:@"确定"];
                                    [alert show];
                                    alert.rightBlock = ^() {
                                        
                                    };
                                }
                            }];
    [actionSheet show];
}

//去相册/相机选中图片执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info[UIImagePickerControllerOriginalImage] retain];
    //代理传值
    [_inputAccessoryView.delegate addPhotofromPhoneToEdtingDiary:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----- navBarBtnItem的点击事件----------
- (void)didClickedSaveBarBtnItemAction:(UIBarButtonItem *)saveBarBtnItem
{
    /**
     将所有要存的东西转成能存储的类型,然后赋值给model然后对model归档
     */
    //构建model对象
    _theMoedl = [[DiaryModel alloc] init];
    //赋值
    _theMoedl.dateLabelStr = _headerInfoView.dateLabel.text;
    _theMoedl.weatherBtnImageData = UIImagePNGRepresentation(_headerInfoView.weatherBtn.currentBackgroundImage);
    _theMoedl.feelingBtnImageData = UIImagePNGRepresentation(_headerInfoView.feelingBtn.currentBackgroundImage);
    _theMoedl.letterPaperBtnImageData = UIImagePNGRepresentation(_headerInfoView.letterPaperBtn.currentBackgroundImage);
    _theMoedl.letterPaperImageData = UIImagePNGRepresentation(_letterPaperImageView.image);
    _theMoedl.diaryText = _edtingDiaryTV.text;
    //存图像和frame    //存图像旋转信息  //bounds
    NSMutableArray *rotationArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (UIImageView *myImageView in _edtingDiaryTV.imageViewArray) {
        [_edtingDiaryTV.imageArray addObject:UIImagePNGRepresentation(myImageView.image)];
        
        CGFloat radius = atan2f(myImageView.transform.b, myImageView.transform.a);
        CGFloat degree = radius * (180 / M_PI);
        [rotationArray addObject:[NSNumber numberWithFloat:degree]];

        myImageView.transform = CGAffineTransformRotate(myImageView.transform, - M_PI * degree / 180);
        
        [_edtingDiaryTV.imageViewRectArray addObject:NSStringFromCGRect(myImageView.frame)];
    }
    _theMoedl.imageArray = _edtingDiaryTV.imageArray;
    _theMoedl.imageViewRectArray = _edtingDiaryTV.imageViewRectArray;
    _theMoedl.imageRotationArray = rotationArray;
    [rotationArray release];
    
    //存颜色
    NSUInteger num = CGColorGetNumberOfComponents(_edtingDiaryTV.textColor.CGColor);
    const CGFloat *colorComponents = CGColorGetComponents(_edtingDiaryTV.textColor.CGColor);
    NSMutableArray *colorRGBArray = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<num; i++)
    {
        [colorRGBArray addObject:@(colorComponents[i])];
    }
    _theMoedl.diaryTextRGBArray = colorRGBArray;
    
    //存font
     NSMutableArray *fontArray = [NSMutableArray arrayWithCapacity:1];
    [fontArray addObject:_edtingDiaryTV.font.fontName];
    [fontArray addObject:@(_edtingDiaryTV.font.pointSize)];
    _theMoedl.diaryTextFontArray = fontArray;
    
    //归档
    NSMutableData *diaryModelData = [NSMutableData dataWithCapacity:1];
    
    NSKeyedArchiver *achiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:diaryModelData];
    
    [achiver encodeObject:_theMoedl forKey:kEncodeKey];
    
    [achiver finishEncoding];
    [achiver release];

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
    if ( ![_db tableExists:@"MyDiary"] ) {
        [_db executeUpdate:@"CREATE TABLE MyDiary (writeTime text NOT NULL PRIMARY KEY UNIQUE,writeDay text NOT NULL,diaryData blob,imageData blob)"];
    }
    //3、判断此数据库中是否有该日期日记，有的话修改，没有的话添加
    //获取当天日期
    NSDate *writeDay = [NSDate date];
    NSDateFormatter *theFormatter = [[NSDateFormatter alloc] init];
    theFormatter.dateFormat = kWriteDaydateFormat;
    NSString *writeDayStr = [theFormatter stringFromDate:writeDay];
    [theFormatter release];
    
    //数据库操作
    
    [_db executeUpdateWithFormat:@"INSERT INTO MyDiary VALUES(%@,%@,%@,%@)",_theMoedl.dateLabelStr,writeDayStr,diaryModelData,nil];//添加
    
    
    DXAlertView *saveAlert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"保存成功" leftButtonTitle:@"返回" rightButtonTitle:@"去查看"];
    [saveAlert show];
    saveAlert.leftBlock = ^() {
        [self.navigationController popViewControllerAnimated:YES];
    };
    saveAlert.rightBlock = ^() {
        DiaryDetailViewController *diaryDetalVC = [[DiaryDetailViewController alloc] init];
        diaryDetalVC.detailDiaryModel = _theMoedl;
        [self.navigationController pushViewController:diaryDetalVC animated:YES];
        [diaryDetalVC release];
    };
}

- (void)didClickedBackBarBtnItemAction:(UIBarButtonItem *)backBarBtnItem
{
    DXAlertView *backAlertView = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"返回后将丢失编辑" leftButtonTitle:@"留在此页" rightButtonTitle:@"返回"];
    [backAlertView show];
    
    backAlertView.rightBlock = ^() {
       [self.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark -------- HeaderInfoView中Button属性的点击事件处理
-(void)didClickedFeelingBtnBtnAction:(UIButton *)feelingBtn
{
    //让别的框消失并取消编辑框的交互
    _edtingDiaryTV.userInteractionEnabled = NO;
    _weatherFrameView.frame = CGRectMake(0, -150, 320, 150);
    _letterPaperFrameView.frame = CGRectMake(0, -150, 320, 150);
    //弹出相应框
     _feelingMapFrameView.frame = CGRectMake(0, 65, 320, 150);
}
-(void)didClickedWeatherBtnAction:(UIButton *)weatherBtn
{
    //让别的框消失并取消编辑框的交互
    _edtingDiaryTV.userInteractionEnabled = NO;
    _feelingMapFrameView.frame = CGRectMake(0, -150, 320, 150);
    _letterPaperFrameView.frame = CGRectMake(0, -150, 320, 150);
    //弹出相应框
    _weatherFrameView.frame = CGRectMake(0, 65, 320, 150);
}
-(void)didClickedLetterPaperBtnAction:(UIButton *)letterPaperBtn
{
    //让别的框消失并取消编辑框的交互
    _edtingDiaryTV.userInteractionEnabled = NO;
    _weatherFrameView.frame = CGRectMake(0, -150, 320, 150);
    _feelingMapFrameView.frame = CGRectMake(0, -150, 320, 150);
    //弹出相应框
    _letterPaperFrameView.frame = CGRectMake(0, 65, 320, 150);
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
                   name:UIKeyboardDidChangeFrameNotification//键盘将改变高度事件监听
                 object:nil];
}
- (void) viewDidDisappear:(BOOL)paramAnimated {
    [super viewDidDisappear:paramAnimated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//键盘相应变化时候走的方法
- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    if (self.navigationController.isNavigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *keyboardEndRectObject =[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndRect = CGRectMake(0,0, 0, 0);
    [keyboardEndRectObject getValue:&keyboardEndRect];
    CGFloat keyHeight = keyboardEndRect.size.height;
    CGRect tmpRect = _edtingDiaryTV.frame;
    CGFloat position_y = _edtingDiaryTV.frame.origin.y ;
  
    tmpRect.size.height = kMainScreenHeight - keyHeight - position_y;
    _edtingDiaryTV.frame = tmpRect;
}

- (void)handleKeyboardWillChange:(NSNotification *)paramNotification
{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *keyboardEndRectObject =[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndRect = CGRectMake(0,0, 0, 0);
    [keyboardEndRectObject getValue:&keyboardEndRect];
    CGFloat keyHeight = keyboardEndRect.size.height;
    CGRect tmpRect = _edtingDiaryTV.frame;
    
    if (typefacePV.frame.origin.y != kMainScreenHeight) {
        tmpRect.size.height = kMainScreenHeight  - keyHeight - 216 - 60;
        tmpRect.origin.y = 60;
    }else if (faceMapKBV.frame.origin.y != kMainScreenHeight){
        tmpRect.size.height = kMainScreenHeight  - keyHeight - 200 - 60;
        tmpRect.origin.y = 60;
    }
    _edtingDiaryTV.frame = tmpRect;
}

- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    _edtingDiaryTV.frame = CGRectMake(0, 60, kMainScreenWidth, kMainScreenHeight- 60 - 64);
    if (self.navigationController.isNavigationBarHidden == YES ) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    NSLog(@"33333");
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
