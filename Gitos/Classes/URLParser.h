//
//  URLParser.h
//  Gitos
//
//  Created by Tri Vuong on 12/15/12.
//  Copyright (c) 2012 Crafted By Tri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLParser : NSObject

@property (nonatomic, retain) NSArray *variables;

- (id)initWithURLString:(NSString *)url;
- (NSString *)valueForVariable:(NSString *)varName;

@end
