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

@synthesize receivedEventsUrl, followingUrl, avatarUrl, htmlUrl, starredUrl, reposUrl, login;

- (id)initWithOptions:(NSDictionary *)options
{
    self.receivedEventsUrl = [options valueForKey:@"received_events_url"];
    self.login = [options valueForKey:@"login"];
    return self;
}

@end
