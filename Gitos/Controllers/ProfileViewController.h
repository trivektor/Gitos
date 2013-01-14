//
//  ProfileViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import "SpinnerView.h"
#import "User.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UITableView *profileTable;
    __weak IBOutlet UILabel *loginLabel;
}

//@property (nonatomic, weak) IBOutlet UIImageView *avatar;
//@property (nonatomic, weak) IBOutlet UITableView *profileTable;
//@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
//@property (nonatomic, weak) IBOutlet UILabel *loginLabel;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) SpinnerView *spinnerView;

- (void)performHouseKeepingTasks;
- (void)prepareProfileTable;
- (void)getUserInfo;
- (void)displayUsernameAndAvatar;

@end
