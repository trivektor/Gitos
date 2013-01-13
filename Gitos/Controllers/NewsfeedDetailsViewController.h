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
{
    __weak IBOutlet UIWebView *webView;
}

@property(nonatomic, strong) TimelineEvent *event;
@property(nonatomic) int currentPage;
@property(nonatomic, strong) NSString *username;

- (void)performHouseKeepingTasks;

@end
