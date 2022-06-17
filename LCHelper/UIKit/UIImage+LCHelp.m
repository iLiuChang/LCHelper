//
//  UIImage+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIImage+LCHelp.h"
#import <objc/runtime.h>
@implementation UIImage (LCHelp)
+ (UIImage *)lc_imageWithCaptureView:(UIView *)view {
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

+ (UIImage *)lc_imageWithColor:(UIColor *)color {
    return [UIImage lc_imageWithColor:color size:CGSizeMake(10, 10)];
}

+ (UIImage *)lc_imageWithColor:(UIColor *)color size:(CGSize)size {
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

- (UIImage *)lc_roundedImage {
    return [self lc_roundedImageWithBorderWidth:0 borderColor:nil];
}

- (UIImage *)lc_roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
    CGFloat minW = MIN(imageW, imageH);
    CGFloat x = ((imageW-minW)<0?0:(imageW-minW))/2.0;
    CGFloat y = ((imageH-minW)<0?0:(imageH-minW))/2.0;
    CGPoint point = CGPointZero;
    if (borderColor && borderWidth > 0) {
        CGFloat bgW = self.size.width+borderWidth*2;
        CGFloat bgH = self.size.height+borderWidth*2;
        CGFloat bgMinW = MIN(bgW, bgH);
        CGFloat bgX = ((bgW-bgMinW)<0?0:(bgW-bgMinW))/2.0;
        CGFloat bgY = ((bgH-bgMinW)<0?0:(bgH-bgMinW))/2.0;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(bgW, bgH), NO, self.scale);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(bgX, bgY, bgMinW, bgMinW)];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddPath(ctx, path.CGPath);
        [borderColor set];
        CGContextFillPath(ctx);
        x += borderWidth;
        y += borderWidth;
        point = CGPointMake(borderWidth, borderWidth);
    } else {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    }

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, minW, minW)];
    [path addClip];
    [self drawAtPoint:point];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)lc_resizedImageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height) withContentMode:contentMode clipsToBounds:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)lc_croppedImageWithRect:(CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    if (self.CIImage) {
        CGRect croppingRect = CGRectMake(rect.origin.x, self.size.height - CGRectGetMaxY(rect), rect.size.width, rect.size.height);
        CIImage *ciImage = [self.CIImage imageByCroppingToRect:croppingRect];
        UIImage *image = [UIImage imageWithCIImage:ciImage scale:self.scale orientation:self.imageOrientation];
        return image;
    }
    CGImageRef imageRef = self.CGImage;
    if (!imageRef) {
        return nil;
    }
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    if (!croppedImageRef) {
        return nil;
    }
    UIImage *image = [UIImage imageWithCGImage:croppedImageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(croppedImageRef);
    return image;
}

- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips{
    CGRect drawRect = LC_CGRectFitWithContentMode(rect, self.size, contentMode);
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

CGRect LC_CGRectFitWithContentMode(CGRect rect, CGSize size, UIViewContentMode mode) {
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

- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius {
    return [self lc_roundedCornerImageWithRadius:radius corners:(UIRectCornerAllCorners) borderWidth:0 borderColor:nil];
}

- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius
                                     corners:(UIRectCorner)corners
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(UIColor *)borderColor {
    return [self roundedCornerImageWithRadius:radius
                                      corners:corners
                                  borderWidth:borderWidth
                                  borderColor:borderColor
                               borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)roundedCornerImageWithRadius:(CGFloat)radius
                                  corners:(UIRectCorner)corners
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(UIColor *)borderColor
                           borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
