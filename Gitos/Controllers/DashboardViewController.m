//
//  DashboardViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/16/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "DashboardViewController.h"
#import "NewsfeedViewController.h"
#import "ReposViewController.h"
#import "GistsViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NewsfeedViewController *newsfeedController = [[NewsfeedViewController alloc] init];
        ReposViewController *reposController = [[ReposViewController alloc] init];
        GistsViewController *gistsController = [[GistsViewController alloc] init];
        
        NSArray *viewControllers = [NSArray arrayWithObjects:newsfeedController,
                                    reposController,
                                    gistsController,
                                    nil];
        
        [self setViewControllers:viewControllers];
        self.navigationController.navigationBarHidden = YES;
        self.moreNavigationController.navigationBar.tintColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.moreNavigationController.navigationBar.tintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
