//
//  UIAlertController+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LCHelp)

/**
 添加点击事件

 @param title 标题 类型: UIAlertActionStyleDefault
 @param handler 回调事件
 */
- (void)lc_addActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler;


/**
 添加点击事件

 @param title 标题
 @param style 类型
 @param handler 回调事件
 */
- (void)lc_addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *action))handler;

/**
 添加点击事件
 仅添加UIAlertActionStyleDefault类型, 如果添加其他类型可以和"addActionWithTitle:style:handler:"方法配合使用

 @param titles 标题数组 类型: UIAlertActionStyleDefault
 @param handler 回调下标
 */
- (void)lc_addActionWithTitles:(NSArray *)titles handler:(void (^)(NSInteger index))handler;

/**
 设置文本属性（iOS 8.3 以上有效）

 @param color 颜色
 @param font 字体
 */
- (void)lc_setTitleColor:(nullable UIColor *)color font:(nullable UIFont *)font;

/**
 设置文本属性（iOS 8.3 以上有效）
 
 @param color 颜色
 @param font 字体
 */
- (void)lc_setMessageColor:(nullable UIColor *)color font:(nullable UIFont *)font;

@end

