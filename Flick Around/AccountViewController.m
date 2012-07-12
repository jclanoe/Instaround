//
//  AccountViewController.m
//  Flick Around
//
//  Created by JC Lanoë on 7/12/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "AccountViewController.h"

#import "InstagramUser.h"

#import "InstagramLoginViewController.h"

#import "InstagramHelper.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize usernameCell;
@synthesize loginVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	titleLabel.backgroundColor = [UIColor clearColor];
	[titleLabel setFont:[UIFont fontWithName:@"Lobster 1.3" size:30.0]];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.adjustsFontSizeToFitWidth = YES;
	titleLabel.text = @"Mon Compte";
	titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
	titleLabel.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
	titleLabel.layer.shadowRadius = 1.0f;
	titleLabel.layer.shadowOpacity = 0.9f;
	titleLabel.layer.masksToBounds = NO;
	self.navigationItem.titleView = titleLabel;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.usernameCell.detailTextLabel.text = [InstagramUser currentUser].username;
}

- (void)viewDidUnload
{
	[self setUsernameCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0 && indexPath.section == 1) {
		self.loginVC = (InstagramLoginViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"instagramLogin"];
		[self presentModalViewController:self.loginVC animated:YES];
		
		[[InstagramHelper sharedInstance] unlogUser];
	}
}

@end
