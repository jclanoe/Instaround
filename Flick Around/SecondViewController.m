//
//  SecondViewController.m
//  Flick Around
//
//  Created by Clem André on 6/23/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import "SecondViewController.h"

#import <MapKit/MapKit.h>

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

@property (strong, nonatomic) NSMutableArray* photos;

@end

@implementation SecondViewController

@synthesize photos = _photos;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosDidLoad:) name:SearchHelperDidLoadPhotoNotification object:nil];
	
	self.photos = [[SearchHelper sharedInstance].lastLoadedPhotos mutableCopy];
	[(AQGridView*)self.view reloadData];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - AQGridView Delegate / Data Source

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)gridView
{
	return [self.photos count];
}

- (AQGridViewCell *)gridView:(AQGridView *)gridView cellForItemAtIndex:(NSUInteger)index
{
	AQGridViewCell* cell = [gridView dequeueReusableCellWithIdentifier:GridViewCellReuseID];
	
	InstagramPhoto* photo = [self.photos objectAtIndex:index];
	
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
	InstagramPhoto* photo = [self.photos objectAtIndex:index];
	DetailMapViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"edtailMapViewControllerID"];
	controller.imageURL = [NSURL URLWithString:photo.urlPhotoStandard];
	[self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Notification Handler

- (void)photosDidLoad:(NSNotification*)notification
{
	if (notification.object)
	{
		[self.photos removeAllObjects];
		for (InstagramPhoto* photo in notification.object) {
			[self.photos addObject:photo];
		}
		
		[(AQGridView*)self.view reloadData];
	}
}

@end
