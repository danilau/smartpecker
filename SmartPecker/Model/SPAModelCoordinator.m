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
        self.webServiceCoordinator = [[SPAWebServiceCoordinator alloc] initWithURL:[NSURL URLWithString:@"http://spectest.usbelar.by"]];
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
    [self.webServiceCoordinator makeAuthorizationWithName:login AndPass:password];
        
    if([[self activationDelegate] respondsToSelector:@selector(modelActivationDone)]) {
        [[self activationDelegate] modelActivationDone];
    }

}

#pragma mark - SPAWebServiceCoordinatorDelegate implementation

- (void) didMakeAuthentication{
    
}

@end
