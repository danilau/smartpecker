//
//  SPATeacher.m
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPATeacher.h"

@implementation SPATeacher

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithFirstName:(NSString*) firstName AndMiddleName:(NSString*) middleName AndLastName:(NSString*) lastName AndId:(NSInteger) teacherId{
    if (self = [super init]) {
        self.firstName = firstName;
        self.middleName = middleName;
        self.lastName = lastName;
        self.teacherId = teacherId;
    }
    return self;
}

@end
