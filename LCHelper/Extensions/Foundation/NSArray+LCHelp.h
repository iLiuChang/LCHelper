//
//  NSArray+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/10.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LCHelp)

- (NSString *)jsonString;

- (NSString *)jsonPrettyString;

+ (NSArray *)arrayWithJsonString:(NSString *)jsonStr;

@end

@interface NSArray (LCSafe)

- (id)safeObjectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (LCHelp)

- (void)removeFirstObject;

- (void)reverse;

@end
