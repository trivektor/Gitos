//
//  LoginViewController.h
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController : UIViewController <UIWebViewDelegate>
{
    
    __weak IBOutlet UIWebView *webView;
}

@property(nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property(nonatomic, strong) NSMutableData *data;

@end
