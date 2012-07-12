//
//  FirstViewController.m
//  Flick Around
//
//  Created by Clem André on 6/23/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "InstagramLoginViewController.h"
#import "DetailMapViewController.h"
#import "MapViewController.h"

#import "InstagramHelper.h"
#import "SearchHelper.h"

#import "InstagramPhoto.h"
#import "InstagramUser.h"

#import "MapAnnotation.h"

#import "UIImageView+WebCache.h"

#import "Config.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize loginVC = _loginVC;
@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;
@synthesize currentLocation = _currentLocation;
@synthesize reloadButton = _reloadButton;
@synthesize hasLoadedOnce = _hasLoadedOnce;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeDidLoad:) name:PlaceHelperDidLoadPlaceNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeDidFailLoading:) name:PlaceHelperDidFailLoadingPlaceNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosDidLoad:) name:PhotoHelperDidLoadPhotosNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoLocationDidLoad:) name:PhotoLocationHelperDidLoadLocationNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoLocationDidFailLoading:) name:PhotoLocationHelperDidFailLoadingLocationNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosDidFailLoading:) name:SearchHelperDidFailLoadingPhotoNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveUserInfo:) name:InstagramDidReceiveUserInfoNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosDidLoad:) name:SearchHelperDidLoadPhotoNotification object:nil];
	
	if ([InstagramUser currentUser] == nil) {
		self.loginVC = (InstagramLoginViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"instagramLogin"];
		[self presentModalViewController:self.loginVC animated:NO];
	}
    else {
        NSLog(@"CURRENT USER IS : %@", [InstagramUser currentUser].fullName);
		self.locationManager.distanceFilter = 100.f;
		[self.locationManager startUpdatingLocation];
		[self.mapView showsUserLocation];
    }
	
	self.currentLocation = nil;
}

//- (void)didPinch
//{
//	if (self.currentLocation)
//		[self.mapView setCenterCoordinate:self.currentLocation.coordinate animated:NO];
//}
//
//- (void)didPan
//{
//	NSLog(@"DID PAN");
////	if (self.currentLocation)
//	[self.mapView setCenterCoordinate:self.currentLocation.coordinate animated:NO];
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
	self.locationManager = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
	if (self.hasLoadedOnce == NO)
	{
//		[[self locationManager] startUpdatingLocation];
		self.hasLoadedOnce = YES;
	}
}

- (void)viewDidDisappear:(BOOL)animated
{
//	[[self locationManager] stopUpdatingLocation];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Core Location

- (CLLocationManager *)locationManager
{
	if (_locationManager != nil)
	{
		return _locationManager;
	}
	_locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	MKCoordinateRegion region = self.mapView.region;
	
	if (self.currentLocation == nil)
	{
		region.span.latitudeDelta = 5 / LATITUDE_DEGREE_DELTA_VALUE;
		region.span.longitudeDelta = 5 / LATITUDE_DEGREE_DELTA_VALUE;
		[self.mapView setRegion:region animated:YES];
	}
	
	self.currentLocation = newLocation;
	
	[self.mapView setCenterCoordinate:self.currentLocation.coordinate animated:YES];
	
	[self refreshLocation:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	
}

#pragma mark - MapView Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	NSLog(@"Did update location");
	[self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
	
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//	MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:MapAnnotationIdentifier];
//	if (annotationView == nil)
//	{
//		annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MapAnnotationIdentifier];
//	}
//	
//	return annotationView;
//}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	MKPinAnnotationView *pinView = nil;
	MapAnnotation* mapAnnotation = (MapAnnotation*)annotation;
	if (annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.instaround.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		
		if (pinView == nil)
			pinView = [[MKPinAnnotationView alloc] initWithAnnotation:mapAnnotation reuseIdentifier:defaultPinID];
		
        pinView.pinColor = MKPinAnnotationColorRed; 
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
		UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[imageView setImageWithURL:mapAnnotation.thumbnailURL];
		pinView.leftCalloutAccessoryView = imageView;
		pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		
    } 
    else
	{
        [mapView.userLocation setTitle:@"I am here"];
    }
	
    return pinView;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
//	NSLog(@"Region DID Change : %f, %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
	
//	if (mapView.region.span.latitudeDelta * LATITUDE_DEGREE_DELTA_VALUE > MAX_DISTANCE_DELTA_ALLOWED) {
//		NSLog(@"New Value : %f", LATITUDE_DEGREE_DELTA_VALUE / MAX_DISTANCE_DELTA_ALLOWED);
//		MKCoordinateSpan span = MKCoordinateSpanMake(MAX_DISTANCE_DELTA_ALLOWED / LATITUDE_DEGREE_DELTA_VALUE, MAX_DISTANCE_DELTA_ALLOWED / LATITUDE_DEGREE_DELTA_VALUE);
//		MKCoordinateRegion region = MKCoordinateRegionMake(self.currentLocation.coordinate, span);
//		NSLog(@"Map View : %@", self.mapView);
//		[self.mapView setRegion:region animated:YES];
//	}
//	
//	[self.mapView setCenterCoordinate:self.currentLocation.coordinate animated:YES];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	MapAnnotation* annotation = (MapAnnotation*)view.annotation;
	
	DetailMapViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"edtailMapViewControllerID"];
	controller.imageURL = annotation.standardURL;
	[self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UIGestureRecognizer Delegates Methods

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
	return YES;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

{
	return YES;
}

#pragma mark - IBActions

- (IBAction)refreshLocation:(id)sender
{
	self.reloadButton.enabled = NO;
	
	[self.mapView removeAnnotations:self.mapView.annotations];
	[self.mapView setShowsUserLocation:YES];
	
//	[[self locationManager] startUpdatingLocation];
	
//	PlaceHelper* helper = [PlaceHelper sharedInstance];
//	[helper loadPlaceForCoordinate:self.currentLocation.coordinate];
	
	SearchHelper* helper = [SearchHelper sharedInstance];
	[helper loadSearchedPhotos:self.currentLocation.coordinate];
}

#pragma mark - Notification Handler

- (void)photosDidLoad:(NSNotification*)notification
{
	if (notification.object)
	{
		for (InstagramPhoto* photo in notification.object) {
			CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([photo.latitude doubleValue], [photo.longitude doubleValue]);
			MapAnnotation* annotation = [[MapAnnotation alloc] initWithCoordinate:coordinate];
			annotation.thumbnailURL = [NSURL URLWithString:photo.urlPhotoThumbnail];
			annotation.standardURL = [NSURL URLWithString:photo.urlPhotoStandard];
			[annotation setTitle:@"Photo"];
			[annotation setSubtitle:[NSString stringWithFormat:@"par %@", photo.subtitle]];
			[self.mapView addAnnotation:annotation];
		}
	}
	self.reloadButton.enabled = YES;
}

- (void)photosDidFailLoading:(NSNotification*)notification
{
	self.reloadButton.enabled = YES;
}

- (void)photoLocationDidFailLoading:(NSNotification*)notification
{
	NSLog(@"Photo DID FAIL Loading");
}

#pragma mark - Notification Handlers

- (void)didReceiveUserInfo:(NSNotification*)notification
{
	[self dismissModalViewControllerAnimated:YES];
	
	[self.mapView setShowsUserLocation:YES];
	[[self locationManager] startUpdatingLocation];
}

@end
