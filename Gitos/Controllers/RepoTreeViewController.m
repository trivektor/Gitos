//
//  RepoTreeViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "RepoTreeViewController.h"
#import "RepoTreeCell.h"
#import "AppConfig.h"
#import "SSKeychain.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "RepoTreeNode.h"

@interface RepoTreeViewController ()

@end

@implementation RepoTreeViewController

@synthesize branchUrl, branch, repo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.treeData = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self performHouseKeepingTasks];
    [self fetchData];
}

- (void)performHouseKeepingTasks
{
    self.navigationItem.title = [self.branch name];
}

- (void)fetchData
{
    NSString *treeUrl = [[self.repo getTreeUrl] stringByAppendingString:self.branch.name];

    NSString *accessToken = [SSKeychain passwordForService:@"access_token" account:@"gitos"];

    NSURL *repoTreeUrl = [NSURL URLWithString:treeUrl];

    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:repoTreeUrl];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   accessToken, @"access_token",
                                   @"bearer", @"token_type",
                                   @"1", @"recursive",
                                   nil];

    NSMutableURLRequest *getRequest = [httpClient requestWithMethod:@"GET" path:repoTreeUrl.absoluteString parameters:params];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:getRequest];

    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject){
         NSString *response = [operation responseString];

         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

         NSArray *treeNodes = [json valueForKey:@"tree"];

         RepoTreeNode *node;

         for (int i=0; i < json.count; i++) {
             node = [[RepoTreeNode alloc] initWithData:[treeNodes objectAtIndex:i]];
             [self.treeData addObject:node];
         }
         [treeTable reloadData];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error);
     }];

    [operation start];

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
    return [self.treeData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [treeTable dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    RepoTreeNode *node = [self.treeData objectAtIndex:indexPath.row];

    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
    cell.textLabel.text = [node path];

    return cell;
}

@end
