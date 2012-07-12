//
//  InstagramUser.m
//  Flick Around
//
//  Created by JC on on 7/7/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import "InstagramUser.h"
#import <RestKit/RestKit.h>


@implementation InstagramUser

@dynamic serverId;
@dynamic username;
@dynamic fullName;
@dynamic profilePicture;
@dynamic accessToken;
@dynamic isCurrent;

+ (InstagramUser*)currentUser
{
	InstagramUser* currentUser = [InstagramUser findFirstByAttribute:@"isCurrent" withValue:[NSNumber numberWithBool:YES]];
	return currentUser;
}

@end
