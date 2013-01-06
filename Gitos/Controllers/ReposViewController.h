//
//  ReposViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/16/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinnerView.h"
#import "User.h"

@interface ReposViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) User *user;
@property (nonatomic, weak) IBOutlet UITableView *reposTable;
@property (nonatomic, strong) NSMutableArray *repos;
@property (nonatomic, strong) SpinnerView *spinnerView;

- (void)getUserInfoAndRepos;
- (void)getUserRepos;

@end
