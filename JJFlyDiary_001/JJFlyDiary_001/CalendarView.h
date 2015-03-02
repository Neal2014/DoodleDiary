

#import <UIKit/UIKit.h>
@protocol CalendarDelegate <NSObject>

-(void)tappedOnDate:(NSString *)selectedDateStr;

@end

@interface CalendarView : UIView
{
    NSInteger _selectedDate;
    NSArray *_weekNames;
}

@property (nonatomic,strong) NSDate *calendarDate;
@property (nonatomic,assign) id<CalendarDelegate> delegate;
- (void)refreshCalendarView;
@end
