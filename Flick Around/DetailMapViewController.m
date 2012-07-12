//
//  DetailMapViewController.m
//  Flick Around
//
//  Created by JC on on 7/12/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import "DetailMapViewController.h"

#import "UIImageView+WebCache.h"


@interface DetailMapViewController ()

@end

@implementation DetailMapViewController

@synthesize imageURL = _imageURL;
@synthesize imageView = _imageView;
@synthesize activityView = _activityView;

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
	[self.activityView startAnimating];
	[self.imageView setImageWithURL:self.imageURL success:^(UIImage* image) {
		[self.activityView setHidden:YES];
		[self.activityView stopAnimating];
	} failure:^(NSError* error) {
		[self.activityView setHidden:YES];
		[self.activityView stopAnimating];
	}];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
