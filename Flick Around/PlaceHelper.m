//
//  PlaceHelper.m
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "PlaceHelper.h"

#import <CoreLocation/CoreLocation.h>

#import <RestKit/RestKit.h>
#import "RestKitHelper.h"
#import "PhotoHelper.h"

#import "Place.h"

#import "Config.h"

@interface PlaceHelper() <RKObjectLoaderDelegate, UIAlertViewDelegate>

@property (nonatomic, readwrite) BOOL isLoadingPlace;

@end

@implementation PlaceHelper

@synthesize isLoadingPlace = _isLoadingPlace;

+ (PlaceHelper*)sharedInstance
{
	static PlaceHelper* sharedInstance = nil;
	
	@synchronized ([self class]) {
		if (sharedInstance == nil) {
			sharedInstance = [[PlaceHelper alloc] init];
		}
	}
	
	return sharedInstance;
}

- (NSString*)formatPhotoRequestWithCoordinate:(CLLocationCoordinate2D)coordinate
{
	return [NSString stringWithFormat:@"/?method=%@&api_key=%@&format=%@&nojsoncallback=1&lat=%f&lon=%f", API_FIND_PLACE_BY_LOCATION, FLICKR_API_KEY, FORMAT, coordinate.latitude, coordinate.longitude];
}

- (void)loadPlaceForCoordinate:(CLLocationCoordinate2D)coordinate
{
	self.isLoadingPlace = YES;
	
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:[self formatPhotoRequestWithCoordinate:coordinate] usingBlock:^(RKObjectLoader* loader) {
		loader.method = RKRequestMethodGET;
		loader.objectMapping = [RestKitHelper sharedInstance].placeMapping;
		loader.delegate = self;
	}];
}

#pragma mark - RKObjectLoaderDelegate Protocol

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
	NSLog(@"Object Loader Did FAIL");
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
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PlaceHelperDidFailLoadingPlaceNotification object:nil userInfo:nil];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
	self.isLoadingPlace = NO;
	
	if ([objects count])
	{
		id object = [objects objectAtIndex:0];
		if ([object isKindOfClass:[Place class]])
		{
			Place* place = (Place*)object;
			[[NSNotificationCenter defaultCenter] postNotificationName:PlaceHelperDidLoadPlaceNotification object:place userInfo:nil];
		}
	}
	
//	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
