//
//  Photo.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PhotoLocation;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * photoId;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * secret;
@property (nonatomic, retain) NSString * serverId;
@property (nonatomic, retain) NSNumber * farmId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) PhotoLocation * location;

- (NSString*)photoStringUrl;

@end
