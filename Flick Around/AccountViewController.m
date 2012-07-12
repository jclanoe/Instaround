//
//  AccountViewController.m
//  Flick Around
//
//  Created by Micha Mazaheri on 7/12/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "AccountViewController.h"

#import "InstagramUser.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize usernameCell;

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
	
	
}

@end
