//
//  Place.m
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "Place.h"

#import <CoreLocation/CoreLocation.h>

@implementation Place

@dynamic latitude;
@dynamic longitude;
@dynamic placeId;

- (CLLocationCoordinate2D)getCoordinate
{
	return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

@end
