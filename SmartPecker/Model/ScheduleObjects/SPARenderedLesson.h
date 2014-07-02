//
//  SPARenderedLesson.h
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPARenderedLesson : NSObject

@property (nonatomic) NSString* startTime;
@property (nonatomic) NSString* finishTime;
@property (nonatomic) NSInteger weekday;

@property (nonatomic) NSInteger subjectId;
@property (nonatomic) NSInteger teacherId;
@property (nonatomic) NSInteger locationId;

@property (nonatomic,strong) NSString* subjectName;
@property (nonatomic,strong) NSString* teacherName;
@property (nonatomic,strong) NSString* classesName;
@property (nonatomic,strong) NSString* locationName;

- (id)init;
- (id)initWithDictionary:(NSDictionary*) dict;


@end
