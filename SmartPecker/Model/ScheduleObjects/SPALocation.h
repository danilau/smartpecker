//
//  SPALocation.h
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPALocation : NSObject

@property (nonatomic) NSInteger locationId;
@property (nonatomic,strong) NSString* building;
@property (nonatomic,strong) NSString* room;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

- (id)init;
- (id)initWithBuilding:(NSString*) building AndRoom:(NSString*) room AndLatitude:(float) latitude AndLongitude:(float)longitude AndId:(NSInteger) locationId;

@end
