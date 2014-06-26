//
//  SPACalendarMonthContainerView.m
//  SmartPecker
//
//  Created by majstrak on 18.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPACalendarMonthContainerView.h"
#import "SPACalendarMonthLabel.h"
#import "SPACalendarDayButton.h"

@interface SPACalendarMonthContainerView (){
    SPACalendarMonthLabel* _monthLabel;
    NSMutableArray* _dayButtons;
    NSCalendar* _calendar;
 
    NSInteger _todayDay;
    NSInteger _todayMonth;
    NSInteger _todayYear;
    NSInteger _activeDay;
    NSInteger _activeMonth;
    NSInteger _activeYear;
 
    UIImage* _todayImage;
    UIImage* _currentImage;
}

@end

@implementation SPACalendarMonthContainerView

//@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate* todayDate = [NSDate date];
        NSDateComponents* todayComponents = [_calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:todayDate];
        _todayDay = _activeDay = [todayComponents day];
        _todayMonth = _activeMonth = [todayComponents month];
        _todayYear = _activeYear = [todayComponents year];

        _todayImage = [UIImage imageNamed:@"calendar_daycurrent.png"];
        _currentImage = [UIImage imageNamed:@"calendar_dayactive.png"];
        //Month Left Button
        UIImage* monthLeftButtonImage = [UIImage imageNamed:@"calendar_monthleft.png"];
        UIButton* monthLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(8.0, 0.0, 44.0, 44.0)];
        [monthLeftButton setImage:monthLeftButtonImage forState:UIControlStateNormal];
        [monthLeftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //Month Right Button
        UIImage* monthRightButtonImage = [UIImage imageNamed:@"calendar_monthright.png"];
        UIButton* monthRightButton = [[UIButton alloc] initWithFrame:CGRectMake(268.0, 0.0, 44.0, 44.0)];
        [monthRightButton setImage:monthRightButtonImage forState:UIControlStateNormal];
        [monthRightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //MonthLabel
        _monthLabel = [[SPACalendarMonthLabel alloc] initWithFrame:CGRectMake(52.0, 0.0, 216.0, 44.0)];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:monthLeftButton];
        [self addSubview:monthRightButton];
        [self addSubview:_monthLabel];
        //Weekday strap
        for(int i = 1; i <= 7; i++){
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(6.0+(i-1)*44.0, 44.0, 44.0, 22.0)];
            label.text = [self dayNameFromId:i];
            label.textColor = [UIColor whiteColor];
            label.font = [label.font fontWithSize:12.0];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:label];
        }
        //Monthday strap
        _dayButtons = [[NSMutableArray alloc] init];
        for(int i = 1; i <= 5; i++){
            for( int j = 1; j <= 7; j++){
                SPACalendarDayButton* button = [[SPACalendarDayButton alloc] initWithFrame:CGRectMake(6.0+(j-1)*44.0, 66.0+(i-1)*44.0, 44.0, 44.0)];
                button.indexContainer = (i-1)*7 + j;
                [button setTitle:@"" forState:UIControlStateNormal];
                [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                button.titleLabel.font = [button.titleLabel.font fontWithSize:15.0];
                [button addTarget:self action:@selector(dayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitleColor: [UIColor colorWithRed:230.0/255.0 green:209.0/255.0 blue:184.0/255.0 alpha:1.0] forState: UIControlStateSelected];
                [button setBackgroundImage:_currentImage forState:UIControlStateSelected];
                [_dayButtons addObject:button];
                [self addSubview:button];
            }
        }
        
        [self refreshDayButtonsByMonth:_monthLabel.activeMonth AndYear:_monthLabel.activeYear];
        

    }
    return self;
}

- (void) leftButtonClicked:(UIButton*) sender{
    [_monthLabel setPrevMonth];
    [self refreshDayButtonsByMonth:_monthLabel.activeMonth AndYear:_monthLabel.activeYear];
}

- (void) rightButtonClicked:(UIButton*) sender{
    [_monthLabel setNextMonth];
    [self refreshDayButtonsByMonth:_monthLabel.activeMonth AndYear:_monthLabel.activeYear];
}

