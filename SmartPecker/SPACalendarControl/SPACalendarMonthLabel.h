//
//  SPACalendarMonthLabel.h
//  SmartPecker
//
//  Created by majstrak on 19.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPACalendarMonthLabel : UILabel

@property (nonatomic) NSInteger activeMonth;
@property (nonatomic) NSInteger activeYear;

- (NSDate*) setNextMonth;
- (NSDate*) setPrevMonth;

@end
