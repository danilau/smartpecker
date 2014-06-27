//
//  SPANetworkCoordinator.m
//  SmartPecker
//
//  Created by majstrak on 20.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPANetworkCoordinator.h"
#import "Reachability/Reachability.h"

@interface SPANetworkCoordinator (){
    BOOL _currentHostStatus;
    BOOL _currentInternetStatus;
}

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@end

@implementation SPANetworkCoordinator

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

- (id)initWithHostName:(NSString*) hostName {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        self.hostReachability = [Reachability reachabilityWithHostName:hostName];
        [self.hostReachability startNotifier];
        
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
    }
    return self;
}
- (void)setWebServiceDelegate:(id<SPANetworkCoordinatorDelegate>)delegate{
    _webServiceDelegate = delegate;
    [self sendDataToDelegateFromReachability:self.hostReachability];
    [self sendDataToDelegateFromReachability:self.internetReachability];
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    [self sendDataToDelegateFromReachability:curReach];
	
}

- (void) sendDataToDelegateFromReachability:(Reachability*) curReach{
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(curReach == self.hostReachability){
        if([[self webServiceDelegate] respondsToSelector:@selector(didChangeReachabilityWithHostStatus:)]) {
            [[self webServiceDelegate] didChangeReachabilityWithHostStatus:(status!=NotReachable?YES:NO)];
        }
    }
    
    if(curReach == self.internetReachability){
        if([[self webServiceDelegate] respondsToSelector:@selector(didChangeReachabilityWithInternetStatus:)]) {
            [[self webServiceDelegate] didChangeReachabilityWithInternetStatus:(status!=NotReachable?YES:NO)];
        }
    }
    
    
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


@end
