//
//  OthersViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/7/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "OthersViewController.h"
#import "ProfileViewController.h"
#import "SSKeychain.h"
#import "LoginViewController.h"

@interface OthersViewController ()

@end

@implementation OthersViewController

@synthesize options, user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.options = [[NSMutableArray alloc] initWithCapacity:0];
        [self.options addObject:@"Profile"];
        [self.options addObject:@"Sign out"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"More";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg.png"] forBarMetrics:UIBarMetricsDefault];
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
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = [self.options objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellAccessoryNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:nil];
    [backButton setTintColor:[UIColor colorWithRed:202/255.0 green:0 blue:0 alpha:1]];
    [self.navigationItem setBackBarButtonItem:backButton];

    if (indexPath.row == 0) {
        ProfileViewController *profileController = [[ProfileViewController alloc] init];
        profileController.user = self.user;
        [self.navigationController pushViewController:profileController animated:YES];
    }

    if (indexPath.row == 1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Go ahead, make my day" otherButtonTitles:nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        return;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Sign out was clicked
    if (buttonIndex == 0) {
        [SSKeychain deletePasswordForService:@"access_token" account:@"gitos"];
        
        LoginViewController *loginController = [[LoginViewController alloc] init];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginController];
        
        [self.view.window setRootViewController:navController];
    }
}

@end
