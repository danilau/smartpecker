//
//  SPARenderedLesson.m
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPARenderedLesson.h"

@implementation SPARenderedLesson

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*) dict{
    if (self = [super init]) {
        
        
        if([dict objectForKey:@"start_time" ] != nil) self.startTime = [dict objectForKey:@"start_time"];
        else self.startTime = @"";
        if([dict objectForKey:@"finish_time" ] != nil) self.finishTime = [dict objectForKey:@"finish_time"];
        else self.finishTime = @"";
        
        if([dict objectForKey:@"weekday" ] != nil) self.weekday = [[dict objectForKey:@"weekday"] integerValue];
        else self.weekday = 0;
        if([dict objectForKey:@"subject_id" ] != nil) self.subjectId = [[dict objectForKey:@"subject_id"] integerValue];
        else self.subjectId = 0;
        if([dict objectForKey:@"teacher_id" ] != nil) self.teacherId = [[dict objectForKey:@"teacher_id"] integerValue];
        else self.teacherId = 0;
        if([dict objectForKey:@"location_id" ] != nil) self.locationId = [[dict objectForKey:@"location_id"] integerValue];
        else self.locationId = 0;

        
        if([dict objectForKey:@"subject_name" ] != nil) self.subjectName = [dict objectForKey:@"subject_name"];
        else self.subjectName = @"";
        if([dict objectForKey:@"teacher_name" ] != nil) self.teacherName = [dict objectForKey:@"teacher_name"];
        else self.teacherName = @"";
        if([dict objectForKey:@"type_of_class" ] != nil) self.classesName = [dict objectForKey:@"type_of_class"];
        else self.classesName = @"";
        if([dict objectForKey:@"location_name" ] != nil) self.locationName = [dict objectForKey:@"location_name"];
        else self.locationName = @"";

        
    }
    return self;
}

@end
