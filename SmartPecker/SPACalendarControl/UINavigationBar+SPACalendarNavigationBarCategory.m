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

    BOOL opened = NO;
    
    for (UIView *view in [self subviews]) {
        
        //Subviews processing
        
        if ([[view.class description] isEqualToString:@"SPACalendarNavigationView"]) {
            
            opened = ((SPACalendarNavigationView*)view).opened;
            //Check if visible viewController is equal to main controller
            NSString* calendarViewControllerName = [((SPACalendarNavigationView*)view).controller.class description];
            NSString* currentViewControllerName = [((UINavigationController*)((SPACalendarNavigationView*)view).controller.navigationController).visibleViewController.class description];
            
            if(![calendarViewControllerName isEqualToString:currentViewControllerName]){
                opened = NO;
                
                if([[((UINavigationController*)((SPACalendarNavigationView*)view).controller.navigationController).visibleViewController.view.class description] isEqualToString:@"UITableView"]){
                    [((UITableView*)((UINavigationController*)((SPACalendarNavigationView*)view).controller.navigationController).visibleViewController.view) setContentOffset:CGPointMake(0.0, -64.0)];
                }
        
                
            }
            //Check if CalendarNavigationView is opened
            
            CGRect newFrame;
            
            if(opened){
                
                newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, ((SPACalendarNavigationView*)view).calendarHeight+44.0);
                
                  
                //MainController UITableView offset
                
                
                CGRect tableFrame = CGRectMake(0.0,0.0 , 320.0, 568.0);
                [((UITableView*)((SPACalendarNavigationView*)view).controller.view) setFrame:tableFrame];
                for (UIView *tableSubview in [((UITableView*)((SPACalendarNavigationView*)view).controller.view) subviews]) {
                    if ([[tableSubview.class description] isEqualToString:@"UITableViewWrapperView"]) {
                        CGRect tableSubviewFrame = CGRectMake(0.0,((SPACalendarNavigationView*)view).calendarHeight, 320.0, 568.0);
                        [tableSubview setFrame:tableSubviewFrame];
                    }
                }
                
                
                
                
            }else{
                newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44.0);
                //SPACalendarNavigationView coordinates correction
                CGRect originalCalendarFrame = CGRectMake(0.0,0.0,320.0,44.0);
                view.frame = originalCalendarFrame;
                if([calendarViewControllerName isEqualToString:currentViewControllerName]){
                    CGRect anotherControllerFrame = ((UINavigationController*)((SPACalendarNavigationView*)view).controller.navigationController).visibleViewController.view.frame;
                    
                    
                    ((UINavigationController*)((SPACalendarNavigationView*)view).controller.navigationController).visibleViewController.view.frame = anotherControllerFrame;
                }
                
                //MainController UITableView offset
            
                
                CGRect tableFrame = CGRectMake(0.0,0.0 , 320.0, 568.0);
                [((UITableView*)((SPACalendarNavigationView*)view).controller.view) setFrame:tableFrame];
                for (UIView *tableSubview in [((UITableView*)((SPACalendarNavigationView*)view).controller.view) subviews]) {
                    if ([[tableSubview.class description] isEqualToString:@"UITableViewWrapperView"]) {
                        CGRect tableSubviewFrame = CGRectMake(0.0,0.0, 320.0, 568.0);
                        [tableSubview setFrame:tableSubviewFrame];
                    }
                }
                
                
            }
            
            ((SPACalendarNavigationView*)view).opened = opened;
            
            //MonthContainerView processing
            
            for (UIView *view1 in [view subviews]) {
                
                //MonthContainerView
                if([[view1.class description] isEqualToString:@"SPACalendarMonthContainerView"]){
                    if(opened){
                        CGRect originalMonthContainerFrame = CGRectMake(0.0,44.0,320.0,((SPACalendarNavigationView*)view).calendarHeight);
                        view1.frame = originalMonthContainerFrame;
                        
                    }
                    view1.hidden = !opened;
                    
                }
            }
            
            [self setFrame:newFrame];
            

        }
    }
    
    for (UIView *view in [self subviews]) {
        
        if([[view.class description] isEqualToString:@"_UINavigationBarBackIndicatorView"]){
            //BackIndicator Correction
            CGRect backIndicatorFrame = CGRectMake(8.0,12.0,12.5,20.5);
            view.frame = backIndicatorFrame;
        }
    }
    
    
}


@end
