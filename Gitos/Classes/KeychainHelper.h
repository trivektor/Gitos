//
//  KeychainHelper.h
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainHelper : NSObject

+ (NSString *)getAuthenticationToken;
+ (void)setAuthenticationToken:(NSString *)authToken;
+ (void)reset;

@end
