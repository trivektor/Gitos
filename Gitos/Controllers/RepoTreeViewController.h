//
//  RepoTreeViewController.h
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Branch.h"

@interface RepoTreeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *branchUrl;
@property (nonatomic, strong) Branch *branch;

- (void)performHouseKeepingTasks;

@end
