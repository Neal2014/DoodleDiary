//
//  CustomKeyView.m
//  EditingDiary_001
//
//  Created by Neal Caffery on 14-11-10.
//  Copyright (c) 2014年 郝育新. All rights reserved.
//

#import "CustomKeyView.h"
#import "FaceButton.h"
@implementation CustomKeyView
-(void)dealloc
{
    [_faceScrollView release];
    [_faceSourceArray release];
    [_selectFaceBtnStateView release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor purpleColor];
        [self prepareData];
        [self setSubviews];
    }
    return self;
}
#pragma mark   -------加载子视图和准备数据-----------
-(void)setSubviews
{
    //先创建父scroll  //大表情框
    _faceFrameScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    _faceFrameScrollView.contentSize = CGSizeMake(self.bounds.size.width*3, 160);
    _faceFrameScrollView.pagingEnabled = YES;
    _faceFrameScrollView.showsHorizontalScrollIndicator = NO;
    _faceFrameScrollView.delegate = self;
    

    //创建子scroll  //单独的小标情框
    _subFrameScrollView1 = [[SubFaceFrameScrollView alloc] init];
    [_subFrameScrollView1 setSubviewsInfoWithDataSourceArray:_face8Array];
    [_faceFrameScrollView addSubview:_subFrameScrollView1];
    [_subFrameScrollView1 release];
    
    _subFrameScrollView2 = [[SubFaceFrameScrollView alloc] init];
    _subFrameScrollView2.changPageDelegate = self;  //设置改变pageControlPage的代理
    [_subFrameScrollView2 setSubviewsInfoWithDataSourceArray:_face1Array];
    [_faceFrameScrollView addSubview:_subFrameScrollView2];
    [_subFrameScrollView2 release];
    
    _subFrameScrollView3 = [[SubFaceFrameScrollView alloc] init];
    [_subFrameScrollView3 setSubviewsInfoWithDataSourceArray:_face2Array];
    [_faceFrameScrollView addSubview:_subFrameScrollView3];
    [_subFrameScrollView3 release];
    
    [self setSubFaceFrameScrollViewFrame];
    
    CGPoint p = CGPointZero;
    p.x = _faceFrameScrollView.frame.size.width;
    [_faceFrameScrollView setContentOffset:p animated:NO];
    
    [self addSubview:_faceFrameScrollView];
    [_faceFrameScrollView release];
    
    //创建pagControl
    _facePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(80, 148, 160, 10)];
    _facePageControl.currentPage = 0;
    _facePageControl.numberOfPages = (_subFrameScrollView2.dataSourceArray.count - 1)/ 21 +1;
    _facePageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _facePageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [_facePageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_facePageControl];
    [_facePageControl release];
    
    //切换表情条-- selectFaceButton
    _selectFaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, 320, 40)];
    _selectFaceView.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"\ue415",@"\ue42b",@"\ue21c",@"\ue00e",@"\ue104",@"\ue151",@"\ue04a",@"\ue036", nil];
    for (int i = 0;  i < 8; i++) {
        FaceButton *selectFaceButton = [FaceButton buttonWithType:UIButtonTypeCustom];
        selectFaceButton.buttonIndex = 10000 + i;
        [selectFaceButton setTitle:array[i] forState:UIControlStateNormal];
        selectFaceButton.layer.borderWidth = 1;
        selectFaceButton.layer.borderColor = [[UIColor redColor] CGColor];
        [selectFaceButton addTarget:self action:@selector(didClickedSelectFaceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        selectFaceButton.frame = CGRectMake( (i % 8) * 40 , 0, 40, 40);
        [_selectFaceView addSubview:selectFaceButton];
    }
    
    _selectFaceBtnStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _selectFaceBtnStateView.backgroundColor = [UIColor redColor];
    _selectFaceBtnStateView.alpha = 0;
    [_selectFaceView addSubview:_selectFaceBtnStateView];
    [_selectFaceBtnStateView release];
    
    [self addSubview:_selectFaceView];
    [_selectFaceView release];
}
#pragma mark ----pageControl变化时发生的方法-----
- (void)pageControlAction:(UIPageControl *)pageControl
{
    _subFrameScrollView2.contentOffset = CGPointMake(pageControl.currentPage *320 ,0);
}
#pragma mark -----实现SubFaceFrameScrollViewDelegate方法------
-(void)changeFacePageControlCurrentPageWithContentOffset:(NSInteger)currentPage
{
    _facePageControl.currentPage = currentPage;
}
-(void)addElementToCustomKeyView:(id)object
{
    [_delegate addElementToEdtingDiaryTextView:object];
}
#pragma mark  -------重用ScrollView的实现方法 ------
-(void)setSubFaceFrameScrollViewFrame
{
    _subFrameScrollView1.frame = CGRectMake(_faceFrameScrollView.frame.origin.x, _faceFrameScrollView.frame.origin.y, _faceFrameScrollView.frame.size.width, _faceFrameScrollView.frame.size.height);
    _subFrameScrollView2.frame = CGRectMake(_faceFrameScrollView.frame.origin.x+_faceFrameScrollView.frame.size.width, _faceFrameScrollView.frame.origin.y, _faceFrameScrollView.frame.size.width, _faceFrameScrollView.frame.size.height);
    _subFrameScrollView3.frame = CGRectMake(_faceFrameScrollView.frame.origin.x+_faceFrameScrollView.frame.size.width*2, _faceFrameScrollView.frame.origin.y, _faceFrameScrollView.frame.size.width, _faceFrameScrollView.frame.size.height);
}

- (void)pageMoveToLeft
{
    NSUInteger currentFaceScrollViewAtIndex = [_faceSourceArray indexOfObject:_subFrameScrollView2.dataSourceArray];
    
    //替换数据源
    [_subFrameScrollView1 setSubviewsInfoWithDataSourceArray:_subFrameScrollView2.dataSourceArray];
    [_subFrameScrollView2 setSubviewsInfoWithDataSourceArray:_subFrameScrollView3.dataSourceArray];
    _facePageControl.numberOfPages = (_subFrameScrollView2.dataSourceArray.count - 1)/ 21 + 1;
    _facePageControl.currentPage = 0;
    //设置表情选择框选中状态
    NSInteger selectIndex = [_faceSourceArray indexOfObject:_subFrameScrollView2.dataSourceArray];
    _selectFaceBtnStateView.frame = CGRectMake(selectIndex * 40, 0, 40, 40);
    _selectFaceBtnStateView.alpha = 0.5;
    
    if (currentFaceScrollViewAtIndex > _faceSourceArray.count - 3) {
        [_subFrameScrollView3 setSubviewsInfoWithDataSourceArray:[_faceSourceArray objectAtIndex:currentFaceScrollViewAtIndex + 2 - _faceSourceArray.count]];
    }else{
        [_subFrameScrollView3 setSubviewsInfoWithDataSourceArray:[_faceSourceArray objectAtIndex:currentFaceScrollViewAtIndex + 2]];
    }
    [self setSubFaceFrameScrollViewFrame];
}
- (void)pageMoveToRight
{
    NSUInteger currentFaceScrollViewAtIndex = [_faceSourceArray indexOfObject:_subFrameScrollView2.dataSourceArray];
    //替换数据源
    [_subFrameScrollView3 setSubviewsInfoWithDataSourceArray:_subFrameScrollView2.dataSourceArray];
    [_subFrameScrollView2 setSubviewsInfoWithDataSourceArray:_subFrameScrollView1.dataSourceArray];
    _facePageControl.numberOfPages = (_subFrameScrollView2.dataSourceArray.count - 1)/ 21 + 1;
    _facePageControl.currentPage = 0;
    //设置表情选择框选中状态
    NSInteger selectIndex = [_faceSourceArray indexOfObject:_subFrameScrollView2.dataSourceArray];
    _selectFaceBtnStateView.frame = CGRectMake(selectIndex * 40, 0, 40, 40);
    _selectFaceBtnStateView.alpha = 0.5;
    
    if (currentFaceScrollViewAtIndex < 2) {
        [_subFrameScrollView1 setSubviewsInfoWithDataSourceArray:[_faceSourceArray objectAtIndex:currentFaceScrollViewAtIndex - 2 + _faceSourceArray.count]];
    }else{
        [_subFrameScrollView1 setSubviewsInfoWithDataSourceArray:[_faceSourceArray objectAtIndex:currentFaceScrollViewAtIndex - 2]];
    }
    [self setSubFaceFrameScrollViewFrame];
}

#pragma mark  -----实现UIScrollViewDelegate代理方法-----
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    // 0 1 2
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;//
    if(page == 1) {
        return;
    } else if (page == 0) {
        [self pageMoveToRight];
    } else {
        [self pageMoveToLeft];
    }
    CGPoint p = CGPointZero;
    p.x = pageWidth;
    [_faceFrameScrollView setContentOffset:p animated:NO];
    
}
#pragma mark ---- 实现点击方法 -----
-(void)didClickedSelectFaceButtonAction:(FaceButton *)selectFaceButton
{
    /**
     *  将中间的scrollview数据源换掉并重新加载,顺便还要替换左右的数据源并加载准备,并且改变背景色表示选中状态
     */
    //1、先取数据源并加载表情
    //中间视图
    NSArray *dataSourceArray2 = _faceSourceArray[selectFaceButton.buttonIndex - 10000];
    [_subFrameScrollView2 setSubviewsInfoWithDataSourceArray:dataSourceArray2];
    _facePageControl.numberOfPages = (_subFrameScrollView2.dataSourceArray.count - 1)/ 21 + 1;
    //前一个视图
    if (selectFaceButton.buttonIndex - 10000 == 0) {
        NSArray *dataSourceArray1 = [_faceSourceArray lastObject];
        [_subFrameScrollView1 setSubviewsInfoWithDataSourceArray:dataSourceArray1];
    }else{
        NSArray *dataSourceArray1 = _faceSourceArray[selectFaceButton.buttonIndex - 10000 - 1];
        [_subFrameScrollView1 setSubviewsInfoWithDataSourceArray:dataSourceArray1];
    }
    //后一个视图
    if (selectFaceButton.buttonIndex - 10000 == _faceSourceArray.count - 1) {
        NSArray *dataSourceArray3 = [_faceSourceArray firstObject];
        [_subFrameScrollView3 setSubviewsInfoWithDataSourceArray:dataSourceArray3];
    }else{
        NSArray *dataSourceArray3 = _faceSourceArray[selectFaceButton.buttonIndex - 10000 + 1];
        [_subFrameScrollView3 setSubviewsInfoWithDataSourceArray:dataSourceArray3];
    }
    //重新设置坐标
    [self setSubFaceFrameScrollViewFrame];
    
    
    //2、将选中表情条状态图透明度设置为可见，并将fram设置为点击处
    _selectFaceBtnStateView.frame = CGRectMake((selectFaceButton.buttonIndex - 10000)* 40, 0, 40, 40);
    _selectFaceBtnStateView.alpha = 0.5;
    
}
-(void)prepareData
{
    _faceSourceArray = [[NSMutableArray alloc] initWithCapacity:1];
    _face1Array = [[NSMutableArray alloc] initWithObjects:@"\ue415",@"\ue056",@"\ue057", //@"\ue409",
                 
                 @"\ue414", //@"\ue40e",
                 
                 @"\ue405", //@"\ue40e",
                 
                 @"\ue106", //@"\ue40e",
                 
                 @"\ue418", //@"\ue40e",
                 
                 @"\ue417", //@"\ue40e",
                 
                 @"\ue40d", //@"\ue40e",
                 
                 @"\ue40a", //@"\ue40e",
                 
                 @"\ue404", //@"\ue40e",
                 
                 @"\ue105", //@"\ue40e",
                 
                 @"\ue409", //@"\ue40e",
                 
                 @"\ue40e", //@"\ue40e",
                 
                 @"\ue402", //@"\ue40e",
                 
                 @"\ue108", //@"\ue40e",
                 
                 @"\ue403", //@"\ue40e",
                 
                 @"\ue058", //@"\ue40e",
                 
                 @"\ue407", //@"\ue40e",
                 
                 @"\ue401", //@"\ue40e",
                 
                 @"\ue40f", //@"\ue40e",
                 
                 @"\ue40b", //@"\ue40e",
                 
                 @"\ue406", //@"\ue40e",
                 
                 @"\ue413", //@"\ue40e",
                 
                 @"\ue411", //@"\ue40e",
                 
                 @"\ue412", //@"\ue40e",
                 
                 @"\ue410", //@"\ue40e",
                 
                 @"\ue107", //@"\ue40e",
                 
                 @"\ue059", //@"\ue40e",
                 
                 @"\ue416", //@"\ue40e",
                 
                 @"\ue408", //@"\ue40e",
                 
                 @"\ue40c", //@"\ue40e",
                 
                 @"\ue11a", //@"\ue40e",
                 
                 @"\ue10c", //@"\ue40e",
                 
                 @"\ue32c", //@"\ue40e",
                 
                 @"\ue32a", //@"\ue40e",
                 
                 @"\ue32d", //@"\ue40e",
                 
                 @"\ue328", //@"\ue40e",
                 
                 @"\ue32b", //@"\ue40e",
                 
                 @"\ue022", //@"\ue40e",
                 
                 @"\ue023", //@"\ue40e",
                 
                 @"\ue327", //@"\ue40e",
                 
                 @"\ue329", //@"\ue40e",
                 
                 @"\ue32e", //@"\ue40e",
                 
                 @"\ue32f", //@"\ue40e",
                 
                 @"\ue335", //@"\ue40e",
                 
                 @"\ue334", //@"\ue40e",
                 
                 @"\ue021", //@"\ue40e",
                 
                 @"\ue337", //@"\ue40e",
                 @"\ue020", //@"\ue40e",
                 @"\ue336", //@"\ue40e",
                 @"\ue13c", //@"\ue40e",
                 @"\ue330", //@"\ue40e",
                 @"\ue331", //@"\ue40e",
                 @"\ue326", //@"\ue40e",
                 @"\ue03e", //@"\ue40e",
                 @"\ue11d", //@"\ue40e",
                 @"\ue05a", //@"\ue40e",
                 nil ];
    
    
    _face2Array = [[NSMutableArray alloc] initWithObjects:@"\ue00e",@"\ue421",@"\ue420", //@"\ue409",
                  
                  @"\ue00d", //@"\ue40e",
                  @"\ue011", //@"\ue40e",
                  @"\ue010", //@"\ue40e",
                  @"\ue41e", //@"\ue40e",
                  @"\ue012", //@"\ue40e",
                  @"\ue422", //@"\ue40e",
                  @"\ue22e", //@"\ue40e",
                  @"\ue22f", //@"\ue40e",
                  @"\ue231", //@"\ue40e",
                  @"\ue230", //@"\ue40e",
                  @"\ue427", //@"\ue40e",
                  @"\ue41d", //@"\ue40e",
                  @"\ue00f", //@"\ue40e",
                  @"\ue41f", //@"\ue40e",
                  @"\ue14c", //@"\ue40e",
                  @"\ue201", //@"\ue40e",
                  @"\ue115", //@"\ue40e",
                  @"\ue428", //@"\ue40e",
                  @"\ue51f", //@"\ue40e",
                  @"\ue429", //@"\ue40e",
                  @"\ue424", //@"\ue40e",
                  @"\ue423", //@"\ue40e",
                  @"\ue253", //@"\ue40e",
                  @"\ue426", //@"\ue40e",
                  @"\ue111", //@"\ue40e",
                  @"\ue425", //@"\ue40e",
                  @"\ue31e", //@"\ue40e",
                  @"\ue31f", //@"\ue40e",
                  @"\ue31d", //@"\ue40e",
                  @"\ue001", //@"\ue40e",
                  @"\ue002", //@"\ue40e",
                  @"\ue005", //@"\ue40e",
                  @"\ue004", //@"\ue40e",
                  @"\ue51a", //@"\ue40e",
                  @"\ue519", //@"\ue40e",
                  @"\ue518", //@"\ue40e",
                  @"\ue515", //@"\ue40e",
                  @"\ue516", //@"\ue40e",
                  @"\ue517", //@"\ue40e",
                  @"\ue51b", //@"\ue40e",
                  @"\ue152", //@"\ue40e",
                  @"\ue04e", //@"\ue40e",
                  @"\ue51c", //@"\ue40e",
                  @"\ue51e", //@"\ue40e",
                  @"\ue11c", //@"\ue40e",
                  
                  @"\ue536", //@"\ue40e",
                  @"\ue003", //@"\ue40e",
                  @"\ue41c", //@"\ue40e",
                  @"\ue41b", //@"\ue40e",
                  
                  @"\ue419", //@"\ue40e",
                  @"\ue41a", //@"\ue40e",
                  nil];
    /*
     e04a\ 	e04b\ 	e049\ 	e048\ 	e04c\ 	e13d\ 	e443\
     e43e\ 	e04f\ 	e052\ 	e053\ 	e524\ 	e52c\ 	e52a\
     e531\ 	e050\ 	e527\ 	e051\ 	e10b\ 	e52b\ 	e52f\
     e528\ 	e01a\ 	e134\ 	e530\ 	e529\ 	e526\ 	e52d\
     e521\ 	e523\ 	e52e\ 	e055\ 	e525\ 	e10a\ 	e109\
     e522\ 	e019\ 	e054\ 	e520\ 	e306\ 	e030\ 	e304\
     e110\ 	e032\ 	e305\ 	e303\ 	e118\ 	e447\ 	e119\
     e307\ 	e308\ 	e444\ 	e441\
     
     */
    _face3Array = [[NSMutableArray alloc] initWithObjects:@"\ue04a",@"\ue04b",@"\ue049", //@"\ue409",
                  
                  @"\ue048", //@"\ue40e",
                  @"\ue04c", //@"\ue40e",
                  @"\ue13d", //@"\ue40e",
                  @"\ue443", //@"\ue40e",
                  @"\ue43e", //@"\ue40e",
                  @"\ue04f", //@"\ue40e",
                  @"\ue052", //@"\ue40e",
                  @"\ue053", //@"\ue40e",
                  @"\ue524", //@"\ue40e",
                  @"\ue52c", //@"\ue40e",
                  @"\ue52a", //@"\ue40e",
                  @"\ue531", //@"\ue40e",
                  @"\ue050", //@"\ue40e",
                  @"\ue527", //@"\ue40e",
                  @"\ue051", //@"\ue40e",
                  @"\ue10b", //@"\ue40e",
                  @"\ue52b", //@"\ue40e",
                  @"\ue52f", //@"\ue40e",
                  @"\ue528", //@"\ue40e",
                  @"\ue01a", //@"\ue40e",
                  @"\ue134", //@"\ue40e",
                  @"\ue530", //@"\ue40e",
                  @"\ue529", //@"\ue40e",
                  @"\ue526", //@"\ue40e",
                  @"\ue52d", //@"\ue40e",
                  @"\ue521", //@"\ue40e",
                  @"\ue523", //@"\ue40e",
                  @"\ue52e", //@"\ue40e",
                  @"\ue055", //@"\ue40e",
                  @"\ue525", //@"\ue40e",
                  @"\ue10a", //@"\ue40e",
                  @"\ue109", //@"\ue40e",
                  @"\ue522", //@"\ue40e",
                  @"\ue019", //@"\ue40e",
                  @"\ue054", //@"\ue40e",
                  @"\ue520", //@"\ue40e",
                  @"\ue306", //@"\ue40e",
                  @"\ue030", //@"\ue40e",
                  @"\ue304", //@"\ue40e",
                  @"\ue110", //@"\ue40e",
                  @"\ue032", //@"\ue40e",
                  @"\ue305", //@"\ue40e",
                  @"\ue303", //@"\ue40e",
                  @"\ue118", //@"\ue40e",
                  
                  
                  @"\ue447", //@"\ue40e",
                  @"\ue119", //@"\ue40e",
                  @"\ue307", //@"\ue40e",
                  @"\ue308", //@"\ue40e",
                  @"\ue444", //@"\ue40e",
                  @"\ue441", //@"\ue40e",
                  nil];
    /*
     e436\ 	e437\ 	e438\ 	e43a\ 	e439\ 	e43b\ 	e117\
     e440\ 	e442\ 	e446\ 	e445\ 	e11b\ 	e448\ 	e033\
     e112\ 	e325\ 	e312\ 	e310\ 	e126\ 	e127\ 	e008\
     e03d\ 	e00c\ 	e12a\ 	e00a\ 	e00b\ 	e009\ 	e316\
     e129\ 	e141\ 	e142\ 	e317\ 	e128\ 	e14b\ 	e211\
     e114\ 	e145\ 	e144\ 	e03f\ 	e313\ 	e116\ 	e10f\
     e104\ 	e103\ 	e101\ 	e102\ 	e13f\ 	e140\ 	e11f\
     e12f\ 	e031\ 	e30e\ 	e311\ 	e113\ 	e30f\ 	e13b\
     */
    _face4Array = [[NSMutableArray alloc]initWithObjects:
                    @"\ue104", //@"\ue415",
                    @"\ue436", //@"\ue415",
                    @"\ue437", //@"\ue415",
                    @"\ue438", //@"\ue415",
                    @"\ue43a", //@"\ue415",
                    @"\ue439", //@"\ue415",
                    @"\ue43b", //@"\ue415",
                    @"\ue117", //@"\ue415",
                    @"\ue440", //@"\ue415",
                    @"\ue442", //@"\ue415",
                    @"\ue446", //@"\ue415",
                    @"\ue445", //@"\ue415",
                    @"\ue11b", //@"\ue415",
                    @"\ue448", //@"\ue415",
                    @"\ue033", //@"\ue415",
                    @"\ue112", //@"\ue415",
                    @"\ue325", //@"\ue415",
                    @"\ue312", //@"\ue415",
                    @"\ue310", //@"\ue415",
                    @"\ue126", //@"\ue415",
                    @"\ue127", //@"\ue415",
                    @"\ue008", //@"\ue415",
                    @"\ue03d", //@"\ue415",
                    @"\ue00c", //@"\ue415",
                    @"\ue12a", //@"\ue415",
                    @"\ue00a", //@"\ue415",
                    @"\ue00b", //@"\ue415",
                    @"\ue009", //@"\ue415",
                    @"\ue316", //@"\ue415",
                    @"\ue129", //@"\ue415",
                    @"\ue141", //@"\ue415",
                    @"\ue142", //@"\ue415",
                    @"\ue317", //@"\ue415",
                    @"\ue128", //@"\ue415",
                    @"\ue14b", //@"\ue415",
                    @"\ue211", //@"\ue415",
                    @"\ue114", //@"\ue415",
                    @"\ue145", //@"\ue415",
                    @"\ue144", //@"\ue415",
                    @"\ue03f", //@"\ue415",
                    @"\ue313", //@"\ue415",
                    @"\ue116", //@"\ue415",
                    @"\ue10f", //@"\ue415",
                    @"\ue103", //@"\ue415",
                    @"\ue101", //@"\ue415",
                    @"\ue102", //@"\ue415",
                    @"\ue13f", //@"\ue415",
                    @"\ue140", //@"\ue415",
                    @"\ue11f", //@"\ue415",
                    @"\ue12f", //@"\ue415",
                    @"\ue031", //@"\ue415",
                    @"\ue30e", //@"\ue415",
                    @"\ue311", //@"\ue415",
                    @"\ue113", //@"\ue415",
                    @"\ue30f", //@"\ue415",
                    @"\ue13b", //@"\ue415",
                    
                    nil];
    /*
     e42b\ 	e42a\ 	e018\ 	e016\ 	e015\ 	e014\ 	e42c\
     e42d\ 	e017\ 	e013\ 	e20e\ 	e20c\ 	e20f\ 	e20d\
     e131\ 	e12b\ 	e130\ 	e12d\ 	e324\ 	e301\ 	e148\
     e502\ 	e03c\ 	e30a\ 	e042\ 	e040\ 	e041\ 	e12c\
     e007\ 	e31a\ 	e13e\ 	e31b\ 	e006\ 	e302\ 	e319\
     e321\ 	e322\ 	e314\ 	e503\ 	e10e\ 	e318\ 	e43c\
     e11e\ 	e323\ 	e31c\ 	e034\ue034 	e035\ue035 	e045\ue045 	e338\ue338
     e047\ue047 	e30c\ue30c 	e044\ue044 	e30b\ue30b 	e043\ue043 	e120\ue120 	e33b\ue33b
     e33f\ue33f 	e341\ue341 	e34c\ue34c 	e344\ue344 	e342\ue342 	e33d\ue33d 	e33e\ue33e
     e340\ue340 	e34d\ue34d 	e339\ue339 	e147\ue147 	e343\ue343 	e33c\ue33c 	e33a\ue33a
     e43f\ue43f 	e34b\ue34b 	e046\ue046 	e345\ue345 	e346\ue346 	e348\ue348 	e347\ue347
     e34a\ue34a 	e349\ue349
     */
    _face5Array = [[NSMutableArray alloc]initWithObjects:
                   @"\ue42b", //@"\ue415",
                   @"\ue42a", //@"\ue415",
                   @"\ue018", //@"\ue415",
                   @"\ue016", //@"\ue415",
                   @"\ue015", //@"\ue415",
                   @"\ue014", //@"\ue415",
                   @"\ue42c", //@"\ue415",
                   @"\ue42d", //@"\ue415",
                   @"\ue017", //@"\ue415",
                   @"\ue013", //@"\ue415",
                   @"\ue20e", //@"\ue415",
                   @"\ue20c", //@"\ue415",
                   @"\ue20f", //@"\ue415",
                   @"\ue20d", //@"\ue415",
                   @"\ue131", //@"\ue415",
                   @"\ue12b", //@"\ue415",
                   @"\ue130", //@"\ue415",
                   @"\ue12d", //@"\ue415",
                   @"\ue324", //@"\ue415",
                   @"\ue301", //@"\ue415",
                   @"\ue148", //@"\ue415",
                   @"\ue502", //@"\ue415",
                   @"\ue03c", //@"\ue415",
                   @"\ue30a", //@"\ue415",
                   @"\ue042", //@"\ue415",
                   @"\ue040", //@"\ue415",
                   @"\ue041", //@"\ue415",
                   @"\ue12c", //@"\ue415",
                   @"\ue007", //@"\ue415",
                   @"\ue31a", //@"\ue415",
                   @"\ue13e", //@"\ue415",
                   @"\ue31b", //@"\ue415",
                   @"\ue006", //@"\ue415",
                   @"\ue302", //@"\ue415",
                   @"\ue319", //@"\ue415",
                   @"\ue321", //@"\ue415",
                   @"\ue322", //@"\ue415",
                   @"\ue314", //@"\ue415",
                   @"\ue503", //@"\ue415",
                   @"\ue10e", //@"\ue415",
                   @"\ue318", //@"\ue415",
                   @"\ue43c", //@"\ue415",
                   @"\ue11e", //@"\ue415",
                   @"\ue323", //@"\ue415",
                   @"\ue31c", //@"\ue415",
                   /*
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    @"\U0001F604", //@"\ue415",
                    */
                   nil];
    /*
     e036\ 	e157\ 	e038\ 	e153\ 	e155\ 	e14d\ 	e156\
     e501\ 	e158\ 	e43d\ 	e037\ 	e504\ 	e44a\ 	e146\
     e50a\ 	e505\ 	e506\ 	e122\ 	e508\ 	e509\ 	e03b\
     e04d\ 	e449\ 	e44b\ 	e51d\ 	e44c\ 	e124\ 	e121\
     e433\ 	e202\ 	e135\ 	e01c\ 	e01d\ 	e10d\ 	e136\ue136
     e42e\ue42e 	e01b\ue01b 	e15a\ue15a 	e159\ue159 	e432\ue432 	e430\ue430 	e431\ue431
     e42f\ue42f 	e01e\ue01e 	e039\ue039 	e435\ue435 	e01f\ue01f 	e125\ue125 	e03a\ue03a
     e14e\ue14e 	e252\ue252 	e137\ue137 	e209\ue209 	e154\ue154 	e133\ue133 	e150\ue150
     e320\ue320 	e123\ue123 	e132\ue132 	e143\ue143 	e50b\ue50b 	e514\ue514 	e513\ue513
     e50c\ue50c 	e50d\ue50d 	e511\ue511 	e50f\ue50f 	e512\ue512 	e510\ue510 	e50e\ue50e
     */
    _face6Array = [[NSMutableArray alloc]initWithObjects:
                    @"\ue036", //@"\ue415",
                    @"\ue157", //@"\ue415",
                    @"\ue038", //@"\ue415",
                    @"\ue153", //@"\ue415",
                    @"\ue155", //@"\ue415",
                    @"\ue14d", //@"\ue415",
                    @"\ue156", //@"\ue415",
                    @"\ue501", //@"\ue415",
                    @"\ue158", //@"\ue415",
                    @"\ue43d", //@"\ue415",
                    @"\ue037", //@"\ue415",
                    @"\ue504", //@"\ue415",
                    @"\ue44a", //@"\ue415",
                    @"\ue146", //@"\ue415",
                    @"\ue50a", //@"\ue415",
                    @"\ue505", //@"\ue415",
                    @"\ue506", //@"\ue415",
                    @"\ue122", //@"\ue415",
                    @"\ue508", //@"\ue415",
                    @"\ue509", //@"\ue415",
                    @"\ue03b", //@"\ue415",
                    @"\ue04d", //@"\ue415",
                    @"\ue449", //@"\ue415",
                    @"\ue44b", //@"\ue415",
                    @"\ue51d", //@"\ue415",
                    @"\ue44c", //@"\ue415",
                    @"\ue124", //@"\ue415",
                    @"\ue121", //@"\ue415",
                    @"\ue433", //@"\ue415",
                    @"\ue202", //@"\ue415",
                    @"\ue135", //@"\ue415",
                    @"\ue01c", //@"\ue415",
                    @"\ue01d", //@"\ue415",
                    @"\ue10d", //@"\ue415",
                    
                    nil];
    /*
     e21c\ 	e21d\ 	e21e\ 	e21f\ 	e220\ 	e221\ 	e222\
     e223\ 	e224\ 	e225\ 	e210\ 	e232\ 	e233\ 	e235\
     e234\ 	e236\ 	e237\ 	e238\ 	e239\ 	e23b\ 	e23a\
     e23d\ 	e23c\ 	e24d\ 	e212\ 	e24c\ 	e213\ 	e214\
     e507\ 	e203\ 	e20b\
     */
    _face7Array = [[NSMutableArray alloc] initWithObjects:
                       @"\ue21c",
                       @"\ue21d",
                       @"\ue21e",     //@"\ue414",
                       @"\ue21f",     //@"\ue414",
                       @"\ue220",     //@"\ue414",
                       @"\ue221",     //@"\ue414",
                       @"\ue222",     //@"\ue414",
                       @"\ue223",     //@"\ue414",
                       @"\ue224",     //@"\ue414",
                       @"\ue225",     //@"\ue414",
                       @"\ue210",     //@"\ue414",
                       @"\ue232",     //@"\ue414",
                       @"\ue233",     //@"\ue414",
                       @"\ue235",     //@"\ue414",
                       @"\ue234",     //@"\ue414",
                       @"\ue236",     //@"\ue414",
                       @"\ue237",
                       @"\ue238",
                       @"\ue239",
                       @"\ue23b",
                       @"\ue23a",
                       @"\ue23d",
                       @"\ue23c",
                       @"\ue24d",
                       @"\ue212",
                       @"\ue24c",
                       @"\ue213",
                       @"\ue214",
                       @"\ue507",
                       @"\ue203",
                       @"\ue20b",
                       
                       
                       nil];
    /*
     e22a\ 	e22b\ 	e226\ 	e227\
     e22c\ 	e22d\ 	e215\ 	e216\ 	e217\ 	e218\ 	e228\
     e151\ 	e138\ 	e139\ 	e13a\ 	e208\ 	e14f\ 	e20a\
     e434\ 	e309\ 	e315\ 	e30d\ 	e207\ 	e229\ 	e206\
     e205\ 	e204\ 	e12e\ 	e250\ 	e251\ 	e14a\ 	e149\
     e23f\ 	e240\ 	e241\ 	e242\ 	e243\ 	e244\ 	e245\
     e246\ 	e247\ue247 	e248\ue248 	e249\ue249 	e24a\ue24a 	e24b\ue24b 	e23e\ue23e
     e532\ue532 	e533\ue533 	e534\ue534 	e535\ue535 	e21a\ue21a 	e219\ue219 	e21b\ue21b
     e02f\ue02f 	e024\ue024 	e025\ue025 	e026\ue026 	e027\ue027 	e028\ue028 	e029\ue029
     e02a\ue02a 	e02b\ue02b 	e02c\ue02c 	e02d\ue02d 	e02e\ue02e 	e332\ue332 	e333\ue333
     e24e\ue24e 	e24f\ue24f 	e537\ue537
     */
    _face8Array = [[NSMutableArray alloc] initWithObjects:
                        @"\ue151",
                        @"\ue22a",
                        @"\ue22b",     //@"\ue414",
                        @"\ue226",     //@"\ue414",
                        @"\ue227",     //@"\ue414",
                        @"\ue22c",     //@"\ue414",
                        @"\ue22d",     //@"\ue414",
                        @"\ue215",     //@"\ue414",
                        @"\ue216",     //@"\ue414",
                        @"\ue217",     //@"\ue414",
                        @"\ue218",     //@"\ue414",
                        @"\ue228",     //@"\ue414",
                        @"\ue138",
                        @"\ue139",
                        @"\ue13a",
                        @"\ue208",
                        @"\ue14f",
                        @"\ue20a",
                        @"\ue434",
                        @"\ue309",
                        @"\ue315",
                        @"\ue30d",
                        @"\ue207",
                        @"\ue229",
                        @"\ue206",
                        @"\ue205",
                        @"\ue204",
                        @"\ue12e",
                        @"\ue250",
                        @"\ue251",
                        @"\ue14a",
                        @"\ue149",
                        @"\ue23f",
                        @"\ue240",
                        @"\ue241",
                        @"\ue242",
                        @"\ue243",
                        @"\ue244",
                        @"\ue245",
                        @"\ue246",
                        
                        nil];
    
    [_faceSourceArray addObject:_face1Array];
    [_faceSourceArray addObject:_face2Array];
    [_faceSourceArray addObject:_face3Array];
    [_faceSourceArray addObject:_face4Array];
    [_faceSourceArray addObject:_face5Array];
    [_faceSourceArray addObject:_face6Array];
    [_faceSourceArray addObject:_face7Array];
    [_faceSourceArray addObject:_face8Array];
    
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
