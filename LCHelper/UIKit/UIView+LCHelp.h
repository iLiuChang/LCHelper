//
//  UIView+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCHelp)

// ================废弃==================
@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat bottom;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;
@property(nonatomic, assign) CGPoint origin;
@property(nonatomic, assign) CGSize size;
// ==================================

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

/**
 *  获取子视图
 *
 */
- (UIView *)lc_descendantOrSelfWithClass:(Class)cls;

/**
 *  获取父视图
 *
 */
- (UIView *)lc_ancestorOrSelfWithClass:(Class)cls;

/**
 *  删除所有子视图
 *
 */
- (void)lc_removeAllSubviews;

/**
 *  获取视图上的控制器
 *
 */
- (UIViewController *)lc_viewController;
@end


@interface UIView (LCTapBlock)

/**
 *  添加单击手势
 *
 */
- (void)lc_addTapGestureRecognizer:(void (^)(void))handler;

/**
 *  添加双击击手势
 *
 */
- (void)lc_addDoubleTapGestureRecognizer:(void (^)(void))handler;

@end
