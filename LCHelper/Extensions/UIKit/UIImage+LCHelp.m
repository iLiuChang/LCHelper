//
//  UIImage+Extension.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIImage+LCHelp.h"
#import <objc/runtime.h>
@implementation UIImage (LCHelp)
+ (UIImage *)imageWithCaptureView:(UIView *)view {
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 渲染控制器view的图层到上下文
    // 图层只能用渲染不能用draw
    [view.layer renderInContext:ctx];
    // 获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)circleImageWithName:(NSString *)name {
    // 加载旧的图片
    UIImage *oldImage =  [UIImage imageNamed:name];
    // 新的图片尺寸
    CGFloat imageW = oldImage.size.width;
    CGFloat imageH = oldImage.size.height;
    // 设置新的图片尺寸
    CGFloat circleW = imageW > imageH ? imageH : imageW;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleW, circleW)];
    [path addClip];
    [oldImage drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)circleImageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color {
    // 圆环的宽度
    CGFloat borderW = border;
    // 加载旧的图片
    UIImage *oldImage =  [UIImage imageNamed:name];
    // 新的图片尺寸
    CGFloat imageW = oldImage.size.width + 2 * borderW;
    CGFloat imageH = oldImage.size.height + 2 * borderW;
    // 设置新的图片尺寸
    CGFloat circleW = imageW > imageH ? imageH : imageW;
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    // 画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleW, circleW)];
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 设置颜色
    [color set];
    // 渲染
    CGContextFillPath(ctx);
    CGRect clipR = CGRectMake(borderW, borderW, circleW - 2 * borderW, circleW - 2 * borderW);
    // 画圆：正切于旧图片的圆
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    // 设置裁剪区域
    [clipPath addClip];
    // 画图片
    [oldImage drawAtPoint:CGPointMake(borderW, borderW)];
    // 获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)watermarkImageWithName:(NSString *)name text:(NSString *)text point:(CGPoint)point atts:(NSDictionary *)atts{
    
    UIImage *oldImage = [UIImage imageNamed:name];
    CGSize size = oldImage.size;
    CGFloat H = size.height;
    CGFloat W = size.width;
    CGPoint p = point;
    if (p.x > W) p.x = W;
    if (p.x < 0) p.x = 0;
    if (p.y > H) p.y = H;
    if (p.y < 0) p.y = 0;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [text drawAtPoint:p withAttributes:atts];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
            
    }
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
            
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    
    // calculated above.
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             
                                             CGImageGetColorSpace(aImage.CGImage),
                                             
                                             CGImageGetBitmapInfo(aImage.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByCropToRect:(CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

- (UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height) withContentMode:contentMode clipsToBounds:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips{
    CGRect drawRect = YYCGRectFitWithContentMode(rect, self.size, contentMode);
    if (drawRect.size.width == 0 || drawRect.size.height == 0) return;
    if (clips) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context) {
            CGContextSaveGState(context);
            CGContextAddRect(context, rect);
            CGContextClip(context);
            [self drawInRect:drawRect];
            CGContextRestoreGState(context);
        }
    } else {
        [self drawInRect:drawRect];
    }
}
CGRect YYCGRectFitWithContentMode(CGRect rect, CGSize size, UIViewContentMode mode) {
    rect = CGRectStandardize(rect);
    size.width = size.width < 0 ? -size.width : size.width;
    size.height = size.height < 0 ? -size.height : size.height;
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    switch (mode) {
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill: {
            if (rect.size.width < 0.01 || rect.size.height < 0.01 ||
                size.width < 0.01 || size.height < 0.01) {
                rect.origin = center;
                rect.size = CGSizeZero;
            } else {
                CGFloat scale;
                if (mode == UIViewContentModeScaleAspectFit) {
                    if (size.width / size.height < rect.size.width / rect.size.height) {
                        scale = rect.size.height / size.height;
                    } else {
                        scale = rect.size.width / size.width;
                    }
                } else {
                    if (size.width / size.height < rect.size.width / rect.size.height) {
                        scale = rect.size.width / size.width;
                    } else {
                        scale = rect.size.height / size.height;
                    }
                }
                size.width *= scale;
                size.height *= scale;
                rect.size = size;
                rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5);
            }
        } break;
        case UIViewContentModeCenter: {
            rect.size = size;
            rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5);
        } break;
        case UIViewContentModeTop: {
            rect.origin.x = center.x - size.width * 0.5;
            rect.size = size;
        } break;
        case UIViewContentModeBottom: {
            rect.origin.x = center.x - size.width * 0.5;
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeLeft: {
            rect.origin.y = center.y - size.height * 0.5;
            rect.size = size;
        } break;
        case UIViewContentModeRight: {
            rect.origin.y = center.y - size.height * 0.5;
            rect.origin.x += rect.size.width - size.width;
            rect.size = size;
        } break;
        case UIViewContentModeTopLeft: {
            rect.size = size;
        } break;
        case UIViewContentModeTopRight: {
            rect.origin.x += rect.size.width - size.width;
            rect.size = size;
        } break;
        case UIViewContentModeBottomLeft: {
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeBottomRight: {
            rect.origin.x += rect.size.width - size.width;
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeScaleToFill:
        case UIViewContentModeRedraw:
        default: {
            rect = rect;
        }
    }
    return rect;
}
@end
