//
//  SPALocation.m
//  SmartPecker
//
//  Created by majstrak on 30.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPALocation.h"

@implementation SPALocation

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithBuilding:(NSString*) building AndRoom:(NSString*) room AndLatitude:(float) latitude AndLongitude:(float)longitude AndId:(NSInteger) locationId{
    if (self = [super init]) {
        self.building = building;
        self.room = room;
        self.latitude = latitude;
        self.longitude = longitude;
        self.locationId = locationId;
    }
    return self;
}

@end
