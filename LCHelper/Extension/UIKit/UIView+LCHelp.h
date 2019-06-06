//
//  UIView+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCHelp)
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

/**
 *  获取子视图
 *
 */
- (UIView *)descendantOrSelfWithClass:(Class)cls;

/**
 *  获取父视图
 *
 */
- (UIView *)ancestorOrSelfWithClass:(Class)cls;

/**
 *  删除所有子视图
 *
 */
- (void)removeAllSubviews;

/**
 *  获取视图上的控制器
 *
 */
- (UIViewController *)viewController;
@end


@interface UIView (LCTapBlock)

/**
 *  添加单击手势
 *
 */
- (void)addTapGestureRecognizer:(void (^)())handler;

/**
 *  添加双击击手势
 *
 */
- (void)addDoubleTapGestureRecognizer:(void (^)())handler;

@end
