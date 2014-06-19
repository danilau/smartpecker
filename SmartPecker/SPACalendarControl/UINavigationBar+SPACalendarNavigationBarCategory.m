//
//  UINavigationBar+SPACalendarNavigationBarCategory.m
//  SmartPecker
//
//  Created by majstrak on 16.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "UINavigationBar+SPACalendarNavigationBarCategory.h"
#import "SPACalendarNavigationView.h"

@implementation UINavigationBar (SPACalendarNavigationBarCategory)

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
    NSArray *classNamesToReposition = @[@"SPACalendarNavigationView"];
    
    for (UIView *view in [self subviews]) {
        
        //NSLog
        
        if ([classNamesToReposition containsObject:NSStringFromClass([view class])]) {
            
            //Check if visible viewController is equal to main controller
            NSString* calendarViewControllerName = [((SPACalendarNavigationView*)view).controller.class description];
            NSString* currentViewControllerName = [((UINavigationController*)((SPACalendarNavigationView*)view).controller.navigationController).visibleViewController.class description];
            
            if(![calendarViewControllerName isEqualToString:currentViewControllerName]){
                ((SPACalendarNavigationView*)view).opened = NO;
            }
            
            //Check if CalendarNavigationView is opened
            
            CGRect newFrame;
            
            if(((SPACalendarNavigationView*)view).opened){
                
                newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, ((SPACalendarNavigationView*)view).calendarHeight);

            }else{
                newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44.0);
                //SPACalendarNavigationView coordinates correction
                CGRect originalCalendarFrame = CGRectMake(0.0,0.0,320.0,44.0);
                view.frame = originalCalendarFrame;
            }
            
            [self setFrame:newFrame];
        }
        
        if([[view.class description] isEqualToString:@"_UINavigationBarBackIndicatorView"]){
            //BackIndicator Correction
            CGRect backIndicatorFrame = CGRectMake(8.0,12.0,12.5,20.5);
            view.frame = backIndicatorFrame;
        }
    }
    
}


@end
