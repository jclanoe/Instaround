//
//  PhotoLocationHelper.h
//  Flick Around
//
//  Created by Clem André on 7/3/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PhotoLocationHelperDidLoadLocationNotification @"PhotoLocationHelperDidLoadLocationNotification"
#define PhotoLocationHelperDidFailLoadingLocationNotification @"PhotoLocationHelperDidFailLoadingLocationNotification"

@class Photo;

@interface PhotoLocationHelper : NSObject

+ (PhotoLocationHelper*)sharedInstance;
- (void)loadLocationForPhoto:(Photo*)photo;

@end
