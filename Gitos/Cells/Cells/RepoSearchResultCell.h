//
//  RepoSearchResultCell.h
//  Gitos
//
//  Created by Tri Vuong on 1/16/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepoCell.h"
#import "Repo.h"

@interface RepoSearchResultCell : UITableViewCell

@property(nonatomic, strong) Repo *repo;
@property(nonatomic, strong) IBOutlet UILabel *repoNameLabel;
@property(nonatomic, strong) IBOutlet UILabel *repoDescriptionLabel;
@property(nonatomic, strong) IBOutlet UILabel *repoDetailsLabel;

@end
