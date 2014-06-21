//
//  SPANetworkCoordinator.h
//  SmartPecker
//
//  Created by majstrak on 20.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPANetworkCoordinatorDelegate.h"

@interface SPANetworkCoordinator : NSObject

@property (nonatomic) BOOL authenticated;

@property (nonatomic, weak) id<SPANetworkCoordinatorDelegate> delegate;

+ (id)sharedNetworkCoordinator;

- (void) makeAuthenticationWithName:(NSString*) name AndPass:(NSString*) pass;
- (void) logOut;

@end
