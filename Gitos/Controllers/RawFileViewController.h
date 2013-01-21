//
//  RawFileViewController.h
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repo.h"
#import "Branch.h"
#import "SpinnerView.h"

@interface RawFileViewController : UIViewController <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *fileWebView;
}

@property (nonatomic, strong) Repo *repo;
@property (nonatomic, strong) Branch *branch;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) SpinnerView *spinnerView;

- (void)fetchRawFile;

@end
