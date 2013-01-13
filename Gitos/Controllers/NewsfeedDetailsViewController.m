//
//  NewsfeedDetailsViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/12/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "NewsfeedDetailsViewController.h"
#import "AppConfig.h"

@interface NewsfeedDetailsViewController ()

@end

@implementation NewsfeedDetailsViewController

@synthesize event, currentPage, username;

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
    [self performHouseKeepingTasks];
    [self loadNewsfeedDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performHouseKeepingTasks
{
    [self.navigationItem setTitle:@"Details"];
    [webView setDelegate:self];
    
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStyleBordered target:self action:@selector(reloadNewsfeedDetails)];
    
    [reloadButton setTintColor:[UIColor colorWithRed:209/255.0 green:0 blue:0 alpha:1]];
    [self.navigationItem setRightBarButtonItem:reloadButton];
}

- (void)loadNewsfeedDetails
{
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    NSString *urlString = [AppConfig getConfigValue:@"GitosHost"];
    urlString = [urlString stringByAppendingFormat:@"/events/%d?page=%d&username=%@",
                 self.event.eventId,
                 self.currentPage,
                 self.username];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"%@", urlString);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

- (void)reloadNewsfeedDetails
{
    [self.spinnerView setHidden:NO];
    [webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinnerView setHidden:YES];
}

@end
