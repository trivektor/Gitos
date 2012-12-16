//
//  LoginViewController.m
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "LoginViewController.h"
#import "URLParser.h"
#import "SSKeychain.h"
#import "NSDictionary+UrlEncoding.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize data, tokenRequestConnection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.data = [NSMutableData data];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"Login"];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1.0]];
    
    [webView setDelegate:self];
    
    NSString *clientId = @"d60ccaa192ed899f048a";
    NSString *oauthURLString = [@"https://github.com/login/oauth/authorize?client_id=" stringByAppendingString:clientId];
    oauthURLString = [oauthURLString stringByAppendingString:@"&scope=user,public_repo,repo,repo:status,notifications,gist"];
    NSURL *oauthURL = [NSURL URLWithString:oauthURLString];
    
    NSURLRequest *oauthRequest = [NSURLRequest requestWithURL:oauthURL];
    
    [webView loadRequest:oauthRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView
{
    NSString *currentURL = _webView.request.URL.absoluteString;
    
    URLParser *parser = [[URLParser alloc] initWithURLString:currentURL];
    
    if ([currentURL rangeOfString:@"access_token"].location != NSNotFound) {
        NSLog(@"getting access token");
        NSString *accessToken = [parser valueForVariable:@"access_token"];
        [SSKeychain setPassword:accessToken forService:@"access_token" account:@"gitos"];
    } else if ([currentURL rangeOfString:@"code"].location != NSNotFound) {
        NSLog(@"getting access code");
        NSString *clientId = @"d60ccaa192ed899f048a";
        NSString *clientSecret = @"64b5131fb3bfc2ab86a71c84f92bf969e86feaef";
        NSString *code = [parser valueForVariable:@"code"];
        
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:code, @"code",
                                   clientId, @"client_id",
                                   @"http://gitos.herokuapp.com", @"redirect_uri",
                                   clientSecret, @"client_secret", nil];
        
        NSString *paramString = [paramDict urlEncodedString];
        
        NSURL *oauthAccessTokenURL = [NSURL URLWithString:@"https://github.com/login/oauth/access_token"];
        
        NSString *post = [[NSString alloc] initWithFormat:@"client_id=%@&client_secret=%@&code=%@", clientId, clientSecret, code];
        
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:oauthAccessTokenURL];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        [request addValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset] forHTTPHeaderField:@"Content-Type"];
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
        
        self.tokenRequestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [tokenRequestConnection start];
    }
}

#pragma Mark NSURLConnection delegates

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data
{
    [self.data appendData:_data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData])
    {
        NSString *accesstoken = [jsonData objectForKey:@"access_token"];
        if(accesstoken)
        {
            NSLog(@"storing accesstoken");
            [SSKeychain setPassword:accesstoken forService:@"access_token" account:@"gitos"];
            return;
        }
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    return request;
}


@end
