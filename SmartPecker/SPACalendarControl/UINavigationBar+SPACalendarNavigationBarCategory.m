//
//  UINavigationBar+SPACalendarNavigationBarCategory.m
//  SmartPecker
//
//  Created by majstrak on 16.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "UINavigationBar+SPACalendarNavigationBarCategory.h"

@implementation UINavigationBar (SPACalendarNavigationBarCategory)


- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSArray *classNamesToReposition = @[@"SPACalendarNavigationView"];
    
    for (UIView *view in [self subviews]) {
        
        if ([classNamesToReposition containsObject:NSStringFromClass([view class])]) {
            NSLog(@"sdf");
            CGRect frame = [view frame];
            
            frame.origin.x = 0.0;
            frame.origin.y = 0.0;
            
            [view setFrame:frame];
        }
    }
    
}

@end
