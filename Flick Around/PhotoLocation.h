//
//  PhotoLocation.h
//  Flick Around
//
//  Created by Clem André on 7/3/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@class Photo;

@interface PhotoLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * context;
@property (nonatomic, retain) NSString * placeId;
@property (nonatomic, retain) NSString * accuracy;
@property (nonatomic, retain) NSString * county;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * locality;
@property (nonatomic, retain) Photo * photo;

- (CLLocationCoordinate2D)getCoordinate;

@end
