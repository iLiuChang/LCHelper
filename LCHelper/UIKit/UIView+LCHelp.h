//
//  UIView+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LCHelp)

@property(nonatomic, assign) CGFloat lc_left;
@property(nonatomic, assign) CGFloat lc_top;
@property(nonatomic, assign) CGFloat lc_right;
@property(nonatomic, assign) CGFloat lc_bottom;
@property(nonatomic, assign) CGFloat lc_width;
@property(nonatomic, assign) CGFloat lc_height;
@property(nonatomic, assign) CGFloat lc_centerX;
@property(nonatomic, assign) CGFloat lc_centerY;
@property(nonatomic, assign) CGPoint lc_origin;
@property(nonatomic, assign) CGSize lc_size;

// 链式编程
- (UIView *(^)(CGFloat top))lc__top;
- (UIView *(^)(CGFloat bottom))lc__bottom;
- (UIView *(^)(CGFloat offset))lc__bottomOffset;
- (UIView *(^)(CGFloat left))lc__left;
- (UIView *(^)(CGFloat right))lc__right;
- (UIView *(^)(CGFloat offset))lc__rightOffset;
- (UIView *(^)(CGFloat width))lc__width;
- (UIView *(^)(CGFloat offset))lc__flexToRightOffset; // width
- (UIView *(^)(CGFloat height))lc__height;
- (UIView *(^)(CGFloat offset))lc__flexToBottomOffset; // height
- (UIView *(^)(CGFloat x))lc__centerX;
- (UIView *(^)(CGFloat y))lc__centerY;
- (UIView *(^)(void))lc__center;
- (UIView *(^)(CGSize size))lc__size;
- (UIView *(^)(CGPoint origin))lc__origin;
- (UIView *(^)(CGFloat w, CGFloat h))lc__sizeToFitLessThan;

- (nullable UIView *)lc_descendantOrSelfWithClass:(Class)cls; // subview

- (nullable UIView *)lc_ancestorOrSelfWithClass:(Class)cls; // superview

- (void)lc_removeAllSubviews;

- (nullable UIViewController *)lc_viewController;

- (void)lc_roundedCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius; // Rounds a view with a given corner radius and corners.

@end


@interface UIView (LCTapBlock)

- (void)lc_addTapGestureRecognizer:(void (^)(void))handler; // one

- (void)lc_addDoubleTapGestureRecognizer:(void (^)(void))handler; // two

@end

NS_ASSUME_NONNULL_END
