//
//  SPACalendarNavigationView.h
//  SmartPecker
//
//  Created by majstrak on 15.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPACalendarNavigationView : UIView

@property (nonatomic,weak) UIViewController* controller;
@property (nonatomic,strong) UIButton* rightButton;
@property (nonatomic,strong) UIButton* leftButton;
@property (nonatomic) BOOL opened;
@property (nonatomic) CGFloat calendarHeight;


- (id)initWithController:(UIViewController*) controller;

@end
