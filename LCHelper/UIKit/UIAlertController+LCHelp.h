//
//  UIAlertController+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (LCHelp)

- (void)lc_addActionWithTitle:(NSString *)title handler:(void (^ __nullable)(UIAlertAction *action))handler;

- (void)lc_addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;

- (void)lc_addActionWithTitles:(NSArray *)titles handler:(void (^ __nullable)(NSInteger index))handler;

- (void)lc_setTitleColor:(nullable UIColor *)color font:(nullable UIFont *)font; // 设置文本属性（iOS 8.3 以上有效）

- (void)lc_setMessageColor:(nullable UIColor *)color font:(nullable UIFont *)font; // 设置文本属性（iOS 8.3 以上有效）

@end

NS_ASSUME_NONNULL_END
