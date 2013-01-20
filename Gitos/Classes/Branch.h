//
//  Branch.h
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfig.h"

@interface Branch : NSObject

@property (nonatomic, strong) NSString *name;

- (id)initWithData:(NSDictionary *)data;

- (NSString *)getUrl;

@end
