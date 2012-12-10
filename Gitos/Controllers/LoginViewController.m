//
//  LoginViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Login"];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(login)];
    [loginButton setTintColor:[UIColor colorWithRed:0 green:127/255.0 blue:245/255.0 alpha:1.0]];
    
    [self.navigationItem setRightBarButtonItem:loginButton];
    
    [emailField.layer setBorderColor:[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0].CGColor];
    [emailField.layer setCornerRadius:4.0f];
    [emailField.layer setMasksToBounds:YES];
    [emailField.layer setBorderWidth:1.0f];
    
    [passwordField.layer setBorderColor:[UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1.0].CGColor];
    [passwordField.layer setCornerRadius:4.0f];
    [passwordField.layer setMasksToBounds:YES];
    [passwordField.layer setBorderWidth:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login
{
    
}

@end
