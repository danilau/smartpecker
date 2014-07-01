//
//  SPASubject.m
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPASubject.h"

@implementation SPASubject

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithName:(NSString*) name AndId:(NSInteger) subjectId{
    if (self = [super init]) {
        self.name = name;
        self.subjectId = subjectId;
    }
    return self;
}

@end
