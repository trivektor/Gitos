//
//  RepoCell.m
//  Gitos
//
//  Created by Tri Vuong on 12/22/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "RepoCell.h"

@implementation RepoCell

@synthesize repoNameLabel, forkLabel, starLabel;

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

@end
