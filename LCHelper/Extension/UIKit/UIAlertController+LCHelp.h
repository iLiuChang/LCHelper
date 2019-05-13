//
//  UIAlertController+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LCHelp)

/**
 添加点击事件

 @param title 标题
 @param handler 回调事件
 */
- (void)addActionWithTitle:(NSString *)title handler:(void (^)())handler;


/**
 添加点击事件

 @param title 标题
 @param style 类型
 @param handler 回调事件
 */
- (void)addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)())handler;


/**
 设置文本属性（iOS 8.3 以上有效）

 @param color 颜色
 @param font 字体
 */
- (void)setTitleColor:(UIColor *)color font:(UIFont *)font;

/**
 设置文本属性（iOS 8.3 以上有效）
 
 @param color 颜色
 @param font 字体
 */
- (void)setMessageColor:(UIColor *)color font:(UIFont *)font;

@end

