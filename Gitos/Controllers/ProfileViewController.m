//
//  ProfileViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "ProfileViewController.h"
#import "SSKeychain.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "ProfileCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize avatar, profileTable, user, nameLabel, joinDateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.user = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"Profile";
    
    UINib *nib = [UINib nibWithNibName:@"ProfileCell" bundle:nil];
    [profileTable registerNib:nib forCellReuseIdentifier:@"ProfileCell"];
    profileTable.dataSource     = self;
    profileTable.delegate       = self;
    profileTable.backgroundView = nil;
    profileTable.scrollEnabled  = NO;
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
         [self displayUsernameAndAvatar];
         [profileTable reloadData];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCell *cell = [profileTable dequeueReusableCellWithIdentifier:@"ProfileCell"];
    
    if (!cell) {
        cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileCell"];
    }
    
    if (indexPath.row == 0) {

        cell.fieldIcon.image    = [UIImage imageNamed:@"location_icon.png"];
        cell.fieldDetails.text  = self.user.location;

    } else if (indexPath.row == 1) {

        cell.fieldIcon.image    = [UIImage imageNamed:@"link_icon.png"];
        cell.fieldDetails.text  = self.user.blog;

    } else if (indexPath.row == 2) {

        cell.fieldIcon.image    = [UIImage imageNamed:@"email_icon"];
        cell.fieldDetails.text  = self.user.email;

    } else if (indexPath.row == 3) {

        cell.fieldIcon.image    = [UIImage imageNamed:@"followers_icon.png"];
        cell.fieldDetails.text  = [NSString stringWithFormat:@"%i", self.user.followers];

    } else if (indexPath.row == 4) {

        cell.fieldIcon.image    = [UIImage imageNamed:@"company_icon.png"];
        cell.fieldDetails.text  = self.user.company;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)displayUsernameAndAvatar
{
    NSData *avatarData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.user.avatarUrl]];
    
    avatar.image = [UIImage imageWithData:avatarData];
    avatar.layer.cornerRadius = 5.0;
    avatar.layer.masksToBounds = YES;
    
    nameLabel.text = self.user.name;
    
    joinDateLabel.text = self.user.createdAt;
}

@end
