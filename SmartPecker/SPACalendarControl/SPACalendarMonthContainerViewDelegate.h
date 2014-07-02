//
//  SPACalendarMonthContainerViewDelegate.h
//  SmartPecker
//
//  Created by majstrak on 20.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPACalendarMonthContainerViewDelegate <NSObject>

- (void) dateFromCalendarWithDay:(NSInteger) day AndMonth:(NSInteger) month AndYear:(NSInteger) year AndWeekDay:(NSInteger) weekday;

@end
