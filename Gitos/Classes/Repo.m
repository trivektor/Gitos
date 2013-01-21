//
//  Repo.m
//  Gitos
//
//  Created by Tri Vuong on 1/15/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "Repo.h"

@implementation Repo

@synthesize data;

- (id)initWithData:(NSDictionary *)_data
{
    self = [super init];

    self.data = _data;

    return self;
}

- (NSString *)getName
{
    return [self.data valueForKey:@"name"];
}

- (NSString *)getFullName
{
    return [self.data valueForKey:@"full_name"];
}

- (NSInteger)getForks
{
    return [[self.data valueForKey:@"forks"] integerValue];
}

- (NSInteger)getWatchers
{
    return [[self.data valueForKey:@"watchers"] integerValue];
}

- (NSString *)getLanguage
{
    return [self.data valueForKey:@"language"];
}

- (NSString *)getBranchesUrl
{
    NSString *url = [self.data valueForKey:@"url"];
    return [url stringByAppendingFormat:@"/branches"];
}

- (NSString *)getTreeUrl
{
    NSString *url = [self.data valueForKey:@"url"];
    return [url stringByAppendingFormat:@"/git/trees/"];
}

- (NSInteger)getSize
{
    return [[self.data valueForKey:@"size"] integerValue];
}

- (NSString *)getPushedAt
{
    return [self.data valueForKey:@"pushed_at"];
}

- (NSString *)getDescription
{
    return [self.data valueForKey:@"description"];
}

@end
