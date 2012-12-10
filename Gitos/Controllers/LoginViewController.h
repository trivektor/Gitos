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
    __weak IBOutlet UITextField *emailField;
    __weak IBOutlet UITextField *passwordField;
}

- (void)login;

@end
