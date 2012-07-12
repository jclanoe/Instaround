//
//  SearchHelper.h
//  Flick Around
//
//  Created by JC on on 7/12/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
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
