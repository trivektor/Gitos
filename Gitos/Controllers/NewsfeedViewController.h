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
#import "RelativeDateDescriptor.h"

@interface NewsfeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *newsFeedTable;
}

@property (nonatomic, strong) NSMutableArray *newsFeed;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) SpinnerView *spinnerView;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) RelativeDateDescriptor *relativeDateDescriptor;
@property (nonatomic) NSDate *todaysDate;

- (void)getUserInfoAndNewsFeed;
- (void)getUserNewsFeed:(NSInteger)page;
- (void)setupPullToRefresh;

@end
