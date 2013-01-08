//
//  GistsViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/16/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "GistsViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "SSKeychain.h"
#import "GistCell.h"
#import "RelativeDateDescriptor.h"

@interface GistsViewController ()

@end

@implementation GistsViewController

@synthesize currentPage, spinnerView, user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.gists = [[NSMutableArray alloc] initWithCapacity:0];
        self.currentPage = 1;
        self.relativeDateDescriptor = [[RelativeDateDescriptor alloc] initWithPriorDateDescriptionFormat:@"%@" postDateDescriptionFormat:@"in %@"];
        self.dateFormatter  = [[NSDateFormatter alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Gists";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINib *nib = [UINib nibWithNibName:@"GistCell" bundle:nil];
    [gistsTable registerNib:nib forCellReuseIdentifier:@"GistCell"];
    [gistsTable setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [gistsTable setBackgroundView:nil];
    [gistsTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [gistsTable setSeparatorColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.8]];
    [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0]];
    
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    
    [self getUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GistCell *cell = [gistsTable dequeueReusableCellWithIdentifier:@"GistCell"];
    
    if (!cell) {
        cell = [[GistCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"GistCell"];
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *gist = [self.gists objectAtIndex:indexPath.row];
    
    cell.gistName.text = [NSString stringWithFormat:@"gist:%@", [gist valueForKey:@"id"]];
    
    if ([gist valueForKey:@"description"] != [NSNull null]) {
        cell.gistDescription.text = [gist valueForKey:@"description"];
    } else {
        cell.gistDescription.text = @"n/a";
    }
    
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZ"];
    NSDate *date  = [self.dateFormatter dateFromString:[gist valueForKey:@"created_at"]];
    
    cell.gistCreatedAt.text = [self.relativeDateDescriptor describeDate:date relativeTo:[NSDate date]];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (([scrollView contentOffset].y + scrollView.frame.size.height) == scrollView.contentSize.height) {
        // Bottom of UITableView reached
        [self.spinnerView setHidden:NO];
        [self getUserGists:self.currentPage++];
    }
}

- (void)getUserInfo
{
    NSString *accessToken = [SSKeychain passwordForService:@"access_token" account:@"gitos"];
    
    NSURL *userUrl = [NSURL URLWithString:@"https://api.github.com/user"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:userUrl];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   accessToken, @"access_token",
                                   @"bearer", @"token_type",
                                   nil];
    
    NSMutableURLRequest *getRequest = [httpClient requestWithMethod:@"GET" path:userUrl.absoluteString parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:getRequest];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject){
         NSString *response = [operation responseString];
         
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
         
         self.user = [[User alloc] initWithOptions:json];
         [self getUserGists:self.currentPage++];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     }];
    
    [operation start];
}

- (void)getUserGists:(NSInteger)page
{
    NSURL *gistsUrl = [NSURL URLWithString:self.user.gistsUrl];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:gistsUrl];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%i", page], @"page",
                                   nil];
    
    NSMutableURLRequest *getRequest = [httpClient requestWithMethod:@"GET" path:gistsUrl.absoluteString parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:getRequest];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject){
         NSString *response = [operation responseString];
         
         [self.gists addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil]];
         [gistsTable reloadData];
         [self.spinnerView setHidden:YES];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [self.spinnerView setHidden:YES];
     }];
    
    [operation start];
}

@end
