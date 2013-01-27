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
@property (nonatomic, retain) NSDictionary *details;

- (id)initWithData:(NSDictionary *)gistData;

- (NSString *)getId;
- (NSString *)getName;
- (NSString *)getDescription;
- (NSString *)getCreatedAt;
- (NSInteger)getNumberOfForks;
- (NSInteger)getNumberOfFiles;
- (NSInteger)getNumberOfComments;

@end
