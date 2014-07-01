//
//  SPALesson.m
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPALesson.h"

@implementation SPALesson

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithSubject:(SPASubject*) subject AndTeacher:(SPATeacher*) teacher AndLocation:(SPALocation*) location{
    if (self = [super init]) {
        self.subject = subject;
        self.teacher = teacher;
        self.location = location;
    }
    return self;
}

@end
