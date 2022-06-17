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

/// Captures a new image with a given view.
+ (UIImage *)lc_imageWithCaptureView:(UIView *)view;

/// Returns a new image with a given color.
+ (UIImage *)lc_imageWithColor:(UIColor *)color;

/// Returns a new image with a given color.
+ (UIImage *)lc_imageWithColor:(UIColor *)color size:(CGSize)size;

/// Returns a round image.
- (UIImage *)lc_roundedImage;

/// Returns a round image with a given `borderWidth` and `borderColor`.
- (UIImage *)lc_roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/// Returns a new image which is resized from this image. You can specify a larger or smaller size than the image size. The image content will be changed with the scale mode.
- (UIImage *)lc_resizedImageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/// Returns a new image which is cropped from this image.
- (UIImage *)lc_croppedImageWithRect:(CGRect)rect;

/// Rounds a new image with a given corner radius.
- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius;

/// Rounds a new image with a given corner radius and corners.
- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius
                                     corners:(UIRectCorner)corners
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nullable UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
