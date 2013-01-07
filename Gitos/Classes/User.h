//
//  User.h
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *receivedEventsUrl;
@property (nonatomic, strong) NSString *followingUrl;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *starredUrl;
@property (nonatomic, strong) NSString *gistsUrl;
@property (nonatomic, strong) NSString *reposUrl;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *publicGists;
@property (nonatomic, strong) NSString *privateGists;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) NSInteger followers;
@property (nonatomic, strong) NSString *following;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *blog;
@property (nonatomic, strong) NSString *createdAt;

- (id)initWithOptions:(NSDictionary *)options;

@end
