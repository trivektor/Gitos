//
//  RawFileViewController.m
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "RawFileViewController.h"
#import "AppConfig.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "RepoTreeNode.h"
#import "RepoTreeViewController.h"

@interface RawFileViewController ()

@end

@implementation RawFileViewController

@synthesize repo, branch, fileName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:self.fileName];
    [self fetchRawFile];
    self.spinnerView = [SpinnerView loadSpinnerIntoView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchRawFile
{
    NSString *githubRawHost = [AppConfig getConfigValue:@"GithubRawHost"];
    NSString *repoFullName = [self.repo getFullName];
    NSString *branchName = self.branch.name;

    NSArray *viewControllers = self.navigationController.viewControllers;
    NSMutableArray *blobPaths = [[NSMutableArray alloc] initWithCapacity:0];
    RepoTreeNode *node;
    RepoTreeViewController *treeController;

    for (int i=0; i < viewControllers.count; i++) {
        if ([[viewControllers objectAtIndex:i] isKindOfClass:[RepoTreeViewController class]]) {
            treeController = (RepoTreeViewController *)[viewControllers objectAtIndex:i];
            node = treeController.node;
            if (node != (id)[NSNull null]) {
                [blobPaths addObject:node.path];
            }
        }
    }

    NSMutableArray *paths = [[NSMutableArray alloc] initWithCapacity:0];

    [paths addObject:repoFullName];
    [paths addObject:branchName];

    if (blobPaths.count == 0) {
        [paths addObject:self.fileName];
    } else {
        [paths addObject:[blobPaths componentsJoinedByString:@"/"]];
        [paths addObject:self.fileName];
    }

    NSURL *rawFileUrl = [NSURL URLWithString:[githubRawHost stringByAppendingFormat:@"/%@", [paths componentsJoinedByString:@"/"]]];

    NSString *content = [NSString stringWithContentsOfURL:rawFileUrl encoding:NSASCIIStringEncoding error:nil];

    [fileWebView loadHTMLString:[NSString stringWithFormat:@"<!DOCTYPE html> \
    <html> \
        <head> \
            <link rel='stylesheet' type='text/css' href='http://google-code-prettify.googlecode.com/svn-history/r52/trunk/src/prettify.css'></link> \
            <style>html, body{padding:0;margin:0;background:#000} pre.prettyprint, code.prettyprint{border:0 !important; border-radius:0 !important;-webkit-border-radius:0 !important;margin:0 !important}</style> \
            <link rel='stylesheet' href='http://google-code-prettify.googlecode.com/svn/trunk/styles/sunburst.css'></link>\
            <script src='http://google-code-prettify.googlecode.com/svn-history/r52/trunk/src/prettify.js'></script> \
        </head> \
        <body onload='prettyPrint()'> \
            <pre class='prettyprint'>%@</pre> \
        </body> \
    </html>", content] baseURL: nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinnerView setHidden:YES];
}

@end
