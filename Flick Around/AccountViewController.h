//
//  AccountViewController.h
//  Flick Around
//
//  Created by JC Lanoë on 7/12/12.
//  Copyright (c) 2012 MTI 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstagramLoginViewController;

@interface AccountViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *usernameCell;
@property (nonatomic, strong) InstagramLoginViewController* loginVC;

@end
