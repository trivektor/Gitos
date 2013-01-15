//
//  ProfileCell.h
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *fieldIcon;
@property (nonatomic, weak) IBOutlet UILabel *fieldDetails;

- (void)displayByIndexPath:(NSIndexPath *)indexPath forUser:(User *)user;

@end
