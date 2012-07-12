//
//  Place.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * placeId;

- (CLLocationCoordinate2D)getCoordinate;

@end
