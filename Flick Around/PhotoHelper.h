//
//  PhotoHelper.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PhotoHelperDidLoadPhotosNotification @"PhotoHelperDidLoadPhotosNotification"
#define PhotoHelperDidFailLoadingPhotosNotification @"PhotoHelperDidFailLoadingPhotosNotification"
#define PhotoHelperDidLoadNothingNotification @"PhotoHelperDidLoadNothingNotification"

@class Place;

@interface PhotoHelper : NSObject

@property (nonatomic, readonly) BOOL isLoadingPhotos;

+ (PhotoHelper*)sharedInstance;
- (void)loadPhotosForPlace:(Place*)place;

@end
