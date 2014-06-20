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

@implementation SPAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //NSURLSession test
    NSURLSessionConfiguration* sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    sessionConfiguration.allowsCellularAccess = NO;
    sessionConfiguration.timeoutIntervalForRequest = 30.0;
    sessionConfiguration.timeoutIntervalForResource = 60.0;
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
    NSURL* url = [NSURL URLWithString:@"http://spectest.usbelar.by/user"];
    
    NSMutableURLRequest* formHashRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask* hashCodeTask = [session dataTaskWithRequest:formHashRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        
        NSString *formBuildId;
        NSString *name = @"admin";
        NSString *pass = @"123";
        NSString *formId = @"user_login";
        NSString *op = @"Log in";
        
        
        NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"Data: %@",dataString);
        if([dataString rangeOfString:@"value=\"form-"].location == NSNotFound){
            //Error
        }else{
            NSInteger formHashCodeStartPosition = [dataString rangeOfString:@"value=\"form-"].location+7;
            NSInteger formHashCodeLength = 48;
            NSRange formHashRange = NSMakeRange(formHashCodeStartPosition, formHashCodeLength);
            formBuildId = [dataString substringWithRange:formHashRange];
        }
        
        NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:30.0];
        [urlRequest setHTTPMethod:@"POST"];
        
        NSString* postString = [NSString stringWithFormat:@"name=%@&pass=%@&form_build_id=%@&form_id=%@&op=%@",name,pass,formBuildId,formId,op];
        NSLog(@"sdf %@",postString);
        
        [urlRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
            NSString* stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"sdf %@",stringData);
        }];
        
        [dataTask resume];
        
    }];
    
    [hashCodeTask resume];
    
   
    
    
    
    SPALoginViewController *spaLoginViewController = [[SPALoginViewController alloc] init];
    
    self.spaLoginNavigationController = [[SPANavigationController alloc] initWithRootViewController:spaLoginViewController];
      
    self.window.rootViewController = self.spaLoginNavigationController;
    
    
    //After authentication
    if(NO){
      
    SPAScheduleViewController *spaScheduleViewController = [[SPAScheduleViewController alloc] init];
    [self.spaNavigationController setViewControllers:[NSArray arrayWithObject:spaScheduleViewController]];
    
    SPASubjectsViewController *spaSubjectsViewController = [[SPASubjectsViewController alloc] init];
    
    //Init of jaSidePanelController
    self.jaSidePanelController = [[JASidePanelController alloc] init];
    self.jaSidePanelController.centerPanel = self.spaNavigationController;
    self.jaSidePanelController.leftPanel = spaSubjectsViewController;
    
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

@end
