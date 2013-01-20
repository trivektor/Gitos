//
//  RepoTreeViewController.h
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Branch.h"
#import "Repo.h"

@interface RepoTreeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *treeTable;
}

@property (nonatomic, strong) NSMutableArray *treeData;
@property (nonatomic, strong) NSString *branchUrl;
@property (nonatomic, strong) Branch *branch;
@property (nonatomic, strong) Repo *repo;

- (void)performHouseKeepingTasks;
- (void)fetchData;

@end
