//
//  AccountViewController.h
//  Flick Around
//
//  Created by Micha Mazaheri on 7/12/12.
//  Copyright (c) 2012 <3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InstagramLoginViewController;

@interface AccountViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *usernameCell;
@property (nonatomic, strong) InstagramLoginViewController* loginVC;

@end
