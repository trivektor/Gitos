//
//  StarredViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/30/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinnerView.h"
#import "User.h"

@interface StarredViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *starredReposTable;
}

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *starredRepos;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, strong) SpinnerView *spinnerView;

- (void)getUserInfo;
- (void)getStarredReposForPage:(NSInteger)page;

@end
