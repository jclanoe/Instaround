//
//  InstagramHelper.m
//  Flick Around
//
//  Created by Clem André on 7/7/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "InstagramHelper.h"
#import "InstagramLoginViewController.h"

#import <RestKit/RestKit.h>
#import "RestKitHelper.h"

#import "InstagramUser.h"

#import "Config.h"


@interface InstagramHelper() <RKObjectLoaderDelegate, UIAlertViewDelegate>

@property (nonatomic, readwrite) BOOL isLoadingAccessToken;

@end

@implementation InstagramHelper

@synthesize isLoadingAccessToken = _isLoadingAccessToken;

+ (InstagramHelper*)sharedInstance
{
	static InstagramHelper* sharedInstance = nil;
	
	@synchronized ([self class]) {
		if (sharedInstance == nil) {
			sharedInstance = [[InstagramHelper alloc] init];
		}
	}
	
	return sharedInstance;
}

- (BOOL)handleOpenURL:(NSURL*)url
{
    BOOL result = YES;
	
    NSRange range = [[url resourceSpecifier] rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        NSString* paramString = [[url resourceSpecifier] substringFromIndex:(range.location + range.length)];
        NSArray* params = [paramString componentsSeparatedByString:@"&"];
		
		NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
		
		for (NSString* param in params) {
            NSArray* comp = [param componentsSeparatedByString:@"="];
            if ([comp count] == 2) {
                NSString* key = [comp objectAtIndex:0];
                NSString* value = [comp objectAtIndex:1];
				[parameters setObject:value forKey:key];
            }
        }
		
		if ([parameters objectForKey:@"error"]) {
			[[NSNotificationCenter defaultCenter] postNotificationName:InstagramDidReceiveErrorNotification object:nil userInfo:nil];
		}
		else if ([parameters objectForKey:@"code"]) {
			[[NSNotificationCenter defaultCenter] postNotificationName:InstagramDidReceiveCodeNotification object:[parameters objectForKey:@"code"] userInfo:nil];
		}
    }
	
	return result;
}

#pragma mark - RKObjectLoaderDelegate Protocol

- (void)loadAccessToken:(NSString*)code
{
	self.isLoadingAccessToken = YES;
	
	[[RKObjectManager sharedManager] loadObjectsAtResourcePath:INSTAGRAM_ACCESS usingBlock:^(RKObjectLoader* loader) {
		loader.method = RKRequestMethodPOST;
		loader.objectMapping = [RestKitHelper sharedInstance].instagramUserMapping;
		loader.delegate = self;
		RKParams *params = [RKParams params];
		[params setValue:code forParam:@"code"];
		[params setValue:INSTAGRAM_REDIRECT_URI forParam:@"redirect_uri"];
		[params setValue:@"authorization_code" forParam:@"grant_type"];
		[params setValue:INSTAGRAM_CLIENT_SECRET forParam:@"client_secret"];
		[params setValue:INSTAGRAM_CLIENT_ID forParam:@"client_id"];
		loader.params = params;
		
	}];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Instaround" message:@"Instagram est momentanément indisponible" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Réessayer", nil];
	[alert show];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object
{
	InstagramUser* user = object;
	user.isCurrent = YES;
	[[RestKitHelper sharedInstance] save];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:InstagramDidReceiveUserInfoNotification object:nil userInfo:nil];
	
	NSLog(@"User loaded : %@", user.fullName);
	
	objectLoader.delegate = nil;
}

- (void)unlogUser
{
	InstagramUser* user = [InstagramUser currentUser];
	user.isCurrent = NO;
	user.accessToken = nil;
	[[RestKitHelper sharedInstance] save];
}

#pragma mark - UIAlertViewDelegate Protocol

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != alertView.cancelButtonIndex) {
		
	}
}

@end
