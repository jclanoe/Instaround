//
//  InstagramLoginViewController.m
//  Flick Around
//
//  Created by JC on on 7/7/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import "Config.h"

#import "InstagramLoginViewController.h"

#import "InstagramHelper.h"

@interface InstagramLoginViewController ()

@end

@implementation InstagramLoginViewController

@synthesize loginButton = _loginButton;
@synthesize instagramLogo = _instagramLogo;
@synthesize activityIndicator = _activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[self.activityIndicator setHidden:YES];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthCode:) name:InstagramDidReceiveCodeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAuthError:) name:InstagramDidReceiveErrorNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBActions

- (IBAction)loginWithInstagram:(id)sender
{
	[self.loginButton setHidden:YES];
	[self.instagramLogo setHidden:YES];
	[self.activityIndicator startAnimating];
	[self.activityIndicator setHidden:NO];
    NSURL* instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?client_id=%@&redirect_uri=%@&response_type=code", INSTAGRAM_SERVER_ROOT_URL, INSTAGRAM_AUTH, INSTAGRAM_CLIENT_ID, INSTAGRAM_REDIRECT_URI]];
    [[UIApplication sharedApplication] openURL:instagramURL];
}

#pragma mark - Notification Handlers

- (void)didReceiveAuthCode:(NSNotification*)notification
{
	if (notification.object) {
		NSLog(@"CODE : %@", notification.object);
		[[InstagramHelper sharedInstance] loadAccessToken:notification.object];
	}
}

- (void)didReceiveAuthError:(NSNotification*)notification
{
	[self.activityIndicator setHidden:YES];
	[self.activityIndicator stopAnimating];
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Erreur d'autorisation" message:@"Vous devez autoriser Instaround à utiliser votre compte Instagram" delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Réessayer", nil];
	[alertView show];
}

#pragma mark - AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {
		[self.activityIndicator startAnimating];
		[self.activityIndicator setHidden:NO];
		[self loginWithInstagram:nil];
	}
	else {
		[self.instagramLogo setHidden:NO];
		[self.loginButton setHidden:NO];
	}
}

@end
