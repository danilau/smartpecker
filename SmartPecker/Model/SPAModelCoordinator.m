//
//  SPAModelCoordinator.m
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPAModelCoordinator.h"

@interface SPAModelCoordinator ()

- (SPAModelActivationMode) checkActivationMode;

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
        _activated = NO;
        self.webServiceCoordinator = [[SPAWebServiceCoordinator alloc] init];
        self.webServiceCoordinator.delegate = self;
        _activationMode = [self checkActivationMode];
        
    }
    return self;
}

#pragma mark - Activation

- (SPAModelActivationMode) checkActivationMode{
    
    return SPAModelActivationModeWebService;
    
}

- (void) activateViaCoreData{
    if([[self activationDelegate] respondsToSelector:@selector(modelActivationDone)]) {
        [[self activationDelegate] modelActivationDone];
    }
}

- (void) activateViaWebServiceWithLogin:(NSString*) login AndPassword:(NSString*) password{
    NSLog(@"%@ %@",login,password);
    if([[self activationDelegate] respondsToSelector:@selector(modelActivationDone)]) {
        [[self activationDelegate] modelActivationDone];
    }

}

@end
