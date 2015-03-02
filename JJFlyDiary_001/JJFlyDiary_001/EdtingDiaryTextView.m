//
//  EdtingDiaryTextView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "EdtingDiaryTextView.h"
#import "TypefaceModel.h"
#import "EdtingDiaryViewController.h"
#import "GBPathImageView.h"
@implementation EdtingDiaryTextView
-(void)dealloc
{
    [_exclusionPathsArray release];
    [_imageViewRectArray release];
    [_imageArray release];
    [_webViewRectArray release];
    [_gifDataArray release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = self;
        self.backgroundColor = [UIColor greenColor];
        self.tag = noDisableVerticalScrollTag;
        [self prepareData];
        //设置默认颜色和字体
        self.font = [UIFont fontWithName:@"Thonburi-Bold" size:14];
        self.textColor = [UIColor colorWithRed:1.000 green:0.073 blue:0.175 alpha:1.000];
//        self.contentOffset = CGPointMake(0, 30);
    }
    return self;
}

//准备数据
-(void)prepareData
{
    _imageArray = [[NSMutableArray alloc] initWithCapacity:1];
    _imageViewArray = [[NSMutableArray alloc] initWithCapacity:1];
    _imageViewRectArray =[[NSMutableArray alloc] initWithCapacity:1];
    _webViewRectArray = [[NSMutableArray alloc] initWithCapacity:1];
    _gifDataArray = [[NSMutableArray alloc] initWithCapacity:1];
    _exclusionPathsArray = [[NSMutableArray alloc] initWithCapacity:1];
    
}

#pragma mark ---gif,image的坏绕路径
-(UIBezierPath *)translatedBzierPath:(CGRect )rect
{
    CGRect imageRect = [self convertRect:CGRectMake(rect.origin.x -3 , rect.origin.y - 5, rect.size.width, rect.size.height-3) fromView:self];
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:imageRect];
    return newPath;
}


#pragma mark ----实现  UITextViewDelegate 的代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self flashScrollIndicators];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self flashScrollIndicators];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    //让编辑状态下如果实际内容大于显示区域，滚动条一直存在
    [self flashScrollIndicators];
}


#pragma mark ----实现  TypefacePickerViewDelegate 的代理方法
-(void)changeTypefaceInfoForEdtingDiaryTextView:(TypefaceModel *)typefaceModel
{
    self.font = typefaceModel.typefaceFont;
    self.textColor = typefaceModel.typefaceColor;
}

#pragma mark ----实现  InputAccessoryViewDelegate 的代理方法
-(void)changeEdtingDiaryInputView:(UIView *)inputView
{
    [self resignFirstResponder];
    self.inputView = inputView;
    [self becomeFirstResponder];
}


-(void)addPhotofromPhoneToEdtingDiary:(UIImage *)photo
{
    NSData *photoData = UIImageJPEGRepresentation(photo, 0.3);
    UIImage *image = [UIImage imageWithData:photoData];
    //加相框
    GBPathImageView *addImageView = [[GBPathImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200) image:image pathType:GBPathImageViewTypeSquare pathColor:[UIColor colorWithRed:1.000 green:0.525 blue:0.461 alpha:1.000] borderColor:[UIColor colorWithRed:0.492 green:0.458 blue:1.000 alpha:1.000] pathWidth:6.0];
    addImageView.userInteractionEnabled = YES;
    //    addImageView.userInteractionEnabled = NO;//设置背景得时候换张图片就行，把交互关掉即可,默认是关掉;
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
    
    
    [self addSubview:addImageView];
    [_imageViewArray addObject:addImageView]; //加入图像数组;
    [addImageView release];
    
    //设置占位
    [_exclusionPathsArray addObject:[self translatedBzierPath:addImageView.frame]];
    self.textContainer.exclusionPaths = _exclusionPathsArray;
    [photo release];
}
-(void)panView:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint offsetPoint = [gesture translationInView:gesture.view];
        //判断上左右边距，不让移出边框;
        if ((gesture.view.frame.origin.x + gesture.view.frame.size.width  + offsetPoint.x< kMainScreenWidth -1)&& (gesture.view.frame.origin.x  + offsetPoint.x > 1) && (gesture.view.frame.origin.y + offsetPoint.y > 1)){
            gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, offsetPoint.x, offsetPoint.y);
            [gesture setTranslation:CGPointZero inView:gesture.view];
        }
        //设置占位
        //先取出该图像在所在下标
        NSInteger index = [_imageViewArray indexOfObject:gesture.view];
        
        //用现在的替换上一次状态
        [_exclusionPathsArray replaceObjectAtIndex:index withObject:[self translatedBzierPath:gesture.view.frame]];
        self.textContainer.exclusionPaths = _exclusionPathsArray;
    }
}
-(void )lpGesture:(UILongPressGestureRecognizer *)lpGesture
{
    if (lpGesture.state == UIGestureRecognizerStateBegan) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Tips" contentText:@"确定删除本照片？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [alert show];
        
        alert.rightBlock = ^() {
            _lpGestureImageIndex = [_imageViewArray indexOfObject:lpGesture.view];
            UIImageView *tmpImageView = _imageViewArray[_lpGestureImageIndex];
            [tmpImageView removeFromSuperview];
            [_imageViewArray removeObjectAtIndex:_lpGestureImageIndex];
            [_exclusionPathsArray removeObjectAtIndex:_lpGestureImageIndex];
            self.textContainer.exclusionPaths = _exclusionPathsArray;
        };
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImageView *tmpImageView = _imageViewArray[_lpGestureImageIndex];
        [tmpImageView removeFromSuperview];
        [_imageViewArray removeObjectAtIndex:_lpGestureImageIndex];
        [_exclusionPathsArray removeObjectAtIndex:_lpGestureImageIndex];
        self.textContainer.exclusionPaths = _exclusionPathsArray;
    }
}


