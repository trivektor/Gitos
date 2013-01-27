//
//  GistsViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/16/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinnerView.h"
#import "User.h"
#import "RelativeDateDescriptor.h"

@interface GistsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *gistsTable;
}

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) SpinnerView *spinnerView;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *gists;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) RelativeDateDescriptor *relativeDateDescriptor;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (void)getUserInfo;
- (void)getUserGists:(NSInteger)page;
- (void)setupPullToRefresh;

@end
