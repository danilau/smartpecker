//
//  SPACalendarMonthContainerView.h
//  SmartPecker
//
//  Created by majstrak on 18.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPACalendarNavigationView.h"
#import "SPACalendarMonthContainerViewDelegate.h"

@interface SPACalendarMonthContainerView : UIView

@property (nonatomic,weak) id<SPACalendarMonthContainerViewDelegate> delegate;
@property (nonatomic,weak) SPACalendarNavigationView *calendarNavigatioView;

@end
