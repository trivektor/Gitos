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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginButtonClicked:(id)sender
{
    NSLog(@"authenticating");
    NSURL *url = [NSURL URLWithString:@"https://api.github.com"];
    
    NSMutableArray *scopes = [[NSMutableArray alloc] initWithObjects:@"user", @"public_repo", @"repo", @"repo:status",
                              @"notifications", @"gist", nil];
    
    NSMutableDictionary *oauthParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        scopes, @"scopes",
                                        @"d60ccaa192ed899f048a", @"client_id",
                                        @"64b5131fb3bfc2ab86a71c84f92bf969e86feaef", @"client_secret",
                                        nil];

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient setAuthorizationHeaderWithUsername:[usernameField text] password:[passwordField text]];

    NSMutableURLRequest *postRequest = [httpClient requestWithMethod:@"POST" path:@"/authorizations" parameters:oauthParams];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];

    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *response = [operation responseString];

         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

         NSString *token = [json valueForKey:@"token"];
         [SSKeychain setPassword:token forService:@"access_token" account:@"gitos"];
         [AppInitialization run:self.view.window];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"OAuth request failed: %@", error);
     }];

    [operation start];
}

@end
