//
//  NSData+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "NSData+LCHelp.h"

@implementation NSData (LCHelp)

- (id)lc_jsonValue {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValue error:%@", error);
    }
    return value;
}

- (NSString *)lc_base64EncodedString {
    return [self base64EncodedStringWithOptions:0];
}

@end




