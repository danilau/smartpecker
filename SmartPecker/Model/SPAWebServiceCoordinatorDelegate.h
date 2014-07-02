//
//  SPAWebServiceCoordinatorDelegate.h
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPAWebServiceCoordinatorDelegate <NSObject>

- (void) didMakeAuthenticationWithError:(BOOL)error;
- (void) didReceiveRenderedWeek:(NSArray*) week;
- (void) didReceiveScheduleWithLessons:(NSMutableArray*) lessons;
- (void) didReceiveTeachers:(NSMutableArray*) teachers;
- (void) didReceiveLocations;
- (void) didReceiveSubjects:(NSMutableArray*) subjects;

@end
