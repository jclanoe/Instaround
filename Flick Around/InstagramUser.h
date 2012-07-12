//
//  InstagramUser.h
//  Flick Around
//
//  Created by Clem André on 7/7/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface InstagramUser : NSManagedObject

@property (nonatomic, retain) NSString * serverId;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * profilePicture;
@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic) BOOL isCurrent;

+ (InstagramUser*)currentUser;

@end
