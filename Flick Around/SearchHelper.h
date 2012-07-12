//
//  SearchHelper.h
//  Flick Around
//
//  Created by Clem André on 7/12/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define SearchHelperDidLoadPhotoNotification @"SearchHelperDidLoadPhotoNotification"
#define SearchHelperDidFailLoadingPhotoNotification @"SearchHelperDidFailLoadingPhotoNotification"


@interface SearchHelper : NSObject

+ (SearchHelper*)sharedInstance;
- (void)loadSearchedPhotos:(CLLocationCoordinate2D)coordinate;

@property (strong, nonatomic, readonly) NSArray* lastLoadedPhotos;

@end
