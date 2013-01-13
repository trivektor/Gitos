//
//  NewsFeedCell.h
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineEvent.h"

@interface NewsFeedCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *actionDescription;
@property (nonatomic, weak) IBOutlet UILabel *actionDate;
@property (nonatomic, strong) TimelineEvent *event;

- (void)displayEvent;

@end
