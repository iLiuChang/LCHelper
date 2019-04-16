//
//  UIScrollView+LCRefresh.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/16.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LCRefreshStylePulling,       // 松开后才会刷新，默认
    LCRefreshStyleDidChange,     // 只要超出范围就会刷新
} LCRefreshStyle;


@interface UIScrollView (LCRefresh)

/**
 *  刷新类型
 */
@property(nonatomic, assign) LCRefreshStyle refreshStyle;

/**
 *  是否需要头部刷新
 */
@property(nonatomic, assign) BOOL headerRefreshHidden;

/**
 *  是否需要底部刷新
 */
@property(nonatomic, assign) BOOL footerRefreshHidden;

/**
 *  是否正在刷新
 */
@property(nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

/**
 *  开始头部刷新
 */
-(void)startHeaderRefreshing;

/**
 *  开始底部刷新
 */
-(void)startFooterRefreshing;

/**
 *  取消所有刷新
 */
-(void)endRefreshing;

/**
 *  添加头部刷新
 *  completionHander: 完成回调
 */
-(void)addHeaderRefreshing: (void (^)())completionHander;

/**
 *  添加底部刷新
 *  completionHander: 完成回调
 */
-(void)addFooterRefreshing: (void (^)())completionHander;
@end


