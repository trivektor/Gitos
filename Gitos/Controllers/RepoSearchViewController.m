//
//  RepoSearchViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/15/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "RepoSearchViewController.h"
#import "SSKeychain.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "AppConfig.h"
#import "Repo.h"
#import "RepoSearchResultCell.h"

@interface RepoSearchViewController ()

@end

@implementation RepoSearchViewController

@synthesize user, searchResults, spinnerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.searchResults = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self performHouseKeepingTasks];
    [self prepareTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performHouseKeepingTasks
{
    [self.navigationItem setTitle:@"Search"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
    [self.spinnerView setHidden:YES];
    [searchResultsTable setContentInset:UIEdgeInsetsMake(0, 0, 48, 0)];
    [searchResultsTable setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, 48, 0)];
    CGRect frame = [searchResultsTable frame];
    frame.size.height = frame.size.height - self.tabBarController.tabBar.frame.size.height - searchBar.frame.size.height - self.navigationController.navigationBar.frame.size.height + 4;
    [searchResultsTable setFrame:frame];
}

- (void)prepareTableView
{
    UINib *nib = [UINib nibWithNibName:@"RepoSearchResultCell" bundle:nil];

    [searchResultsTable registerNib:nib forCellReuseIdentifier:@"RepoSearchResultCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepoSearchResultCell *cell = [searchResultsTable dequeueReusableCellWithIdentifier:@"RepoSearchResultCell"];
    
    if (!cell) {
        cell = [[RepoSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RepoSearchResultCell"];
    }

    cell.repoDetails = [self.searchResults objectAtIndex:indexPath.row];
    [cell render];
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    [self.spinnerView setHidden:NO];
    [searchBar resignFirstResponder];
    NSString *term = [_searchBar text];
    NSString *accessToken = [SSKeychain passwordForService:@"access_token" account:@"gitos"];
    
    NSURL *searchUrl = [NSURL URLWithString:[AppConfig getConfigValue:@"GithubApiHost"]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:searchUrl];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   accessToken, @"access_token",
                                   @"bearer", @"token_type",
                                   nil];
    
    NSMutableURLRequest *getRequest = [httpClient requestWithMethod:@"GET"
                                                               path:[NSString stringWithFormat:@"legacy/repos/search/%@", term]
                                                         parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:getRequest];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject){
         NSString *response = [operation responseString];
         
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
         
         self.searchResults = [json valueForKey:@"repositories"];
         
         [searchResultsTable reloadData];
         [searchBar resignFirstResponder];
         [self.spinnerView setHidden:YES];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error);
         [self.spinnerView setHidden:YES];
     }];
    
    [operation start];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)_searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)_searchBar
{
    searchBar.showsCancelButton = NO;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    [searchBar resignFirstResponder];
}

@end
