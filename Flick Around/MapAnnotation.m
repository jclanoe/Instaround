//
//  MapAnnotation.m
//  Flick Around
//
//  Created by Clem André on 7/3/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "MapAnnotation.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation MapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize thumbnailURL = _thumbnailURL;
@synthesize standardURL = _standardURL;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
	_coordinate = coordinate;
	
	return self;
}

- (void)setTitle:(NSString *)title
{
	_title = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
	_subtitle = subtitle;
}

- (void)setThumbnailURL:(NSURL *)thumbnailURL
{
	_thumbnailURL = thumbnailURL;
}

@end
