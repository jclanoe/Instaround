//
//  InstagramPhoto.m
//  Flick Around
//
//  Created by JC on on 7/2/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import "InstagramPhoto.h"


@implementation InstagramPhoto

@dynamic photoId;
@dynamic latitude;
@dynamic longitude;
@dynamic title;
@dynamic subtitle;
@dynamic urlPhotoStandard;
@dynamic urlPhotoThumbnail;

- (NSString*)photoStringUrl
{
//	return [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@_z.jpg", [self.farmId intValue], self.serverId, self.photoId, self.secret];
	return @"";
}

@end
