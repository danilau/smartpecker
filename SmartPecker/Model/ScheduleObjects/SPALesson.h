//
//  SPALesson.h
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPASubject.h"
#import "SPALocation.h"
#import "SPATeacher.h"

@interface SPALesson : NSObject

@property (nonatomic) NSString* startTime;
@property (nonatomic) NSString* finishTime;
@property (nonatomic) NSInteger weekday;

@property (nonatomic,strong) SPASubject* subject;
@property (nonatomic,strong) SPATeacher* teacher;
@property (nonatomic,strong) SPALocation* location;

- (id)init;
- (id)initWithSubject:(SPASubject*) subject AndTeacher:(SPATeacher*) teacher AndLocation:(SPALocation*) location;
- (id)initWithDictionary:(NSDictionary*) dict;

@end
