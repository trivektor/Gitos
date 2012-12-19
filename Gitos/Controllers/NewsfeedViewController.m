//
//  NewsfeedViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/16/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "NewsfeedViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "SSKeychain.h"
#import "User.h"

@interface NewsfeedViewController ()

@end

@implementation NewsfeedViewController

@synthesize newsFeed, user;

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
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self getUserInfoAndNewsFeed];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"Newsfeed";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getUserInfoAndNewsFeed
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
         [self getUserNewsFeed];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     }];

    [operation start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [newsFeedTable dequeueReusableCellWithIdentifier:@"Cell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    NSDictionary *item = [self.newsFeed objectAtIndex:indexPath.row];

    cell.textLabel.text = [item valueForKey:@"type"];

    return  cell;
}

- (void)getUserNewsFeed
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:self.user.receivedEventsUrl]];

    NSMutableURLRequest *getRequest = [httpClient requestWithMethod:@"GET" path:self.user.receivedEventsUrl parameters:nil];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:getRequest];

    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject){
         NSString *response = [operation responseString];

         self.newsFeed = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

         [newsFeedTable reloadData];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"an exception happened");
     }
     ];

    [operation start];

}

@end
