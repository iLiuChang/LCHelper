//
//  UIImage+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LCHelp)

/**
 *  截屏
 *  @view: 要截屏的视图
 */
+ (UIImage *)lc_imageWithCaptureView:(UIView *)view;

/**
 *  根据颜色生成图片
 */
+ (UIImage *)lc_imageWithColor:(UIColor *)color;

/**
 *  根据颜色生成图片
 */
+ (UIImage *)lc_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  裁剪为圆形的图片
 */
- (UIImage *)lc_roundedImage;

/**
 *  裁剪为圆形的图片
 */
- (UIImage *)lc_roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/**
 *  图片水印
 *  @point: 在图片大小范围内
 *  @atts: 属性配置，比如颜色、字体大小等
 */
- (UIImage *)lc_markImageWithText:(NSString *)text point:(CGPoint)point atts:(nullable NSDictionary *)atts;

/**
 *  调整图片大小
 *
 *  @param size 大小
 *
 *  @return 图片
 */
- (UIImage *)lc_resizableImageWithSize:(CGSize)size;

/**
 *  调整图片大小
 *
 *  @param size        大小
 *  @param contentMode 调整方式
 *
 *  @return 图片
 */
- (UIImage *)lc_resizableImageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;


/**
 *  剪切圆角图片
 *
 *  @param radius 圆角宽度
 *
 *  @return 图片
 */
- (UIImage *)lc_imageWithCornerRadius:(CGFloat)radius;

/**
 *  剪切圆角图片
 *
 *  @param radius 圆角宽度
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框宽度
 *
 *  @return 图片
 */
- (UIImage *)lc_imageWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
