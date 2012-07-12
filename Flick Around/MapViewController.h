//
//  FirstViewController.h
//  Flick Around
//
//  Created by JC on on 6/23/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MapAnnotationIdentifier @"MapAnnotationIdentifier"

@class InstagramLoginViewController;
@class CLLocation;
@class MKMapView;

@interface MapViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) InstagramLoginViewController* loginVC;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *reloadButton;
@property (nonatomic) BOOL hasLoadedOnce;

- (IBAction)refreshLocation:(id)sender;

@end
