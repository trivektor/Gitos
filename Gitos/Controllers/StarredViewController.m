//
//  StarredViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/30/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "StarredViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "SSKeychain.h"
#import "RepoCell.h"

@interface StarredViewController ()

@end

@implementation StarredViewController

@synthesize user, starredRepos;

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
    [self.navigationItem setTitle:@"Starred Repositories"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UINib *nib = [UINib nibWithNibName:@"RepoCell" bundle:nil];
    [starredReposTable registerNib:nib forCellReuseIdentifier:@"RepoCell"];
    [starredReposTable setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [starredReposTable setBackgroundView:nil];
    [starredReposTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [starredReposTable setSeparatorColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.8]];
    [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0]];

    [self getUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
         [self getStarredRepos];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error 1");
     }];
    
    [operation start];
}

- (void)getStarredRepos
{
    NSURL *starredReposUrl = [NSURL URLWithString:self.user.starredUrl];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:starredReposUrl];
    
    NSMutableURLRequest *getRequest = [httpClient requestWithMethod:@"GET" path:starredReposUrl.absoluteString parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:getRequest];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject){
         NSString *response = [operation responseString];
         
         self.starredRepos = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"%i", self.starredRepos.count);
         [starredReposTable reloadData];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error.localizedDescription);
     }];
    
    [operation start];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.starredRepos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepoCell *cell = [starredReposTable dequeueReusableCellWithIdentifier:@"RepoCell"];
    
    if (!cell) {
        cell = [[RepoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RepoCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *repo = [self.starredRepos objectAtIndex:indexPath.row];
    
    cell.repoNameLabel.text = [repo valueForKey:@"name"];
    
    // Float the Forks and Watchers labels side by side
    // http://stackoverflow.com/questions/5891384/place-two-uilabels-side-by-side-left-and-right-without-knowing-string-length-of
    NSInteger _forks = [[repo valueForKey:@"forks_count"] integerValue];
    NSString *forks;
    
    NSInteger MAX_COUNT = 1000.0;
    
    if (_forks > MAX_COUNT) {
        forks = [NSString stringWithFormat:@"%.1dk", _forks/MAX_COUNT];
    } else {
        forks = [NSString stringWithFormat:@"%i", _forks];
    }
    
    NSInteger _watchers = [[repo valueForKey:@"watchers"] integerValue];
    NSString *watchers;
    
    if (_watchers > MAX_COUNT) {
        watchers = [NSString stringWithFormat:@"%.1dk", _watchers/MAX_COUNT];
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


@end
