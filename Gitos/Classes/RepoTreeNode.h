//
//  RepoTreeNode.h
//  Gitos
//
//  Created by Tri Vuong on 1/20/13.
//  Copyright (c) 2013 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepoTreeNode : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *sha;
@property (nonatomic, strong) NSString *mode;
@property (nonatomic) NSInteger size;
@property (nonatomic, strong) NSString *url;

- (id)initWithData:(NSDictionary *)data;

@end
