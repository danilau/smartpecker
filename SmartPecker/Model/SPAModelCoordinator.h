//
//  SPAModelCoordinator.h
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAWebServiceCoordinator.h"
#import "SPAWebServiceCoordinatorDelegate.h"

typedef enum _SPAModelActivationMode {
    SPAModelActivationModeCoreData = 0,
    SPAModelActivationModeWebService
} SPAModelActivationMode;

@interface SPAModelCoordinator : NSObject <SPAWebServiceCoordinatorDelegate>

@property (nonatomic) BOOL activated;
@property (nonatomic) SPAModelActivationMode activationMode;
@property (nonatomic,strong) SPAWebServiceCoordinator* webServiceCoordinator;

+ (id)sharedModelCoordinator;

@end
