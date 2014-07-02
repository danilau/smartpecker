//
//  SPAModelActivationDelegate.h
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPAModelActivationDelegate <NSObject>

- (void) modelActivationDone;
- (void) modelAuthenticationDoneWithError:(BOOL) error;

@end
