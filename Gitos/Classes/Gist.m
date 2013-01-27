//
//  Gist.m
//  Gitos
//
//  Created by Tri Vuong on 1/27/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import "Gist.h"

@implementation Gist

@synthesize data;

- (id)initWithData:(NSDictionary *)gistData
{
    self = [super init];

    self.data = gistData;

    return self;
}

- (NSString *)getName
{
    return [NSString stringWithFormat:@"gist:%@", [self.data valueForKey:@"id"]];
}

- (NSString *)getDescription
{
    if ([self.data valueForKey:@"description"] != [NSNull null]) {
        return [self.data valueForKey:@"description"];
    } else {
        return @"n/a";
    }
}

- (NSString *)getCreatedAt
{
    return [self.data valueForKey:@"created_at"];
}

@end
