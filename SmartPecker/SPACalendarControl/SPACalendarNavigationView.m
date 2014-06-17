//
//  SPACalendarNavigationView.m
//  SmartPecker
//
//  Created by majstrak on 15.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPACalendarNavigationView.h"
#import "SPACalendarControl.h"

@implementation SPACalendarNavigationView

-(id)initWithController: (UIViewController*) controller{
    self = [super initWithFrame:CGRectMake(0.0,0.0,320.0,44.0)];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //Controller init
        self.controller = controller;
        self.controller.navigationItem.leftBarButtonItem = nil;
        self.controller.navigationItem.rightBarButtonItem = nil;
        
        //Label for navigationItem title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(52.0, 0.0, 216.0, 44.0)];
        titleLabel.text = self.controller.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        //Left button
        UIImage* leftButtonImage = [UIImage imageNamed:@"list.png"];
        self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(8.0, 0.0, 44.0, 44.0)];
        [self.leftButton setImage:leftButtonImage forState:UIControlStateNormal];
        [self.leftButton addTarget:self.controller.navigationItem.leftBarButtonItem.target action:self.controller.navigationItem.leftBarButtonItem.action forControlEvents:UIControlEventTouchDown];

        //Right button
        UIImage* rightButtonImage = [UIImage imageNamed:@"calendar.png"];
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(268.0, 0.0, 44.0, 44.0)];
        [self.rightButton setImage:rightButtonImage forState:UIControlStateNormal];
        [self.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        SPACalendarControl* spaCalendarControl = [[SPACalendarControl alloc] initWithFrame:CGRectMake(-20.0, 0.0, 200.0, 20.0)];
        spaCalendarControl.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.leftButton];
        [self addSubview:titleLabel];
        [self addSubview:self.rightButton];

    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)rightButtonClicked:(UIButton*) sender
{
    CGRect newFrame =  self.controller.navigationController.navigationBar.frame;
    newFrame.size.height = 200.0;
    newFrame.origin.y = 20.0;
    
    
    self.controller.navigationController.navigationBar.frame = newFrame;
    
    
    //self.controller.view.frame = CGRectMake(0.0, 80.0, 320.0, 568.0);
    
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
