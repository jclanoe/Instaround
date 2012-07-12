//
//  InstagramPhoto.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface InstagramPhoto : NSManagedObject

@property (nonatomic, retain) NSString * photoId;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * urlPhotoStandard;
@property (nonatomic, retain) NSString * urlPhotoThumbnail;

- (NSString*)photoStringUrl;

@end
