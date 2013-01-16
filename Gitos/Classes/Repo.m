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

@end
