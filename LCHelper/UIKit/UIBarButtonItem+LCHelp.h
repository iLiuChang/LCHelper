//
//  UIBarButtonItem+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (LCHelp)

+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(nullable UIImage *)image
                             highImage:(nullable UIImage *)highImage;

+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                                action:(SEL)action
                                  size:(CGSize)size
                                 image:(nullable UIImage *)image
                             highImage:(nullable UIImage *)highImage;

NS_ASSUME_NONNULL_END

@end
