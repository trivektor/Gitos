//
//  Gist.h
//  Gitos
//
//  Created by Tri Vuong on 1/27/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gist : NSObject

@property (nonatomic, retain) NSDictionary *data;

- (id)initWithData:(NSDictionary *)gistData;

- (NSString *)getName;
- (NSString *)getDescription;
- (NSString *)getCreatedAt;

@end
