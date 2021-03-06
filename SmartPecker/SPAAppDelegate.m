//
//  SPAAppDelegate.m
//  SmartPecker
//
//  Created by majstrak on 02.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPAAppDelegate.h"
#import "JASidePanelController.h"
#import "SPANavigationController.h"
#import "SPALoginViewController.h"
#import "SPAScheduleViewController.h"
#import "SPASubjectsViewController.h"
#import "SPAModelCoordinator.h"
#import "SPAModelSubjectsActivationDelegate.h"

@implementation SPAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Model Coordinator
    SPAModelCoordinator* modelCoordinator = [SPAModelCoordinator sharedModelCoordinator];
    
    switch (modelCoordinator.activationMode) {
        case SPAModelActivationModeWebService:{
            
            SPALoginViewController *spaLoginViewController = [[SPALoginViewController alloc] init];
            
            self.spaLoginNavigationController = [[SPANavigationController alloc] initWithRootViewController:spaLoginViewController];
            
            self.window.rootViewController = self.spaLoginNavigationController;
            
            modelCoordinator.activationDelegate = spaLoginViewController;
            
        };break;
        case SPAModelActivationModeCoreData:{
            SPAScheduleViewController *spaScheduleViewController = [[SPAScheduleViewController alloc] init];
            self.spaNavigationController = [[SPANavigationController alloc] initWithRootViewController:spaScheduleViewController];
            
            SPASubjectsViewController *spaSubjectsViewController = [[SPASubjectsViewController alloc] init];
            
            //Init of jaSidePanelController
            self.jaSidePanelController = [[JASidePanelController alloc] init];
            self.jaSidePanelController.centerPanel = self.spaNavigationController;
            self.jaSidePanelController.leftPanel = spaSubjectsViewController;
            modelCoordinator.subjectsActivationDelegate = (id<SPAModelSubjectsActivationDelegate>)spaSubjectsViewController;
            
            self.window.rootViewController = self.jaSidePanelController;
            
            modelCoordinator.activationDelegate = self;
            
        };break;
        case SPAModelActivationModeUndefined:{
            return NO;
        };break;
    

    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - SPAModelActivationDelegate

- (void) modelActivationDone{
    NSLog(@"Activation is Done");
}

- (void) modelAuthenticationDoneWithError:(BOOL)error{
    
}

@end
