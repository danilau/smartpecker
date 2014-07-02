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

- (id)initWithDictionary:(NSDictionary*) dict{
    if (self = [super init]) {
        
        
        if([dict objectForKey:@"start_time" ] != nil) self.startTime = [dict objectForKey:@"start_time"];
        else self.startTime = @"";
        if([dict objectForKey:@"finish_time" ] != nil) self.finishTime = [dict objectForKey:@"finish_time"];
        else self.finishTime = @"";
        
        self.subject = [[SPASubject alloc] init];
        self.teacher = [[SPATeacher alloc] init];
        self.location = [[SPALocation alloc] init];
        
        if([dict objectForKey:@"subject_id" ] != nil) self.subject.subjectId = [[dict objectForKey:@"subject_id"] integerValue];
        else self.subject.subjectId = 0;
        if([dict objectForKey:@"teacher_id" ] != nil) self.teacher.teacherId = [[dict objectForKey:@"teacher_id"] integerValue];
        else self.teacher.teacherId = 0;
        if([dict objectForKey:@"location_id" ] != nil) self.location.locationId = [[dict objectForKey:@"location_id"] integerValue];
        else self.location.locationId = 0;
        
        
        
    }
    return self;
}

@end
