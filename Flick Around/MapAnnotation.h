//
//  MapAnnotation.h
//  Flick Around
//
//  Created by Clem André on 7/3/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
