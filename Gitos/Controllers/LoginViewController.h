//
//  LoginViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController : UIViewController
{
    
    __weak IBOutlet UITextField *usernameField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UIButton *loginButton;
}

- (IBAction)loginButtonClicked:(id)sender;

@end
