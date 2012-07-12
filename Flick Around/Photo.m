//
//  Photo.m
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "Photo.h"


@implementation Photo

@dynamic photoId;
@dynamic owner;
@dynamic secret;
@dynamic serverId;
@dynamic farmId;
@dynamic title;
@synthesize location;

- (NSString*)photoStringUrl
{
	return [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@_z.jpg", [self.farmId intValue], self.serverId, self.photoId, self.secret];
}

@end
