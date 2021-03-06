//
//  SecondViewController.m
//  Flick Around
//
//  Created by JC on on 6/23/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import "SecondViewController.h"

#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

#import "InstagramLoginViewController.h"
#import "MapViewController.h"

#import "InstagramHelper.h"
#import "SearchHelper.h"

#import "InstagramPhoto.h"
#import "InstagramUser.h"

#import "MapAnnotation.h"

#import "UIImageView+WebCache.h"

#import "Config.h"

#import "AQGridView.h"

#import "DetailMapViewController.h"

#define GridViewCellReuseID @"GridViewCellReuseID"

@interface SecondViewController () <AQGridViewDelegate, AQGridViewDataSource>

- (void)photosDidLoad:(NSNotification*)notification;

- (NSArray*)photos;

@end

@implementation SecondViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
	titleLabel.backgroundColor = [UIColor clearColor];
	[titleLabel setFont:[UIFont fontWithName:@"Lobster 1.3" size:30.0]];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.adjustsFontSizeToFitWidth = YES;
	titleLabel.text = @"Diaporama";
	titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
	titleLabel.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
	titleLabel.layer.shadowRadius = 1.0f;
	titleLabel.layer.shadowOpacity = 0.9f;
	titleLabel.layer.masksToBounds = NO;
	self.navigationItem.titleView = titleLabel;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosDidLoad:) name:SearchHelperDidLoadPhotoNotification object:nil];
	
	[(AQGridView*)self.view reloadData];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[(AQGridView*)self.view reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSArray *)photos
{
	return [SearchHelper sharedInstance].lastLoadedPhotos;
}

#pragma mark - AQGridView Delegate / Data Source

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)gridView
{
	return [self.photos count];
}

- (AQGridViewCell *)gridView:(AQGridView *)gridView cellForItemAtIndex:(NSUInteger)index
{
	AQGridViewCell* cell = [gridView dequeueReusableCellWithIdentifier:GridViewCellReuseID];
	
	InstagramPhoto* photo = [self.photos count] > index ? [self.photos objectAtIndex:index] : nil;
	
	if (cell == nil) {
		cell = [[AQGridViewCell alloc] initWithFrame:CGRectMake(0, 0, 80.f, 80.f) reuseIdentifier:GridViewCellReuseID];
		UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80.f, 80.f)];
		imageView.tag = 42;
		[cell.contentView addSubview:imageView];
	}
	
	UIImageView* imageView = (UIImageView*)[cell viewWithTag:42];
	
	[imageView setImageWithURL:[NSURL URLWithString:photo.urlPhotoThumbnail]];
	
	return cell;
}


- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return CGSizeMake(80.f, 80.f);
}

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
	InstagramPhoto* photo = [self.photos count] > index ? [self.photos objectAtIndex:index] : nil;
	if (photo) {
		DetailMapViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"edtailMapViewControllerID"];
		controller.imageURL = [NSURL URLWithString:photo.urlPhotoStandard];
		[self.navigationController pushViewController:controller animated:YES];
	}
}


#pragma mark - Notification Handler

- (void)photosDidLoad:(NSNotification*)notification
{
	if (notification.object)
	{
		[(AQGridView*)self.view reloadData];
	}
}

@end
