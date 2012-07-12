//
//  RestKitHelper.h
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKManagedObjectStore;
@class RKManagedObjectMapping;
@class RKObjectLoader;
@class RKRequestQueue;
@class RKClient;
@class RKObjectManager;

@interface RestKitHelper : NSObject

- (BOOL)save;
+ (RestKitHelper*)sharedInstance;

// Object and request managers
@property (nonatomic, strong) RKManagedObjectStore* objectStore;
@property (nonatomic, strong) RKObjectManager* objectManager;
@property (nonatomic, strong) RKClient* apiClient;

// Object Mappings
@property (nonatomic, strong) RKManagedObjectMapping* placeMapping;
@property (nonatomic, strong) RKManagedObjectMapping* photoMapping;
@property (nonatomic, strong) RKManagedObjectMapping* photoLocationMapping;
@property (nonatomic, strong) RKManagedObjectMapping* infoMapping;
@property (nonatomic, strong) RKManagedObjectMapping* instagramUserMapping;

@end