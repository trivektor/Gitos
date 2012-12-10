//
//  HomeViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GithubAuthController.h"

@interface HomeViewController : UIViewController
{
    __weak IBOutlet UIButton *signinButton;
}

- (IBAction)showSigninForm:(id)sender;
- (void)authenticateUser;
- (void)showDashboard;

@end
