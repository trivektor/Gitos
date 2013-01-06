//
//  ProfileViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SpinnerView.h"
#import "User.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UITableView *profileTable;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *joinDateLabel;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) SpinnerView *spinnerView;

- (void)getUserInfo;
- (void)displayUsernameAndAvatar;

@end