-(void) dayButtonClicked:(SPACalendarDayButton*) sender{
    _activeDay = sender.indexDay;
    _activeMonth = sender.indexMonth;
    _activeYear = sender.indexYear;
    
    if([[self delegate] respondsToSelector:@selector(dateFromCalendarWithDay:AndMonth:AndYear:)]) {
        [[self delegate] dateFromCalendarWithDay:_activeDay AndMonth:_activeMonth AndYear:_activeYear];
    }
    
    [self.calendarNavigatioView reloadView];
    
    [self refreshDayButtonsByMonth:_monthLabel.activeMonth AndYear:_monthLabel.activeYear];
}

- (NSString*) dayNameFromId:(NSInteger)identifier{
    switch (identifier) {
        case 1:
            return @"Пн";
            break;
        case 2:
            return @"Вт";
            break;
        case 3:
            return @"Ср";
            break;
        case 4:
            return @"Чт";
            break;
        case 5:
            return @"Пт";
            break;
        case 6:
            return @"Сб";
            break;
        case 7:
            return @"Вс";
            break;
        default:
            return nil;
            break;
    }
}

- (void) refreshDayButtonsByMonth:(NSInteger) month AndYear:(NSInteger) year{
    
    NSDateComponents* actualComponents = [[NSDateComponents alloc] init];
    [actualComponents setDay:1];
    [actualComponents setMonth:month];
    [actualComponents setYear:year];
    
    NSDate* actualDate = [_calendar dateFromComponents:actualComponents];
    NSDateComponents* processedComponents = [_calendar components:NSWeekdayCalendarUnit fromDate:actualDate];
    
    NSInteger weekday = [self weekDayToBelarusianSystem:[processedComponents weekday]];
    
    NSRange days = [_calendar rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:actualDate];
    NSInteger numberOfDays = days.length;
    
    //NSLog(@"%li",(long)numberOfDays);
    
    NSInteger indexContainerStart = weekday;
    NSInteger indexContainerFinish = weekday + numberOfDays-1;
    
    //Previous month calculation
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-1];
    NSDate* previousMonthDate = [_calendar dateByAddingComponents:offsetComponents toDate:actualDate options:0];
    
    NSRange previousMonthDays = [_calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit
                                  forDate:previousMonthDate];
    
    NSInteger previousMonthNumberOfDays = previousMonthDays.length;
    

    
    for(SPACalendarDayButton* button in _dayButtons){
        
        [button setSelected:NO];
        
        if(button.indexContainer >= indexContainerStart && button.indexContainer <= indexContainerFinish){
            [button setTitle:[NSString stringWithFormat:@"%li",(button.indexContainer-weekday+1)] forState:UIControlStateNormal];
            
            button.indexDay = button.indexContainer-weekday+1;
            button.indexMonth = month;
            button.indexYear = year;
            
          
        }else{
            if (button.indexContainer < indexContainerStart) {
                [button setTitle:[NSString stringWithFormat:@"%li",(previousMonthNumberOfDays - weekday + button.indexContainer+1)] forState:UIControlStateNormal];
                button.indexDay = previousMonthNumberOfDays - weekday + button.indexContainer+1;
                button.indexMonth = month == 1 ? 12 : month-1;
                button.indexYear = month == 1 ? year-1 : year;
                button.titleLabel.textColor = [UIColor colorWithRed:244.0/255.0 green:233.0/255.0 blue:211.0/255.0 alpha:1.0];
            }else{
                [button setTitle:[NSString stringWithFormat:@"%li",(button.indexContainer-weekday-numberOfDays+1)] forState:UIControlStateNormal];
                button.indexDay = button.indexContainer-weekday-numberOfDays+1;
                button.indexMonth = month == 12 ? 1 : month+1;
                button.indexYear = month == 12 ? year+1 : year;
                button.titleLabel.textColor = [UIColor colorWithRed:244.0/255.0 green:233.0/255.0 blue:211.0/255.0 alpha:1.0];
            }
        }
        
        if(button.indexDay == _activeDay && button.indexMonth == _activeMonth && button.indexYear == _activeYear){
            [button setSelected:YES];
            
        }
        if(button.indexDay == _todayDay && button.indexMonth == _todayMonth && button.indexYear == _todayYear){
            [button setBackgroundImage:_todayImage forState:UIControlStateNormal];
            
        }else{
            [button setBackgroundImage:nil forState:UIControlStateNormal];
        }

        
    }
}

- (NSInteger) weekDayToBelarusianSystem:(NSInteger)day{
    return day == 1 ? 7 : day-1;
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
