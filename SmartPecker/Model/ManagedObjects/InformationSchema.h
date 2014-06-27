//
//  Information_Schema.h
//  SmartPecker
//
//  Created by majstrak on 26.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface InformationSchema : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * value;

@end
