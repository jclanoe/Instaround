//
//  PhotoHelper.m
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "PhotoHelper.h"

#import <CoreLocation/CoreLocation.h>

#import <RestKit/RestKit.h>
#import "RestKitHelper.h"

#import "Photo.h"
#import "Place.h"

#import "Config.h"


@interface PhotoHelper() <RKObjectLoaderDelegate, UIAlertViewDelegate>

@property (nonatomic, readwrite) BOOL isLoadingPhotos;

@end

@implementation PhotoHelper

@synthesize isLoadingPhotos = _isLoadingPhotos;

- (id)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}

+ (PhotoHelper*)sharedInstance
{
	static PhotoHelper* sharedInstance = nil;
	
	@synchronized ([self class]) {
		if (sharedInstance == nil) {
			sharedInstance = [[PhotoHelper alloc] init];
		}
	}
	
	return sharedInstance;
}

- (NSString*)formatPhotoRequestWithPlace:(Place*)place
{
//	return [NSString stringWithFormat:@"/?method=%@&api_key=%@&format=%@&nojsoncallback=1&place_id=%@&per_page=30", API_SEARCH, FLICKR_API_KEY, FORMAT, place.placeId];
	return [NSString stringWithFormat:@"/?method=%@&api_key=%@&format=%@&nojsoncallback=1&lat=%@&lon=%@&per_page=30&radius=15", API_SEARCH, FLICKR_API_KEY, FORMAT, place.latitude, place.longitude];
}

- (void)loadPhotosForPlace:(Place*)place
{
	self.isLoadingPhotos = YES;
	
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:[self formatPhotoRequestWithPlace:place] usingBlock:^(RKObjectLoader* loader) {
		loader.method = RKRequestMethodGET;
		loader.objectMapping = [RestKitHelper sharedInstance].photoMapping;
		loader.delegate = self;
	}];
}

#pragma mark - RKObjectLoaderDelegate Protocol

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
	if ([error code] == RKRequestBaseURLOfflineError)
	{
//		[UIAlertView alertForNetworkErrorWithTag: MissionRequestAlertTagUnlockMission delegate:self userInfo:objectLoader.userData];
	}
	else
	{
//		[UIAlertView
//		 alertWithTitle: NSLocalizedString(@"Oops", nil)
//		 message: NSLocalizedString(@"An error occurred, your mission couldn't be unlocked. Try again?", nil)
//		 delegate: self
//		 cancelButtonTitle: NSLocalizedString(@"Cancel", nil)
//		 confirmButtonTitle: NSLocalizedString(@"Try again", nil)
//		 tag: MissionRequestAlertTagUnlockMission
//		 userInfo:objectLoader.userData];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PhotoHelperDidFailLoadingPhotosNotification object:nil userInfo:nil];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
	self.isLoadingPhotos = NO;
	
	if ([objects count] == 0)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:PhotoHelperDidLoadNothingNotification object:nil userInfo:nil];
	}
	
	for (id object in objects) {
		Photo* photo = (Photo*)object;
		NSLog(@"Did Load Photo %@ : %@", photo.serverId, [photo photoStringUrl]);
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PhotoHelperDidLoadPhotosNotification object:objects userInfo:nil];
	
//	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:MissionUserDefaultHasLoadedMissionsOnce];
//	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
