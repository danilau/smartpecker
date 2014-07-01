//
//  SPATeacher.h
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPATeacher : NSObject

@property (nonatomic) NSInteger teacherId;
@property (nonatomic,strong) NSString* firstName;
@property (nonatomic,strong) NSString* middleName;
@property (nonatomic,strong) NSString* lastName;

- (id)init;
- (id)initWithFirstName:(NSString*) firstName AndMiddleName:(NSString*) middleName AndLastName:(NSString*) lastName AndId:(NSInteger) teacherId;

@end
