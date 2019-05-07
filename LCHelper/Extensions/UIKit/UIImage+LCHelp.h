//
//  UIImage+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage (LCHelp)

/**
 *  截屏
 *  @view: 要截屏的视图
 */
+ (UIImage *)imageWithCaptureView:(UIView *)view;

/**
 *  裁剪为圆形的图片
 */
+ (UIImage *)circleImageWithName:(NSString *)name;

/**
 *  裁剪为圆形带边框的图片
 *  @border: 圆环的宽度
 */
+ (UIImage *)circleImageWithName:(NSString *)name
                          border:(CGFloat)border
                     borderColor:(UIColor *)color;

/**
 *  图片水印
 *  @point: 在图片大小范围内
 *  @atts: 属性配置，比如颜色、字体大小等
 */
+ (UIImage *)watermarkImageWithName:(NSString *)name
                               text:(NSString *)text
                              point:(CGPoint)point
                               atts:(NSDictionary *)atts;

/**
 *  修正图片方向
 *  @aImage: 一般是使用CoreGraphics获取的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;
/**
 *  调整图片大小
 *
 *  @param size 大小
 *
 *  @return 图片
 */
- (UIImage *)imageByResizeToSize:(CGSize)size;

/**
 *  调整图片大小
 *
 *  @param size        大小
 *  @param contentMode 调整方式
 *
 *  @return 图片
 */
- (UIImage *)imageByResizeToSize:(CGSize)size
                     contentMode:(UIViewContentMode)contentMode;

/**
 *  剪切图片
 *
 *  @param rect 矩形
 *
 *  @return 图片
 */
- (UIImage *)imageByCropToRect:(CGRect)rect;
@end
