//
//  SPASubject.h
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPASubject : NSObject

@property (nonatomic) NSInteger subjectId;
@property (nonatomic,strong) NSString* name;

- (id)init;
- (id)initWithName:(NSString*) name AndId:(NSInteger) subjectId;

@end
