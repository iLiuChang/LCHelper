//
//  UIColor+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/7/6.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LCHelp)

+ (UIColor *)lc_colorWithHex:(NSString *)hexStr; // @"0xF0F", @"66ccff", @"#66CCFF88"

+ (UIColor *)lc_colorWithRGB:(uint32_t)rgbValue;

+ (UIColor *)lc_colorWithRGBA:(uint32_t)rgbaValue;

+ (UIColor *)lc_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
