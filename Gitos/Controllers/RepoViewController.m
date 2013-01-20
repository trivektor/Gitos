//
//  RepoViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/30/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "RepoViewController.h"
#import "RepoDetailsCell.h"

@interface RepoViewController ()

@end

@implementation RepoViewController

@synthesize repo;

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
    [self.navigationItem setTitle:[self.repo getName]];
    [self performHouseKeepingTasks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performHouseKeepingTasks
{
    UINib *repoDetailsCellNib = [UINib nibWithNibName:@"RepoDetailsCell" bundle:nil];
    [detailsTable registerNib:repoDetailsCellNib forCellReuseIdentifier:@"RepoDetailsCell"];

    [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0]];

    NSArray *tables = [[NSArray alloc] initWithObjects:detailsTable, branchesTable, nil];

    UITableView *table;

    for (int i=0; i < [tables count]; i++) {
        table = [tables objectAtIndex:i];
        [table setDelegate:self];
        [table setDataSource:self];
        [table setScrollEnabled:NO];
        [table setBackgroundView:nil];
        [table setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [table setSeparatorColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.8]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == detailsTable) {
        return 4;
    } else if (tableView == branchesTable) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == detailsTable) {
        return [self cellForDetailsTableAtIndexPath:indexPath];
    } else {
        return [self cellForBranchesTableAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)cellForDetailsTableAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RepoDetailsCell";
    RepoDetailsCell *cell = [detailsTable dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[RepoDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    [cell setRepo:self.repo];
    [cell renderForIndexPath:indexPath];

    return cell;
}

- (UITableViewCell *)cellForBranchesTableAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [detailsTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    return cell;
}

@end
