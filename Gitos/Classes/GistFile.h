//
//  GistFile.h
//  Gitos
//
//  Created by Tri Vuong on 1/27/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GistFile : NSObject

@property (nonatomic, strong) NSDictionary *data;

- (id)initWithData:(NSDictionary *)gistData;

- (NSString *)getName;
- (NSString *)getRawUrl;

@end
