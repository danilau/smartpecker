//
//  SPACalendarMonthLabel.m
//  SmartPecker
//
//  Created by majstrak on 19.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPACalendarMonthLabel.h"

@implementation SPACalendarMonthLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSDate *date = [NSDate date];
        NSLog(@"%@",date);
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
        
        self.text = [[self monthNameFromId:components.month] stringByAppendingString:[NSString stringWithFormat:@" %i",components.year]];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
