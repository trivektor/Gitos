//
//  LoginViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "LoginViewController.h"
#import "URLParser.h"
#import "SSKeychain.h"
#import "NSDictionary+UrlEncoding.h"
#import "AppInitialization.h"
#import "AFOAuth2Client.h"
#import "AFJSONRequestOperation.h"
#import "AppConfig.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameCell, passwordCell, spinnerView;

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
    [self performHousekeepingTasks];
    [self setDelegates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performHousekeepingTasks
{
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    [self.spinnerView setHidden:YES];

    [self.navigationItem setTitle:@"Login"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleBordered target:self action:@selector(authenticate)];
    [submitButton setTintColor:[UIColor colorWithRed:202/255.0 green:0 blue:0 alpha:1]];
    [self.navigationItem setRightBarButtonItem:submitButton];
    
    [loginTable setBackgroundView:nil];
    [loginTable setScrollEnabled:NO];
    [loginTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [loginTable setSeparatorColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.8]];
    [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0]];
}

- (void)setDelegates
{
    [usernameField setDelegate:self];
    [passwordField setDelegate:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return usernameCell;
    if (indexPath.row == 1) return passwordCell;
    return nil;
}

- (void)authenticate
{
    NSString *username = [usernameField text];
    NSString *password = [passwordField text];

    // Prompt if username of password was blank
    if (username.length == 0 || password.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setMessage:@"Please enter both username and password"];
        [alert show];
        return;
    }

    NSURL *url = [NSURL URLWithString:[AppConfig getConfigValue:@"GithubApiHost"]];
    
    NSMutableArray *scopes = [[NSMutableArray alloc] initWithObjects:@"user", @"public_repo", @"repo", @"repo:status",
                              @"notifications", @"gist", nil];
    
    NSMutableDictionary *oauthParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        scopes, @"scopes",
                                        @"d60ccaa192ed899f048a", @"client_id",
                                        @"64b5131fb3bfc2ab86a71c84f92bf969e86feaef", @"client_secret",
                                        nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient setAuthorizationHeaderWithUsername:username password:password];
    
    NSMutableURLRequest *postRequest = [httpClient requestWithMethod:@"POST" path:@"/authorizations" parameters:oauthParams];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         [self.spinnerView setHidden:NO];
         NSString *response = [operation responseString];
         
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
         
         NSString *token = [json valueForKey:@"token"];
         [SSKeychain setPassword:token forService:@"access_token" account:@"gitos"];
         [AppInitialization run:self.view.window];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self.spinnerView setHidden:YES];
         NSString *response = [operation responseString];

         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

         [alert setMessage:[json valueForKey:@"message"]];
         [alert show];
     }];
    
    [operation start];
    [self.spinnerView setHidden:NO];
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
