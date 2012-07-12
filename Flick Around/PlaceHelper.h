//
//  PlaceHelper.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#define PlaceHelperDidLoadPlaceNotification @"PlaceHelperDidLoadPlaceNotification"
#define PlaceHelperDidFailLoadingPlaceNotification @"PlaceHelperDidFailLoadingPlaceNotification"

@interface PlaceHelper : NSObject

+ (PlaceHelper*)sharedInstance;
- (void)loadPlaceForCoordinate:(CLLocationCoordinate2D)coordinate;

@end
