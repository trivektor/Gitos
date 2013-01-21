//
//  RawFileViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "RawFileViewController.h"
#import "AppConfig.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@interface RawFileViewController ()

@end

@implementation RawFileViewController

@synthesize repo, branch, fileName;

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
    [self.navigationItem setTitle:self.fileName];
    [self fetchRawFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchRawFile
{
    NSString *githubRawHost = [AppConfig getConfigValue:@"GithubRawHost"];
    NSString *repoFullName = [self.repo getFullName];
    NSString *branchName = self.branch.name;

    NSURL *rawFileUrl = [NSURL URLWithString:[githubRawHost stringByAppendingFormat:@"/%@/%@/%@", repoFullName, branchName, self.fileName]];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:rawFileUrl];

    [fileWebView loadRequest:request];
}

@end
