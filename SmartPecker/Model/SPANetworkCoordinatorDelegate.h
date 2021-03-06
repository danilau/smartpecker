//
//  SPANetworkCoordinatorDelegate.h
//  SmartPecker
//
//  Created by majstrak on 21.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPANetworkCoordinatorDelegate <NSObject>

- (void) didChangeReachabilityWithHostStatus:(BOOL) status;
- (void) didChangeReachabilityWithInternetStatus:(BOOL) status;

@end
