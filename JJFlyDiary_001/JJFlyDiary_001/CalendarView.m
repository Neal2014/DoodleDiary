
#import "CalendarView.h"
@interface CalendarView()

{
    
    NSCalendar *_myCalendar;
    NSInteger _selectedMonth;
    NSInteger _selectedYear;
    FMDatabase *_db;
}

@end
@implementation CalendarView
-(void)dealloc
{
    [_db release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //上下滑换月
        UISwipeGestureRecognizer * swipeUp=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
        swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeUp];
        
        UISwipeGestureRecognizer * swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown:)];
        swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipeDown];
        //左右滑换年
        UISwipeGestureRecognizer * swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
        swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        [self openDB];
    }
    return self;
}

- (void)openDB
{
    //到数据库中查询
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
}
- (void)drawRect:(CGRect)rect
{
    
    [self setCalendarParameters];
    _weekNames = @[@"Mo",@"Tu",@"We",@"Th",@"Fr",@"Sa",@"Su"];
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    NSDate *firstDayOfMonth = [_myCalendar dateFromComponents:components];
    NSDateComponents *comps = [_myCalendar components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = [comps weekday];
    weekday  = weekday - 2;
    
    if(weekday < 0)
        weekday += 7;
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.calendarDate];
    
    NSInteger columns = 7;
    NSInteger width = 40;
    NSInteger originX = 20;
    NSInteger originY = 30;
    NSInteger monthLength = days.length;
    
    //显示年月标题
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(0,5, self.bounds.size.width, 25)];
//    titleText.backgroundColor = [UIColor redColor];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM月/yyyy年"];
    NSString *dateString = [[format stringFromDate:self.calendarDate] uppercaseString];
    [format release];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22.0f]];
    [titleText setTextColor:[UIColor brownColor]];
    [self addSubview:titleText];
    
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        weekNameButton.backgroundColor = [UIColor blueColor];
        weekNameButton.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameButton setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameButton setFrame:CGRectMake(originX+(width*(i%columns)), originY, width, 25)];
        [weekNameButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [weekNameButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        weekNameButton.userInteractionEnabled = NO;
        [self addSubview:weekNameButton];
        
    }


    for (NSInteger i= 0; i<monthLength; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
//        button.titleLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:19.0f]];
        
        
        /**
         *  在这儿通过判断改日历上的相关样式或者加标记
         */
        //构造每一天的日期样式
        NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = i+1; //给新值
        NSDate *clickedDate = [_myCalendar dateFromComponents:components];
        NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
        myFormatter.dateFormat = kWriteDaydateFormat;
        NSString *dateStr = [myFormatter stringFromDate:clickedDate];
        [myFormatter release];
        
        //3、判断此数据库中是否有该日期日记,如果有的话记录个数，并加标记，如果没有放过
        int theDayDiaryCount = [_db intForQuery:@"select count(*) from MyDiary where writeDay = ?",dateStr];
        if (theDayDiaryCount > 0) {
            UILabel *diaryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 28, 20, 10)];
            diaryCountLabel.backgroundColor = [UIColor clearColor];
            diaryCountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
            diaryCountLabel.text = [NSString stringWithFormat:@"%d",theDayDiaryCount];
            diaryCountLabel.textAlignment = NSTextAlignmentLeft;
            diaryCountLabel.textColor = [UIColor redColor];
            [button addSubview:diaryCountLabel];
            [diaryCountLabel release];
        }
        
        //这里给日历上对应日期添加方法
        [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger offsetX = (width*((i+weekday)%columns));
        NSInteger offsetY = (width *((i+weekday)/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+30+offsetY, width, width)];
        [button.layer setBorderColor:[[UIColor brownColor] CGColor]];
        [button.layer setBorderWidth:2.0];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor brownColor];
        if(((i+weekday)/columns)==0)
        {
            [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 4)];
            [button addSubview:lineView];
        }

        if(((i+weekday)/columns)==((monthLength+weekday-1)/columns))
        {
            [lineView setFrame:CGRectMake(0, button.frame.size.width-4, button.frame.size.width, 4)];
            [button addSubview:lineView];
        }
        
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:[UIColor brownColor]];
        if((i+weekday)%7==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 4, button.frame.size.width)];
            [button addSubview:columnView];
            [columnView release];
        }
        else if((i+weekday)%7==6)
        {
            [columnView setFrame:CGRectMake(button.frame.size.width-4, 0, 4, button.frame.size.width)];
            [button addSubview:columnView];
            [columnView release];
        }
        
        if(i+1 ==_selectedDate && components.month == _selectedMonth && components.year == _selectedYear)
        {
            [button setBackgroundColor:[UIColor colorWithRed:1.000 green:0.411 blue:0.249 alpha:1.000]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        [self addSubview:button];
        
    }
    
    NSDateComponents *previousMonthComponents = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    previousMonthComponents.month -=1;
    NSDate *previousMonthDate = [_myCalendar dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                   inUnit:NSMonthCalendarUnit
                  forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;
    
    
    for (int i=0; i<weekday; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",maxDate+i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",maxDate+i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (width*(i%columns));
        NSInteger offsetY = (width *(i/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+30+offsetY, width, width)];
        [button.layer setBorderWidth:2.0];
        [button.layer setBorderColor:[[UIColor brownColor] CGColor]];
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:[UIColor brownColor]];
        if(i==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 4, button.frame.size.width)];
            [button addSubview:columnView];
        }

        UIView *lineView = [[UIView alloc]init];
        [lineView setBackgroundColor:[UIColor brownColor]];
        [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 4)];
        [button addSubview:lineView];
        [lineView release];
        [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        [button setEnabled:NO];
        [self addSubview:button];
    }
    
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if(remainingDays >0){
        for (int i=remainingDays; i<columns; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.text = [NSString stringWithFormat:@"%d",(i+1)-remainingDays];
            [button setTitle:[NSString stringWithFormat:@"%d",(i+1)-remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (width*((i) %columns));
            NSInteger offsetY = (width *((monthLength+weekday)/columns));
            [button setFrame:CGRectMake(originX+offsetX, originY+30+offsetY, width, width)];
            [button.layer setBorderWidth:2.0];
            [button.layer setBorderColor:[[UIColor brownColor] CGColor]];
            UIView *columnView = [[UIView alloc]init];
            [columnView setBackgroundColor:[UIColor brownColor]];
            if(i==columns - 1)
            {
                [columnView setFrame:CGRectMake(button.frame.size.width-4, 0, 4, button.frame.size.width)];
                [button addSubview:columnView];
            }
            UIView *lineView = [[UIView alloc]init];
            [lineView setBackgroundColor:[UIColor brownColor]];
            [lineView setFrame:CGRectMake(0, button.frame.size.width-4, button.frame.size.width, 4)];
            [button addSubview:lineView];
            [lineView release];
            [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
            [button setEnabled:NO];
            [self addSubview:button];

        }
    }

}
-(void)tappedDate:(UIButton *)sender
{
//    _myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //可以去掉，之前创建过了
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    //判断是否点击的是别的按钮，是则做操作，是原按钮则什么都不做
    if(!(_selectedDate == sender.tag && _selectedMonth == [components month] && _selectedYear == [components year]))
    {
        //去除上一个日期点击效果
        if(_selectedDate != -1)
        {
            UIButton *previousSelected =(UIButton *) [self viewWithTag:_selectedDate];
            [previousSelected setBackgroundColor:[UIColor clearColor]];
            [previousSelected setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        }
        //设置本次点中日期
        [sender setBackgroundColor:[UIColor colorWithRed:1.000 green:0.435 blue:0.812 alpha:1.000]];
        [sender setTitleColor:[UIColor colorWithRed:0.400 green:1.000 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
        _selectedDate = sender.tag;//给当前选中日期day换值
        NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = _selectedDate; //给新值
        _selectedMonth = components.month;//取值记录
        _selectedYear = components.year; //取值记录
        
        NSDate *clickedDate = [_myCalendar dateFromComponents:components];
        NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
        myFormatter.dateFormat = kWriteDaydateFormat;
        NSString *dateStr = [myFormatter stringFromDate:clickedDate];
        [myFormatter release];
        [self.delegate tappedOnDate:dateStr];
    }
}

-(void)swipeUp:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month += 1;
    self.calendarDate = [_myCalendar dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
    
}

-(void)swipeDown:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month -= 1;
    self.calendarDate = [_myCalendar dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}
-(void)swipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.year += 1;
    self.calendarDate = [_myCalendar dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}

-(void)swipeRight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.year -= 1;
    self.calendarDate = [_myCalendar dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}
-(void)refreshCalendarView
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = _selectedDate;
    
    NSDate *clickedDate = [_myCalendar dateFromComponents:components];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    myFormatter.dateFormat = kWriteDaydateFormat;
    NSString *dateStr = [myFormatter stringFromDate:clickedDate];
    [myFormatter release];
    [self.delegate tappedOnDate:dateStr];
    self.calendarDate = [_myCalendar dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.1f
                       options:UIViewAnimationOptionCurveLinear
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}

-(void)setCalendarParameters
{
    if(_myCalendar == nil)
    {
        _myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [_myCalendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        _selectedDate  = components.day;
        _selectedMonth = components.month;
        _selectedYear = components.year;
    }
}

@end