-(void)pinchAction:(UIPinchGestureRecognizer *)pinchGesture
{
    pinchGesture.view.transform = CGAffineTransformScale(pinchGesture.view.transform,pinchGesture.scale, pinchGesture.scale);
    CGRect ViewBounds = pinchGesture.view.bounds;
    ViewBounds.size.width = ViewBounds.size.width * pinchGesture.scale;
    ViewBounds.size.height = ViewBounds.size.height * pinchGesture.scale;
    pinchGesture.view.bounds = ViewBounds;
    pinchGesture.scale = 1;
    
    //设置占位
    //先取出该图像在所在下标
    NSInteger index = [_imageViewArray indexOfObject:pinchGesture.view];
    
    //用现在的替换上一次状态
    [_exclusionPathsArray replaceObjectAtIndex:index withObject:[self translatedBzierPath:pinchGesture.view.frame]];
    self.textContainer.exclusionPaths = _exclusionPathsArray;
}

-(void)rotationAction:(UIRotationGestureRecognizer *)rotationGesture
{
    rotationGesture.view.transform = CGAffineTransformRotate(rotationGesture.view.transform, rotationGesture.rotation);
    rotationGesture.rotation = 0;
    
    //设置占位
    //先取出该图像在所在下标
    NSInteger index = [_imageViewArray indexOfObject:rotationGesture.view];
    
    //用现在的替换上一次状态
    [_exclusionPathsArray replaceObjectAtIndex:index withObject:[self translatedBzierPath:rotationGesture.view.frame]];
    self.textContainer.exclusionPaths = _exclusionPathsArray;

}
#pragma mark ----实现  CustomKeyViewDelegate 的代理方法
-(void)addElementToEdtingDiaryTextView:(id)object
{
    if ([object isKindOfClass:[NSData class]]) {
        //创建webview并加载data并且创建环绕路径
        
    }else if ([object isKindOfClass:[UIImage class]]){
        //创建imageview并加载data并且创建环绕路径
        
    }else{
        //插入光标目前位置
        NSRange range = [self selectedRange];
        NSMutableString *top = [[NSMutableString alloc] initWithString:[self text]];
        [top insertString:object atIndex:range.location];
        self.text = top;
        //插完后把光标移到下一个
        NSUInteger length = range.location + [object length];
        self.selectedRange = NSMakeRange(length,0);
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



@implementation UIImageView (ForScrollView)

- (void) setAlpha:(float)alpha {
    
    if (self.superview.tag == noDisableVerticalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin) {
            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.height < sc.contentSize.height) {
                    return;
                    
                }
            }
        }
    }
    
    if (self.superview.tag == noDisableHorizontalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
            if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.width < sc.contentSize.width) {
                    return;
                    
                }
            }
        }
    }
    [super setAlpha:alpha];
}
@end