//
//  PhotoLocation.m
//  Flick Around
//
//  Created by Clem André on 7/3/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "PhotoLocation.h"

#import <CoreLocation/CoreLocation.h>

@implementation PhotoLocation

@dynamic latitude;
@dynamic longitude;
@dynamic accuracy;
@dynamic context;
@dynamic county;
@dynamic region;
@dynamic country;
@dynamic locality;
@dynamic placeId;
@dynamic photo;

- (CLLocationCoordinate2D)getCoordinate
{
	return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

@end
