//
//  NSData+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LCHelp)

- (NSString *)md5String;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;

@end
