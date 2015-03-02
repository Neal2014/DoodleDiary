//
//  DoodleView.m
//  DooleDiary_001
//
//  Created by Neal Caffery on 14-11-13.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "DoodleView.h"
#import "DoodleViewModel.h"
#import "DoodleModel.h"
@implementation DoodleView
-(void)dealloc
{
    [_pathArray release];
    [_strokeLineColor release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        //设置画笔的颜色和粗细的初始值 PS:如果用随机色需要alloc，否则会被不定时释放掉，或者直接给定颜色，如redColor;
        _strokeLineColor = [UIColor redColor];
        _strokeLineWidth = 5;
        self.multipleTouchEnabled = NO;
        [self addSubviews];
    }
    return self;
}
//加按钮
-(void)addSubviews
{
    //撤销按钮
    _undoButto  = [UIButton buttonWithType:UIButtonTypeCustom];
    //设圆角等属性
    _undoButto.layer.masksToBounds = YES;
    _undoButto.layer.cornerRadius = 6;
    _undoButto.layer.borderWidth = 2;
    _undoButto.layer.borderColor = [UIColor clearColor].CGColor;
    _undoButto.clipsToBounds = YES;
    _undoButto.backgroundColor = [UIColor colorWithRed:1.000 green:0.086 blue:0.256 alpha:1.000];
    _undoButto.titleLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:18];
    
    _undoButto.frame = CGRectMake((self.frame.size.width - 40)/2, self.frame.size.height - 40, 40, 25);
    [_undoButto setTitle:@"撤销" forState:UIControlStateNormal];
    [_undoButto setTitleColor:[UIColor colorWithRed:0.961 green:1.000 blue:0.110 alpha:1.000] forState:UIControlStateNormal];
    [_undoButto setTitle:@"确定" forState:UIControlStateHighlighted];
    [_undoButto addTarget:self action:@selector(undoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_undoButto];
}
//button关联的方法

-(void)undoButtonClick:(UIButton *)undoButton
{
    [_pathArray removeLastObject];
    [self setNeedsDisplay];
    
}
#pragma mark    -----DoodleStrokeInfoPickerViewDelegate方法----
-(void)changeDoodleStrokeInfoForDoodleView:(DoodleModel *)doodleModel
{
    _strokeLineWidth = doodleModel.doodleStrokeWidth;
    self.strokeLineColor = doodleModel.doodleStrokeColor;
}
//点击事件触发管理的方法和设置
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawView:context];
}
- (void)drawView:(CGContextRef)context
{
    for (DoodleViewModel *myViewModel in _pathArray) {
        CGContextAddPath(context, myViewModel.path.CGPath);
        [myViewModel.color set];
        CGContextSetLineWidth(context, myViewModel.width);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (_isHavePath) {
        CGContextAddPath(context, _path);
        [_strokeLineColor set];
        CGContextSetLineWidth(context, _strokeLineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _myBlock();
    UITouch *touch = [touches anyObject];
    CGPoint location =[touch locationInView:self];
    _path = CGPathCreateMutable();
    _isHavePath = YES;
    CGPathMoveToPoint(_path, NULL, location.x, location.y);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPathAddLineToPoint(_path, NULL, location.x, location.y);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (_pathArray == nil) {
        _pathArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_path];
    DoodleViewModel *myViewModel = [DoodleViewModel viewModelWithColor:_strokeLineColor Path:path Width:_strokeLineWidth];
    [_pathArray addObject:myViewModel];
    
    CGPathRelease(_path);
    _isHavePath = NO;
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
