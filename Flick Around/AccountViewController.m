//
//  AccountViewController.m
//  Flick Around
//
//  Created by Micha Mazaheri on 7/12/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

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
