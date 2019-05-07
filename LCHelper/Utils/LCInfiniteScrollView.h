//
//  LCInfiniteScrollView.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/7.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCInfiniteScrollViewDelegate <NSObject>

@required
/**
 总数
 */
- (NSInteger)infiniteScrollNumberOfIndex;

/**
 设置图片
 
 @param imageView 需要设置图片的重用视图
 @param index 所在下标
 */
- (void)infiniteScrollWithReusableView:(UIImageView *)imageView atIndex:(NSInteger)index;

@optional

/**
 滑动事件

 @param index 滑动下标
 */
- (void)infiniteScrollDidScrollIndex:(NSInteger)index;

/**
 点击图片事件

 @param index 选中下标
 */
- (void)infiniteScrollDidSelectIndex:(NSInteger)index;

@end

@interface LCInfiniteScrollView : UIView

/**
 代理
 */
@property(nonatomic, weak) id<LCInfiniteScrollViewDelegate> delegate;

/**
 是否自动滑动, 默认NO
 */
@property(nonatomic, assign) BOOL allowsAutoScroll;

/**
 自动滑动时间间隔, 单位: 秒
 */
@property(nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

/**
 刷新界面
 */
- (void)reloadData;

@end

