//
//  RepoCell.h
//  Gitos
//
//  Created by Tri Vuong on 12/22/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *repoNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *forkLabel;
@property (nonatomic, weak) IBOutlet UILabel *starLabel;

@end
