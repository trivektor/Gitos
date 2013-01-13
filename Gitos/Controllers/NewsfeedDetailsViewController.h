//
//  NewsfeedDetailsViewController.h
//  Gitos
//
//  Created by Tri Vuong on 1/12/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineEvent.h"

@interface NewsfeedDetailsViewController : UIViewController

@property(nonatomic, strong) TimelineEvent *event;

- (void)performHouseKeepingTasks;

@end
