//
//  HomeViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "HomeViewController.h"
#import "GithubAuthenticatorView.h"
#import "DashboardViewController.h"
#import "KeychainHelper.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    self.navigationController.navigationBarHidden = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSigninForm:(id)sender
{
    LoginViewController *loginController = [[LoginViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
    
    [self.view.window setRootViewController:navController];
}

//- (void)didAuth:(NSString *)token
//{
//    if(!token)
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Failed to request token."] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//        return;
//    } else {
//        [KeychainHelper setAuthenticationToken:token];
//    }
//}
//
//- (void)authenticateUser
//{
//    GithubAuthController *githubAuthController = [[GithubAuthController alloc] init];
//    githubAuthController.authDelegate = self;
//    
//    githubAuthController.modalPresentationStyle = UIModalPresentationFormSheet;
//    githubAuthController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    
//    [self presentViewController:githubAuthController animated:YES completion:^{ } ];
//    
//    __weak __block GithubAuthController *weakAuthController = githubAuthController;
//    
//    githubAuthController.completionBlock = ^(void) {
//        [weakAuthController dismissViewControllerAnimated:YES completion:nil];
//        [self performSelector:@selector(showDashboard) withObject:nil afterDelay:2];
//    };
//}
//
//- (void)showDashboard
//{
//    DashboardViewController *dashboardController = [[DashboardViewController alloc] init];
//    
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dashboardController];
//    
//    [self.view.window setRootViewController:navController];
//}

@end
