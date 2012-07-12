//
//  InstagramHelper.h
//  Flick Around
//
//  Created by JC on on 7/7/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

#define InstagramLoginErrorAlertViewTag @"InstagramLoginErrorAlertViewTag"
#define InstagramDidReceiveUserInfoNotification @"InstagramDidReceiveUserInfoNotification"

@interface InstagramHelper : NSObject

+ (InstagramHelper*)sharedInstance;
- (void)loadAccessToken:(NSString*)code;
- (BOOL)handleOpenURL:(NSURL*)url;
- (void)unlogUser;

@end
