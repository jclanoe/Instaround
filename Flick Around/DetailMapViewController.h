//
//  DetailMapViewController.h
//  Flick Around
//
//  Created by JC on on 7/12/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMapViewController : UIViewController

@property (nonatomic, retain) NSURL* imageURL;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityView;

@end
