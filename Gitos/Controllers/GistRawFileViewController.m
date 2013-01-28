//
//  GistRawFileViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/27/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "GistRawFileViewController.h"

@interface GistRawFileViewController ()

@end

@implementation GistRawFileViewController

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
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    [self.navigationItem setTitle:[self.gistFile getName]];
    NSURL *fileUrl = [NSURL URLWithString:[self.gistFile getRawUrl]];
    NSURLRequest *fileRequest = [NSURLRequest requestWithURL:fileUrl];
    [fileWebView loadRequest:fileRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinnerView setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
