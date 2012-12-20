//
//  SpinnerView.h
//  ExpenseTrackr
//
//  Created by Tri Vuong on 10/13/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView

+ (SpinnerView *)loadSpinnerIntoView:(UIView *)superView;
- (UIImage *)addBackground;
- (void)removeSpinner;

@end
