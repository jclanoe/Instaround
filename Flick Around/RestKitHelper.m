//
//  RestKitHelper.m
//  Flick Around
//
//  Created by Clem André on 7/2/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "RestKitHelper.h"

#import <RestKit/RestKit.h>
#import <RestKit/JSONKit.h>
#import <RestKit/NSData+Base64.h>

#import "InstagramPhoto.h"
#import "InstagramUser.h"

#import "Config.h"

@interface JSONParser : NSObject <RKParser>
@end

@interface RestKitHelper ()

@end

@implementation RestKitHelper

@synthesize objectStore = _objectStore;
@synthesize objectManager = _objectManager;
@synthesize apiClient = _apiClient;

@synthesize placeMapping = _placeMapping;
@synthesize photoMapping = _photoMapping;
@synthesize photoLocationMapping = _photoLocationMapping;
@synthesize infoMapping = _infoMapping;

@synthesize instagramUserMapping = _instagramUserMapping;
@synthesize searchMapping = _searchMapping;

- (id)init
{
	self = [super init];
	
	if (self) {
		
		RKLogConfigureByName("RestKit", RKLogLevelDebug);
		RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
		RKLogConfigureByName("RestKit/Network/Queue", RKLogLevelDebug);
		RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelDebug);
		RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
		
		// Note: any other date formatting isn't compatible with Python / Django
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss'Z'"];
		dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
		[RKObjectMapping setPreferredDateFormatter:dateFormatter];
		
		//
		// Object Store
		//
		self.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:SQLITE_FILE usingSeedDatabaseName:nil managedObjectModel:nil delegate:nil];
		
		//
		// Object Manager
		//
		self.objectManager = [RKObjectManager objectManagerWithBaseURLString:INSTAGRAM_SERVER_ROOT_URL];
		self.objectManager.objectStore = self.objectStore;
		self.objectManager.serializationMIMEType = RKMIMETypeJSON;
		self.objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
		[RKObjectManager setSharedManager:self.objectManager];
		
		//
		// JSON Parser
		//
		[[RKParserRegistry sharedRegistry] setParserClass:[JSONParser class] forMIMEType:RKMIMETypeJSON];
		
		//
		// Clients
		//
		self.apiClient = self.objectManager.client; // Set the API client as the object manager's default client
		self.apiClient.timeoutInterval = 15.f;
		self.apiClient.requestQueue.concurrentRequestsLimit = 5;
		
		//
		// Mappings
		//
		
		// Instagram User
		self.instagramUserMapping = [RKManagedObjectMapping mappingForClass:[InstagramUser class] inManagedObjectStore:self.objectStore];
		self.instagramUserMapping.primaryKeyAttribute = @"serverId";
		[self.instagramUserMapping mapKeyPath:@"user.id" toAttribute:@"serverId"];
		[self.instagramUserMapping mapKeyPath:@"access_token" toAttribute:@"accessToken"];
		[self.instagramUserMapping mapKeyPath:@"user.full_name" toAttribute:@"fullName"];
		[self.instagramUserMapping mapKeyPath:@"user.profile_picture" toAttribute:@"profilePicture"];
		[self.instagramUserMapping mapKeyPath:@"user.username" toAttribute:@"username"];
		
		self.searchMapping = [RKManagedObjectMapping mappingForClass:[InstagramPhoto class] inManagedObjectStore:self.objectStore];
		self.searchMapping.primaryKeyAttribute = @"serverId";
		[self.searchMapping mapKeyPath:@"id" toAttribute:@"photoId"];
		[self.searchMapping mapKeyPath:@"latitude" toAttribute:@"latitude"];
		[self.searchMapping mapKeyPath:@"longitude" toAttribute:@"longitude"];
		[self.searchMapping mapKeyPath:@"name" toAttribute:@"name"];
		self.searchMapping.rootKeyPath = @"data";
		[self.objectManager.mappingProvider setMapping:self.searchMapping forKeyPath:@"data"];
	}
	
	return self;
}

+ (RestKitHelper*)sharedInstance
{
	static RestKitHelper* sharedInstance = nil;
	@synchronized([self class]) {
		if (sharedInstance == nil) {
			sharedInstance = [[RestKitHelper alloc] init];
		}
	}
	return sharedInstance;
}

- (BOOL)save
{
    NSError* error = nil;
    if (![[RKObjectManager sharedManager].objectStore save:&error]) {
        NSLog(@"Core Data Save error!");
        NSLog(@"updatedObjects: %@", [[RKObjectManager sharedManager].objectStore.primaryManagedObjectContext updatedObjects]);
        NSLog(@"deletedObjects: %@", [[RKObjectManager sharedManager].objectStore.primaryManagedObjectContext deletedObjects]);
        NSLog(@"insertedObjects: %@", [[RKObjectManager sharedManager].objectStore.primaryManagedObjectContext insertedObjects]);
		
		return NO;
    }
    return YES;
}

- (NSManagedObjectContext *)primaryManagedObjectContext
{
	return [RestKitHelper sharedInstance].objectStore.primaryManagedObjectContext;
}

@end

// This parser is used instead of the default RestKit JSON parser to be able to serialize NSData as base 64 strings
@implementation JSONParser

typedef id(^serializationBlockType)(id object);

serializationBlockType serializationBlock = ^ id (id object) {
	if ([object respondsToSelector:@selector(base64EncodedString)]) {
		return [object base64EncodedString];
	}
	return nil;
};

- (NSDictionary*)objectFromString:(NSString*)string error:(NSError**)error {
    RKLogTrace(@"string='%@'", string);
    return [string objectFromJSONStringWithParseOptions:JKParseOptionStrict error:error];
}

- (NSString*)stringFromObject:(id)object error:(NSError**)error {
    return [object JSONStringWithOptions:JKSerializeOptionNone serializeUnsupportedClassesUsingBlock:serializationBlock error:error];
}

@end
