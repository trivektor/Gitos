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

@synthesize name, login, url, receivedEventsUrl, followingUrl, avatarUrl, htmlUrl, starredUrl, reposUrl, gistsUrl,
            location, publicGists, privateGists, email, followers, following, blog, createdAt, company, bio, publicRepos;

- (id)initWithOptions:(NSDictionary *)options
{
    self.name               = [options valueForKey:@"name"];
    self.login              = [options valueForKey:@"login"];
    self.url                = [options valueForKey:@"url"];
    self.followingUrl       = [options valueForKey:@"follwowing_url"];
    self.receivedEventsUrl  = [options valueForKey:@"received_events_url"];
    self.avatarUrl          = [options valueForKey:@"avatar_url"];
    self.starredUrl         = [self.url stringByAppendingString:@"/starred"];
    self.gistsUrl           = [self.url stringByAppendingString:@"/gists"];
    self.htmlUrl            = [options valueForKey:@"html_url"];
    self.reposUrl           = [options valueForKey:@"repos_url"];
    self.location           = [options valueForKey:@"location"];
    self.publicGists        = [options valueForKey:@"public_gists"];
    self.privateGists       = [options valueForKey:@"private_gists"];
    self.email              = [options valueForKey:@"email"];
    self.followers          = [[options valueForKey:@"followers"] integerValue];
    self.following          = [[options valueForKey:@"following"] integerValue];
    self.publicRepos        = [[options valueForKey:@"public_repos"] integerValue];
    self.createdAt          = [options valueForKey:@"created_at"];
    self.blog               = [options valueForKey:@"blog"];
    self.company            = [options valueForKey:@"company"];

    if ([options valueForKey:@"bio"] == [NSNull null]) {
        self.bio = @"n/a";
    } else {
        self.bio = [options valueForKey:@"bio"];
    }

    return self;
}

@end
