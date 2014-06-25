//
//  SPAModelCoordinator.m
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPAModelCoordinator.h"

typedef enum _SPAModelActivationDirection {
    SPAModelActivationDirectionCoreData = 0,
    SPAModelActivationDirectionWebService
} SPAModelActivationDirection;

@interface SPAModelCoordinator ()

- (SPAModelActivationDirection) checkActivationDirection;
- (void) activateWithCoreData;
- (void) activateWithAuthentication;

@end

@implementation SPAModelCoordinator

+ (id)sharedModelCoordinator {
    static SPAModelCoordinator *sharedModelCoordinator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModelCoordinator = [[self alloc] init];
    });
    return sharedModelCoordinator;
}

- (id)init {
    if (self = [super init]) {
        self.activated = NO;
        self.webServiceCoordinator = [[SPAWebServiceCoordinator alloc] init];
        self.webServiceCoordinator.delegate = self;
        
        SPAModelActivationDirection direction = [self  checkActivationDirection];
        if(direction == SPAModelActivationDirectionWebService){
            [self activateWithAuthentication];
        }else{
            [self activateWithCoreData];
        }
        
    }
    return self;
}

#pragma mark - Activation

- (SPAModelActivationDirection) checkActivationDirection{
    
    return SPAModelActivationDirectionWebService;
    
}

- (void) activateWithCoreData{
    
}

- (void) activateWithAuthentication{

}

@end
