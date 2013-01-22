//
//  RepoViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/30/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repo.h"
#import "SpinnerView.h"

@interface RepoViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *detailsTable;
    __weak IBOutlet UITableView *branchesTable;
    __weak IBOutlet UIScrollView *repoScrollView;
}

@property(nonatomic, strong) NSString *accessToken;
@property(nonatomic, strong) Repo *repo;
@property(nonatomic, strong) NSMutableArray *repoBranches;
@property(nonatomic, strong) SpinnerView *spinnerView;

- (void)performHouseKeepingTasks;
- (UITableViewCell *)cellForDetailsTableAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForBranchesTableAtIndexPath:(NSIndexPath *)indexPath;
- (void)getRepoBranches;
- (void)adjustFrameHeight;

@end
