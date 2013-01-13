//
//  NewsFeedCell.m
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "NewsFeedCell.h"

@implementation NewsFeedCell

@synthesize actionDescription, actionDate, event;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayEvent
{
    self.actionDescription.text = [self.event toString];
    self.actionDate.text        = [self.event toDateString];
    self.backgroundColor        = [UIColor clearColor];
    self.selectionStyle         = UITableViewCellSelectionStyleNone;
}

@end
