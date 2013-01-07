//
//  GistCell.h
//  Gitos
//
//  Created by Tri Vuong on 1/6/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GistCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *gistName;
@property (nonatomic, strong) IBOutlet UILabel *gistDescription;
@property (nonatomic, strong) IBOutlet UILabel *gistCreatedAt;

@end
