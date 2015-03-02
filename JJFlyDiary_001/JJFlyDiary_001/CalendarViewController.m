

#import "CalendarViewController.h"
#import "DiaryModel.h"
#import "DiaryListTableViewCell.h"
#import "DiaryDetailViewController.h"
@interface CalendarViewController ()
{
    CalendarView *_sampleView;
    UITableView *_dirayListTableView;
    FMDatabase *_db;
    NSMutableArray *_dirayModelArray;
    NSString *_selectDateStr;
}
@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)selectQueryDB:(NSString *)selectedDateStr
{
    if (_dirayModelArray == nil) {
        _dirayModelArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    [_dirayModelArray removeAllObjects];
    FMResultSet *resultSet = [_db executeQuery:@"select * from MyDiary where writeDay = ?",selectedDateStr];
    while ([resultSet next]) {
        NSData *diaryModelData = [resultSet dataForColumn:@"diaryData"];
        //进行反归档，创建反归档对象
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:diaryModelData];
        //通过反归档得到model对象
        DiaryModel *diaryModel = [unArchiver decodeObjectForKey:kEncodeKey];
        //反归档结束
        [unArchiver finishDecoding];
        [unArchiver release];
        [_dirayModelArray addObject:diaryModel];
    }
    [_dirayListTableView reloadData];
    _dirayListTableView.contentOffset = CGPointMake(0, 0);
    [_dirayListTableView flashScrollIndicators];
    
}
- (void)addSubviews
{
    //加日历
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-179)];
    _sampleView.delegate = self;
    [_sampleView setBackgroundColor:[UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000]];
    _sampleView.calendarDate = [NSDate date];
    [self.view addSubview:_sampleView];
    [_sampleView release];
    
    
    //加对应日期日记列表tableview
    _dirayListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _sampleView.frame.size.height, kMainScreenWidth, kMainScreenHeight - _sampleView.frame.size.height - 64) style:UITableViewStyleGrouped];
    _dirayListTableView.tag = noDisableVerticalScrollTag;
    _dirayListTableView.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000];
    _dirayListTableView.delegate = self;
    _dirayListTableView.dataSource = self;
    [self.view addSubview:_dirayListTableView];
    [_dirayListTableView release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000]];
    self.title = @"日记集";
    
    [self openDB];
    
    //构造日期样式
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    myFormatter.dateFormat = kWriteDaydateFormat;
    NSString *dateStr = [myFormatter stringFromDate:todayDate];
    [myFormatter release];
    
    [self addSubviews];
    [self selectQueryDB:dateStr];
}

-(void)tappedOnDate:(NSString *)selectedDateStr
{
    _selectDateStr = selectedDateStr;
    [self selectQueryDB:selectedDateStr];
}
//每次回到日历页面刷新数据，防止删除后未同步
-(void)viewDidAppear:(BOOL)animated
{
    [_sampleView refreshCalendarView];
}
#pragma  mark -----tableView的代理实现------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dirayModelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerClass:[DiaryListTableViewCell class] forCellReuseIdentifier:@"cell"];
    DiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DiaryModel *theDiaryModel = _dirayModelArray[indexPath.row];
    NSString *timeStr = [theDiaryModel.dateLabelStr substringFromIndex:13];
    cell.dateLabel.text = timeStr;
    cell.myTextLabel.text = theDiaryModel.diaryText;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%d 则日记",_dirayModelArray.count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiaryDetailViewController *diaryDetailVC = [[DiaryDetailViewController alloc] init];
    DiaryModel *theDiaryModel = _dirayModelArray[indexPath.row];
    diaryDetailVC.detailDiaryModel = theDiaryModel;
    diaryDetailVC.isComeFromeCalendar = YES;
    [self.navigationController pushViewController:diaryDetailVC animated:YES];
    [diaryDetailVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

