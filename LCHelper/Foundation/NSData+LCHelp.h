//
//  NSData+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LCHelp)

- (nullable id)lc_jsonValue;

- (nullable NSString *)lc_base64EncodedString;

@end

NS_ASSUME_NONNULL_END




