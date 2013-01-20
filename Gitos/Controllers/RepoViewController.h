//
//  RepoViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/30/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repo.h"

@interface RepoViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *detailsTable;
    __weak IBOutlet UITableView *branchesTable;
}

@property(nonatomic, strong) Repo *repo;

- (void)performHouseKeepingTasks;
- (UITableViewCell *)cellForDetailsTableAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForBranchesTableAtIndexPath:(NSIndexPath *)indexPath;

@end
