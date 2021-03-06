//
//  SPAWebServiceCoordinator.h
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAWebServiceCoordinatorDelegate.h"
#import "SPANetworkCoordinatorDelegate.h"

@interface SPAWebServiceCoordinator : NSObject <SPANetworkCoordinatorDelegate>

@property (nonatomic,weak) id<SPAWebServiceCoordinatorDelegate> delegate;

- (id) initWithURL:(NSURL*)url;

//Web Service Interaction
- (void) makeAuthorizationWithName:(NSString*) name AndPass:(NSString*) pass;
//Web Service API
- (void) getRenderedWeek;
- (void) getSubjects;
- (void) getTeachers;
- (void) getSchedule;
//Cookie cleaning
- (void) clearCookies;

@end
