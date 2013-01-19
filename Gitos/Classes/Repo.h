//
//  Repo.h
//  Gitos
//
//  Created by Tri Vuong on 1/15/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property(nonatomic, strong) NSDictionary *data;

- (id)initWithData:(NSDictionary *)data;

- (NSString *)getName;
- (NSInteger)getForks;
- (NSInteger)getWatchers;

@end
