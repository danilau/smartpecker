//
//  SPAAppDelegate.h
//  SmartPecker
//
//  Created by majstrak on 02.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPAModelActivationDelegate.h"

@class JASidePanelController, SPANavigationController;

@interface SPAAppDelegate : UIResponder <UIApplicationDelegate, SPAModelActivationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SPANavigationController *spaLoginNavigationController;
@property (strong, nonatomic) SPANavigationController *spaNavigationController;
@property (strong, nonatomic) JASidePanelController *jaSidePanelController;

@end
