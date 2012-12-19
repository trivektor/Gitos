//
//  User.h
//  Gitos
//
//  Created by Tri Vuong on 12/19/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *receivedEventsUrl;
@property (nonatomic, strong) NSString *followingUrl;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *starredUrl;
@property (nonatomic, strong) NSString *reposUrl;

- (id)initWithAccessToken:(NSString *)accessToken;

@end
