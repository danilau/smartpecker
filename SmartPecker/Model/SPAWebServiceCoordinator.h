//
//  SPAWebServiceCoordinator.h
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAWebServiceCoordinatorDelegate.h"

@interface SPAWebServiceCoordinator : NSObject

@property (nonatomic,weak) id<SPAWebServiceCoordinatorDelegate> delegate;

- (id) initWithURL:(NSURL*)url;

- (void) makeAuthorizationWithName:(NSString*) name AndPass:(NSString*) pass;
- (void) clearCookies;

@end
