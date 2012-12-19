//
//  User.m
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import "User.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@implementation User

@synthesize receivedEventsUrl, followingUrl, avatarUrl, htmlUrl, starredUrl, reposUrl;

- (id)initWithOptions:(NSDictionary *)options
{
    self.receivedEventsUrl = [options valueForKey:@"received_events_url"];
    return self;
}

@end
