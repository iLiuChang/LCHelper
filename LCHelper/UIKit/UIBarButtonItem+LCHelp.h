//
//  UIBarButtonItem+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LCHelp)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                          highImage:(UIImage *)highImage;

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param size      item大小
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                             action:(SEL)action
                               size:(CGSize)size
                              image:(UIImage *)image
                          highImage:(UIImage *)highImage;
@end
