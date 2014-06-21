//
//  SPANetworkCoordinator.m
//  SmartPecker
//
//  Created by majstrak on 20.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPANetworkCoordinator.h"

@implementation SPANetworkCoordinator{
    NSURLSession* _session;
}

+ (id)sharedNetworkCoordinator {
    static SPANetworkCoordinator *sharedNetworkCoordinator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkCoordinator = [[self alloc] init];
    });
    return sharedNetworkCoordinator;
}

- (id)init {
    if (self = [super init]) {
        self.authenticated = NO;
        
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)makeAuthenticationWithName:(NSString*) aname AndPass:(NSString*) apass{
    
    //NSURLSession test
    NSURLSessionConfiguration* sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
     
    sessionConfiguration.allowsCellularAccess = YES;
    sessionConfiguration.timeoutIntervalForRequest = 30.0;
    sessionConfiguration.timeoutIntervalForResource = 60.0;
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 1;
     
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
    NSURL* url = [NSURL URLWithString:@"http://spectest.usbelar.by/user"];
     
    NSMutableURLRequest* formHashRequest = [NSMutableURLRequest requestWithURL:url];
     
    NSURLSessionDataTask* hashCodeTask = [_session dataTaskWithRequest:formHashRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        
        if(error != nil){
            if(error.code == -1009){
                dispatch_async(dispatch_get_main_queue(), ^(){
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Интернет подключение отсутствует." delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil];
                    [alert show];
                });
            }
            self.authenticated = NO;
            return;
        }
     
        NSString *formBuildId;
        NSString *name = aname;
        NSString *pass = apass;
        NSString *formId = @"user_login";
        NSString *op = @"Log in";
        
        NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

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
        
       
        [urlRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURLSessionDataTask* dataTask = [_session dataTaskWithRequest:urlRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
            
            if(error != nil){
                if(error.code == -1009){
                    dispatch_async(dispatch_get_main_queue(), ^(){
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Интернет подключение отсутствует." delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil];
                        [alert show];
                    });
                }
                self.authenticated = NO;
                return;
            }

            
            
            NSURL* specURL = [NSURL URLWithString:@"http://spectest.usbelar.by/smartpecker"];
            NSMutableURLRequest* specRequest = [NSMutableURLRequest requestWithURL:specURL];
            
            NSURLSessionDataTask* specTask = [_session dataTaskWithRequest:specRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
                
                if(error != nil){
                    if(error.code == -1009){
                        dispatch_async(dispatch_get_main_queue(), ^(){
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Интернет подключение отсутствует." delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil];
                            [alert show];
                        });
                    }
                    self.authenticated = NO;
                    return;
                }

     	                
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                
                if(httpResponse.statusCode >= 200 && httpResponse.statusCode <300){
                    self.authenticated = YES;

                }else{
                    self.authenticated = NO;
                    dispatch_async(dispatch_get_main_queue(), ^(){
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Неверный логин либо пароль." delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil];
                        [alert show];
                    });

                }
               
                dispatch_sync(dispatch_get_main_queue(), ^(){
                if([[self delegate] respondsToSelector:@selector(didMakeAuthenticationAttemptWithResult:AndData:)]) {
                    [[self delegate] didMakeAuthenticationAttemptWithResult:self.authenticated AndData:data];
                    
                }
                });
         
            }];
            
            [specTask resume];

        }];
     
        [dataTask resume];
     
     }];
     
     [hashCodeTask resume];
}

- (void) logOut{
    //NSURLSession test
    NSArray * array = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://spectest.usbelar.by"]];
    
    for (NSHTTPCookie* cookie in array) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
  
}

@end
