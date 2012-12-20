//
//  NewsfeedViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/16/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SpinnerView.h"

@interface NewsfeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *newsFeedTable;
}

@property (nonatomic, strong) NSMutableArray *newsFeed;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) SpinnerView *spinnerView;

- (void)getUserInfoAndNewsFeed;
- (void)getUserNewsFeed;

@end
