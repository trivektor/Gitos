//
//  AppConfig.m
//  Gitos
//
//  Created by Tri Vuong on 12/9/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppConfig.h"

@implementation AppConfig

+ (NSString *)getConfigValue:(NSString *)valueName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppConfig" ofType:@"plist"];
    NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:path];
    return [settings valueForKey:valueName];
}

@end
