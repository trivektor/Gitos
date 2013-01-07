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
#import "RepoCell.h"

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
        self.currentPage = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Gists";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINib *nib = [UINib nibWithNibName:@"RepoCell" bundle:nil];
    [gistsTable registerNib:nib forCellReuseIdentifier:@"RepoCell"];
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
    RepoCell *cell = [gistsTable dequeueReusableCellWithIdentifier:@"RepoCell"];
    
    if (!cell) {
        cell = [[RepoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RepoCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *gist = [self.gists objectAtIndex:indexPath.row];
    
    cell.repoNameLabel.text = [NSString stringWithFormat:@"gist:%@", [gist valueForKey:@"id"]];
    
    // Float the Forks and Watchers labels side by side
    // http://stackoverflow.com/questions/5891384/place-two-uilabels-side-by-side-left-and-right-without-knowing-string-length-of
    NSInteger _forks = [[gist valueForKey:@"forks_count"] integerValue];
    NSString *forks;
    
    NSInteger MAX_COUNT = 1000.0;
    
    if (_forks > MAX_COUNT) {
        forks = [NSString stringWithFormat:@"%.1fk", _forks/MAX_COUNT*1.0];
    } else {
        forks = [NSString stringWithFormat:@"%i", _forks];
    }
    
    NSInteger _watchers = [[gist valueForKey:@"watchers"] integerValue];
    NSString *watchers;
    
    if (_watchers > MAX_COUNT) {
        watchers = [NSString stringWithFormat:@"%.1fk", _watchers/MAX_COUNT*1.0];
    } else {
        watchers = [NSString stringWithFormat:@"%i", _watchers];
    }
    
    CGSize forksSize = [forks sizeWithFont:cell.forkLabel.font];
    CGSize watchersSize = [watchers sizeWithFont:cell.starLabel.font];
    
    cell.forkLabel.text = forks;
    cell.starLabel.text = watchers;
    
    cell.forkLabel.frame = CGRectMake(cell.forkLabel.frame.origin.x,
                                      cell.forkLabel.frame.origin.y,
                                      forksSize.width,
                                      forksSize.height);
    
    cell.starLabel.frame = CGRectMake(cell.starLabel.frame.origin.x,
                                      cell.starLabel.frame.origin.y,
                                      watchersSize.width,
                                      watchersSize.height);
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;

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
         [self.spinnerView removeFromSuperview];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error.localizedDescription);
         NSLog(@"%@", self.user.gistsUrl);
     }];
    
    [operation start];
}

@end
