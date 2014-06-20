//
//  SPACalendarMonthLabel.m
//  SmartPecker
//
//  Created by majstrak on 19.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPACalendarMonthLabel.h"

@interface SPACalendarMonthLabel (){
    
    NSDate* _todayDate;
    NSDate* _activeDate;
    NSCalendar* _calendar;
}

@end

@implementation SPACalendarMonthLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.textColor = [UIColor whiteColor];
        _todayDate = [NSDate date];
        _activeDate = [NSDate date];
        NSLog(@"%@",_todayDate);
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [_calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_todayDate];
        
        
        
        self.text = [[self monthNameFromId:components.month] stringByAppendingString:[NSString stringWithFormat:@" %li",(long)components.year]];
    }
    return self;
}

- (NSString*) monthNameFromId:(NSInteger)identifier{
    switch (identifier) {
        case 1:
            return @"Январь";
            break;
        case 2:
            return @"Февраль";
            break;
        case 3:
            return @"Март";
            break;
        case 4:
            return @"Апрель";
            break;
        case 5:
            return @"Май";
            break;
        case 6:
            return @"Июнь";
            break;
        case 7:
            return @"Июль";
            break;
        case 8:
            return @"Август";
            break;
        case 9:
            return @"Сентябрь";
            break;
        case 10:
            return @"Октябрь";
            break;
        case 11:
            return @"Ноябрь";
            break;
        case 12:
            return @"Декабрь";
            break;
        default:
            return nil;
            break;
    }
}

- (NSDate*) setNextMonth{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:1];
    _activeDate = [_calendar dateByAddingComponents:offsetComponents toDate:_activeDate options:0];
    
    NSDateComponents *components = [_calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_activeDate];
    
    self.text = [[self monthNameFromId:components.month] stringByAppendingString:[NSString stringWithFormat:@" %li",(long)components.year]];
 
    return _activeDate;
}

- (NSDate*) setPrevMonth{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-1];
    _activeDate = [_calendar dateByAddingComponents:offsetComponents toDate:_activeDate options:0];
    
    NSDateComponents *components = [_calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_activeDate];
    
    self.text = [[self monthNameFromId:components.month] stringByAppendingString:[NSString stringWithFormat:@" %li",(long)components.year]];
    
    return _activeDate;

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
