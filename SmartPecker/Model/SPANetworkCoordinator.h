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

@property (nonatomic,weak) id<SPANetworkCoordinatorDelegate> webServiceDelegate;

- (id)initWithHostName:(NSString*) hostName;

@end
