//
//  PhotoLocationHelper.m
//  Flick Around
//
//  Created by Clem André on 7/3/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "PhotoLocationHelper.h"

#import <RestKit/RestKit.h>
#import "RestKitHelper.h"

#import "Photo.h"
#import "PhotoLocation.h"

#import "Config.h"


@interface PhotoLocationHelper() <RKObjectLoaderDelegate, UIAlertViewDelegate>

@property (nonatomic, readwrite) BOOL isLoadingPhotoLocation;

@end


@implementation PhotoLocationHelper

@synthesize isLoadingPhotoLocation = _isLoadingPhotoLocation;

+ (PhotoLocationHelper*)sharedInstance
{
	static PhotoLocationHelper* sharedInstance = nil;
	
	@synchronized ([self class]) {
		if (sharedInstance == nil) {
			sharedInstance = [[PhotoLocationHelper alloc] init];
		}
	}
	
	return sharedInstance;
}

- (NSString*)formatPhotoLocationRequestWithPhoto:(Photo*)photo
{
	return [NSString stringWithFormat:@"/?method=%@&api_key=%@&format=%@&nojsoncallback=1&photo_id=%@", API_GET_LOCATION, FLICKR_API_KEY, FORMAT, photo.photoId];
}

- (void)loadLocationForPhoto:(Photo*)photo
{
	self.isLoadingPhotoLocation = YES;
	
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:[self formatPhotoLocationRequestWithPhoto:photo] usingBlock:^(RKObjectLoader* loader) {
		loader.method = RKRequestMethodGET;
		loader.objectMapping = [RestKitHelper sharedInstance].photoLocationMapping;
		loader.delegate = self;
	}];
}

#pragma mark - RKObjectLoaderDelegate Protocol

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
	NSLog(@"Photo Location Loader Did FAIL");
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
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PhotoLocationHelperDidFailLoadingLocationNotification object:nil userInfo:nil];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
//	NSLog(@"Photo Location Loader Did LOAD : %@", objects);
	
	self.isLoadingPhotoLocation = NO;
	
	if ([objects count])
	{
		id object = [objects objectAtIndex:0];
		if ([object isKindOfClass:[PhotoLocation class]])
		{
			PhotoLocation* location = (PhotoLocation*)object;
			[[NSNotificationCenter defaultCenter] postNotificationName:PhotoLocationHelperDidLoadLocationNotification object:location userInfo:nil];
		}
	}
	
	//	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
