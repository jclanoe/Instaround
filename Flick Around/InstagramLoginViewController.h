//
//  InstagramLoginViewController.h
//  Flick Around
//
//  Created by JC on on 7/7/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import <UIKit/UIKit.h>


#define InstagramDidReceiveCodeNotification @"InstagramDidReceiveCodeNotification"
#define InstagramDidReceiveErrorNotification @"InstagramDidReceiveErrorNotification"

@interface InstagramLoginViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton* loginButton;
@property (nonatomic, retain) IBOutlet UIImageView* instagramLogo;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;

- (IBAction)loginWithInstagram:(id)sender;

@end
