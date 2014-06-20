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
}

@end

@implementation SPACalendarMonthContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
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
    NSLog(@"dfgdfg %i",sender.indexContainer);
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
    
    NSInteger weekday = [processedComponents weekday];
    
    NSRange days = [_calendar rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:actualDate];
    NSInteger numberOfDays = days.length;
    
    NSLog(@"%li",(long)numberOfDays);
    
    NSInteger dayIndex = 1;
    NSInteger indexContainerStart = weekday;
    NSInteger indexContainerFinish = weekday + numberOfDays-1;
    
    for(SPACalendarDayButton* button in _dayButtons){
        
        if(dayIndex >= indexContainerStart && dayIndex <= indexContainerFinish){
            [button setTitle:[NSString stringWithFormat:@"%li",(dayIndex-weekday+1)] forState:UIControlStateNormal];
        }else{
            [button setTitle:@"" forState:UIControlStateNormal];
        }
        dayIndex++;
            
    }
}

- (int) weekDayToBelarusianSystem:(int)day{
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
