//
//  MapAnnotation.h
//  Flick Around
//
//  Created by JC on on 7/3/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSURL* thumbnailURL;
@property (nonatomic, copy) NSURL* standardURL;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
