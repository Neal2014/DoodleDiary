//
//  DoodleScrollView.m
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DoodleScrollView.h"
#import "DoodleModel.h"
#import "DoodleTextView.h"
@implementation DoodleScrollView
- (void)dealloc
{
    Block_release(_myBlock);
    [_textColorOfTextView release];
    [_fontOftextView release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isInPuting = NO;
        _isEdge = NO;
        _inputStae = NO;
        self.backgroundColor = [UIColor clearColor];
        self.bounces = NO;
        self.contentSize = frame.size;
        self.tag = noDisableHorizontalScrollTag;
        //设置默认画笔
        self.fontOftextView = [UIFont fontWithName:@"Thonburi-Bold" size:14];
        self.textColorOfTextView = [UIColor redColor];
    }
    return self;
}
#pragma mark ------ 实现  TypeFaceInfoPickerViewDelegate 代理的方法-------
-(void)changeTypefaceInfoForDoodleDiaryTextView:(DoodleModel *)doodleModel
{
    self.textColorOfTextView = doodleModel.typefaceColor;
    self.fontOftextView = doodleModel.typefaceFont;
}

#pragma mark ------- 重写自身touches的相关方法 ------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _myBlock();
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_inputStae == YES) {
        //获取点击点得坐标
        CGPoint point = [[touches anyObject] locationInView:self];
        if (_isInPuting == YES) {
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            _isInPuting = NO;
        }else{
            DoodleTextView *newTextView = [[DoodleTextView alloc] initWithFrame:CGRectMake(point.x, point.y - 17, _fontOftextView.pointSize+ 8,_fontOftextView.pointSize+ 8)];
            newTextView.delegate = self;
            //决定每次的text属性为选择器选中的颜色
            newTextView.font = _fontOftextView;
            newTextView.textColor = _textColorOfTextView;
            //pan
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
            [newTextView addGestureRecognizer:panGesture];
            [self addSubview:newTextView];
            [newTextView becomeFirstResponder];
            _isInPuting = YES;
        }

    }
}

#pragma mark ------ 通过 UITextViewDelegate 代理的方法操作textView  ----------
//在uitextview变化的时候变化frame
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGFloat tvpoint_x = textView.frame.origin.x;
    CGFloat tvWidth = textView.frame.size.width;
    if (tvpoint_x + tvWidth > [[UIScreen mainScreen] bounds].size.width - 8 ) {
        _isEdge = YES;
    }
    //给textview加边框
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 5.0;
    textView.layer.borderWidth = 2.0;
    textView.layer.borderColor = [[UIColor redColor] CGColor];
    _isInPuting = YES;
    /**
     * 如果输入框大于键盘高度并且小于主屏幕高度的相关操作
     */
    CGFloat tvpoint_y = textView.frame.origin.y;
    CGFloat tvHeight = textView.frame.size.height;
    
    if (tvpoint_y + tvHeight > kMainScreenHeight - 216 ) {
        self.contentOffset = CGPointMake(0, 216 );
    }else{
        self.contentOffset = CGPointMake(0, 0);
    }
    [self flashScrollIndicators]; //一直显示滚动条，方便用户知道可以上下拉
}

-(void)textViewDidChange:(UITextView *)textView
{
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    if (_isEdge == NO) {
        /**
         *  计算宽度
         */
        NSDictionary *textDic = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
        CGRect textRect = [textView.text boundingRectWithSize:CGSizeMake(2800000, frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
        frame.size.width = textRect.size.width +20;
    }
    textView.frame = frame;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    /**
     *  确保到屏幕最低时或、并最右边时不再允许收入
     */
    [self flashScrollIndicators]; //一直显示滚动条，方便用户知道可以上下拉
    CGFloat tvpoint_y = textView.frame.origin.y;
    CGFloat tvHeight = textView.frame.size.height;
    CGFloat tvpoint_x = textView.frame.origin.x;
    CGFloat tvWidth = textView.frame.size.width;
    if (tvpoint_y + tvHeight > [[UIScreen mainScreen] bounds].size.height - 10) {
        if ([text isEqualToString:@"\n"]) {
            return NO;
        }
    }
    if (tvpoint_x + tvWidth > [[UIScreen mainScreen] bounds].size.width - 8 ) {
        _isEdge = YES;
    }
    if (tvpoint_y + tvHeight > [[UIScreen mainScreen] bounds].size.height - 10 && tvpoint_x + tvWidth > [[UIScreen mainScreen] bounds].size.width - 8) {
        return NO;
    }
    return YES;
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    //判断取消空文本
    NSMutableString *tmpStr =[NSMutableString string];
    for (int i = 0; i < textView.text.length; i ++) {
        [tmpStr appendString:@" "];
    }
    if ([textView.text isEqualToString: tmpStr] ) {
        [textView removeFromSuperview];
    }
    //取消边框
    textView.layer.masksToBounds = NO;
    textView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    //重新计算高度，防止出现多一行的现象
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    if (_isEdge == NO) {
        NSDictionary *textDic = @{NSFontAttributeName: [UIFont systemFontOfSize:_fontOftextView.pointSize]};
        CGRect textRect = [textView.text boundingRectWithSize:CGSizeMake(2800000, frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
        frame.size.width = textRect.size.width +20;
    }
    textView.frame = frame;
    _isEdge = NO; //每次结束设置为NO;不然上次的结果影响下次使用
}
-(void)panView:(UIPanGestureRecognizer *)gesture
{
    CGPoint offsetPoint = [gesture translationInView:gesture.view];
    gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, offsetPoint.x, offsetPoint.y);
    [gesture setTranslation:CGPointZero inView:gesture.view];
}
@end


#pragma mark   ---------- 实现滚动条一直存在的方法(给UIImageView添加类目加如下方法)---------
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
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

