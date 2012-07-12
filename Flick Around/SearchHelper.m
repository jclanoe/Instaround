//
//  SearchHelper.m
//  Flick Around
//
//  Created by Clem André on 7/12/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "SearchHelper.h"

#import <CoreLocation/CoreLocation.h>

#import <RestKit/RestKit.h>
#import "RestKitHelper.h"

#import "InstagramUser.h"
#import "InstagramPhoto.h"

#import "Config.h"


@interface SearchHelper() <RKObjectLoaderDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSArray* lastLoadedPhotos;

@end

@implementation SearchHelper

@synthesize lastLoadedPhotos = _lastLoadedPhotos;

+ (SearchHelper*)sharedInstance
{
	static SearchHelper* sharedInstance = nil;
	
	@synchronized ([self class]) {
		if (sharedInstance == nil) {
			sharedInstance = [[SearchHelper alloc] init];
		}
	}
	
	return sharedInstance;
}

- (void)loadSearchedPhotos:(CLLocationCoordinate2D)coordinate
{
	NSString* path = [NSString stringWithFormat:@"%@", INSTAGRAM_SEARCH_LOCATION];
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
		loader.method = RKRequestMethodGET;
		loader.objectMapping = [RestKitHelper sharedInstance].searchMapping;
		NSDictionary* params = [NSDictionary dictionaryWithKeysAndObjects:
								@"lat", [NSString stringWithFormat:@"%f", coordinate.latitude],
								@"lng", [NSString stringWithFormat:@"%f", coordinate.longitude],
								@"access_token", [InstagramUser currentUser].accessToken,
								@"distance", @"5000",
								nil];
		NSLog(@"PARAMS : %@", params);
		loader.resourcePath = [loader.resourcePath stringByAppendingQueryParameters:params];
		loader.delegate = self;
	}];
}

#pragma mark - RKObjectLoaderDelegate Protocol

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
	NSLog(@"Object Loader Did FAIL");
	if ([error code] == RKRequestBaseURLOfflineError)
	{
		
	}
	else
	{
		
	}
	
//	[[NSNotificationCenter defaultCenter] postNotificationName: object:nil userInfo:nil];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
	if ([objects count])
	{
		id object = [objects objectAtIndex:0];
		if ([object isKindOfClass:[InstagramPhoto class]])
		{
			self.lastLoadedPhotos = objects;
			[[NSNotificationCenter defaultCenter] postNotificationName:SearchHelperDidLoadPhotoNotification object:objects userInfo:nil];
		}
	}
}

@end
