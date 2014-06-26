//
//  SPAWebServiceCoordinator.m
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPAWebServiceCoordinator.h"

typedef enum _SPAWebServiceMessageStatus {
    SPAWebServiceMessageStatusError = 0,
    SPAWebServiceMessageStatusInfo
} SPAWebServiceMessageStatus;

@interface SPAWebServiceCoordinator (){
    NSURL* _webServiceURL;
}

- (void) showMessageWithString:(NSString*) string AndStatus:(SPAWebServiceMessageStatus) status;

@end

@implementation SPAWebServiceCoordinator

-(id) init {
    self = [super init];
    if (self) {
        [self clearCookies];
    }
    return(self);
}

-(id) initWithURL:(NSURL*) url {
    self = [super init];
    if (self) {
        [self clearCookies];
        _webServiceURL = url;
        NSLog(@"%@",url);
    }
    return(self);
}

- (void) makeAuthorizationWithName:(NSString*) aname AndPass:(NSString*) apass{
    //Drupal form authentication
    
    NSURLSessionConfiguration* sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    sessionConfiguration.allowsCellularAccess = YES;
    sessionConfiguration.timeoutIntervalForRequest = 30.0;
    sessionConfiguration.timeoutIntervalForResource = 60.0;
    sessionConfiguration.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
    NSURL* url = [NSURL URLWithString:@"http://spectest.usbelar.by/user"];
    
    NSMutableURLRequest* formCodeRequest = [NSMutableURLRequest requestWithURL:url];
    //Task to obtain code from authorization form
    NSURLSessionDataTask* formCodeTask = [session dataTaskWithRequest:formCodeRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        
        if(error != nil){
            if(error.code == -1009){
                [self showMessageWithString:@"Интернет соединение отсутствует." AndStatus:SPAWebServiceMessageStatusError];
            }
            
            return;
        }
        
        NSString *formBuildId;
        NSString *name = aname;
        NSString *pass = apass;
        NSString *formId = @"user_login";
        NSString *op = @"Log in";
        
        NSString* dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if([dataString rangeOfString:@"value=\"form-"].location != NSNotFound){
            NSInteger formHashCodeStartPosition = [dataString rangeOfString:@"value=\"form-"].location+7;
            NSInteger formHashCodeLength = 48;
            NSRange formHashRange = NSMakeRange(formHashCodeStartPosition, formHashCodeLength);
            formBuildId = [dataString substringWithRange:formHashRange];
        }else{
            [self showMessageWithString:@"Изменение условий авторизации на сайте." AndStatus:SPAWebServiceMessageStatusError];
            return;
        }
        
        NSMutableURLRequest* authorizationRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:30.0];
        [authorizationRequest setHTTPMethod:@"POST"];
        
        NSString* postString = [NSString stringWithFormat:@"name=%@&pass=%@&form_build_id=%@&form_id=%@&op=%@",name,pass,formBuildId,formId,op];
        
        
        [authorizationRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Task to make authorization
        NSURLSessionDataTask* authorizationTask = [session dataTaskWithRequest:authorizationRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
            
            if(error != nil){
                if(error.code == -1009){
                    [self showMessageWithString:@"Интернет соединение отсутствует." AndStatus:SPAWebServiceMessageStatusError];
                }
                return;
            }
            
            
            
            NSURL* specURL = [NSURL URLWithString:@"http://spectest.usbelar.by/smartpecker"];
            NSMutableURLRequest* checkRequest = [NSMutableURLRequest requestWithURL:specURL];
            //Task to check if user authenticated
            NSURLSessionDataTask* checkTask = [session dataTaskWithRequest:checkRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
                
                if(error != nil){
                    if(error.code == -1009){
                        [self showMessageWithString:@"Интернет соединение отсутствует." AndStatus:SPAWebServiceMessageStatusError];
                    }
                    return;
                }
                
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                
                switch (httpResponse.statusCode) {
                    case 200:{
                        [self showMessageWithString:@"Вход осуществлен успешно." AndStatus:SPAWebServiceMessageStatusError];
                        dispatch_sync(dispatch_get_main_queue(), ^(){
                            if([[self delegate] respondsToSelector:@selector(didMakeAuthentication)]) {
                                [[self delegate] didMakeAuthentication];
                                
                            }
                        });
                    };break;
                    case 401:{
                        [self showMessageWithString:@"Неверный логин либо пароль." AndStatus:SPAWebServiceMessageStatusError];
                    };break;
                    default:{
                        [self showMessageWithString:@"Ошибка сервера при авторизации." AndStatus:SPAWebServiceMessageStatusError];
                    };break;
                }
                
            }];
            
            [checkTask resume];
            
        }];
        
        [authorizationTask resume];
        
    }];
    
    [formCodeTask resume];

}

- (void) showMessageWithString:(NSString *)string AndStatus:(SPAWebServiceMessageStatus)status{
    
    NSString* title;
    
    switch (status) {
        case SPAWebServiceMessageStatusError:
            title = @"Ошибка";
            break;
            
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:string delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles: nil];
        [alert show];
    });
}

- (void)clearCookies{
    
    NSArray * array = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://spectest.usbelar.by"]];
    
    for (NSHTTPCookie* cookie in array) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
}

@end
