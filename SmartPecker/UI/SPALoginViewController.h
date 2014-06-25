//
//  SPALoginViewController.h
//  SmartPecker
//
//  Created by majstrak on 04.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPANetworkCoordinatorDelegate.h"
#import "SPAModelActivationDelegate.h"

@interface SPALoginViewController : UIViewController <SPANetworkCoordinatorDelegate, SPAModelActivationDelegate>

@end
