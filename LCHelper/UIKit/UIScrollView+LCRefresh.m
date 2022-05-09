//
//  UIScrollView+LCRefresh.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/16.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIScrollView+LCRefresh.h"
#import <objc/runtime.h>
#import "UIView+LCHelp.h"

#define LCRefreshKeyPathContentOffset @"contentOffset"
#define LCRefreshKeyPathPanState @"state"
#define LCRefreshKeyPathContentSize @"contentSize"

static CGFloat LCRefreshActivityIndicatorHeight = 30;
@interface LCPullToRefreshManager: NSObject

@property (strong, nonatomic) UIScrollView *scrollView;

@property(nonatomic, strong) UIActivityIndicatorView *indView;

@property(nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property(nonatomic, assign) LCRefreshScrollDirection refreshScrollDirection;

@property(nonatomic, copy) LCRefreshActionHandler headerBlock;

@property(nonatomic, copy) LCRefreshActionHandler footerBlock;

@property(nonatomic, assign) BOOL isAddObserver;

@property(nonatomic, assign) BOOL headerRefreshEnabled;

@property(nonatomic, assign) BOOL footerRefreshEnabled;

@property(nonatomic, assign) UIEdgeInsets scrollViewSafeInset;

@property(nonatomic, assign) UIEdgeInsets scrollViewStartInset;

@property(nonatomic, assign) BOOL isRefreshing;

@property(nonatomic, assign) BOOL isHavePanAction;

-(void)beginHeaderRefreshing;

-(void)beginFooterRefreshing;

-(void)endRefreshing;

-(void)addHeaderRefreshing: (LCRefreshActionHandler)completionHander;

-(void)addFooterRefreshing: (LCRefreshActionHandler)completionHander;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

@implementation LCPullToRefreshManager

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        _headerRefreshEnabled = YES;
        _footerRefreshEnabled = YES;
        _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _scrollView = scrollView;
        _scrollViewStartInset = scrollView.contentInset;
    }
    return self;
}

- (UIActivityIndicatorView *)indView {
    if (!_indView) {
        UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(_activityIndicatorViewStyle)];
        LCRefreshActivityIndicatorHeight = indView.lc_height+10;
        if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
            indView.frame = CGRectMake(-LCRefreshActivityIndicatorHeight,0 ,LCRefreshActivityIndicatorHeight, self.scrollView.lc_height);
        } else {
            indView.frame = CGRectMake(0, -LCRefreshActivityIndicatorHeight, self.scrollView.lc_width, LCRefreshActivityIndicatorHeight);
        }
        [self.scrollView addSubview:indView];
        _indView = indView;
    }
    return _indView;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:LCRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    } else if ([keyPath isEqualToString:LCRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:LCRefreshKeyPathContentSize]) {
        [self scrollViewLayout:change];
    }
}

- (void)scrollViewLayout:(NSDictionary *)change {
    if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
        self.indView.lc_height = self.scrollView.contentSize.height;
    } else {
        self.indView.lc_width = self.scrollView.contentSize.width;
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    _isHavePanAction = YES;
    
    if (self.scrollView.panGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
 
    if (self.indView.isAnimating && !_isRefreshing) {
        if ([self isHeaderRefreshingActionWithOffset:LCRefreshActivityIndicatorHeight]) {
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets contentInset = self.scrollViewStartInset;
                if (self.refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
                    contentInset.left += LCRefreshActivityIndicatorHeight;
                } else {
                    contentInset.top += LCRefreshActivityIndicatorHeight;
                }
                self.scrollView.contentInset = contentInset;
            } completion:^(BOOL finished) {
                self.isRefreshing = YES;
                self.headerBlock();
            }];
           
        } else if ([self isFooterRefreshingActionWithOffset:LCRefreshActivityIndicatorHeight]) {
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets contentInset = self.scrollViewStartInset;
                if (self.refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
                    contentInset.right += LCRefreshActivityIndicatorHeight;
                } else {
                    contentInset.bottom += LCRefreshActivityIndicatorHeight;
                }
                self.scrollView.contentInset = contentInset;
            } completion:^(BOOL finished) {
                self.isRefreshing = YES;
                self.footerBlock();
            }];
        } else {
            [self endRefreshing];
        }
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (!_isHavePanAction) {
        if (@available(iOS 11.0, *)) {
            _scrollViewSafeInset = self.scrollView.adjustedContentInset;
        } else {
            _scrollViewSafeInset = self.scrollView.contentInset;
        }
    }
    
    if (self.isRefreshing || !self.scrollView.isTracking || self.indView.isAnimating) {
        return;
    }
 
    if ([self isHeaderRefreshingActionWithOffset:10]) {
        [self.indView startAnimating];
        if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
            self.indView.lc_left = -LCRefreshActivityIndicatorHeight;
        } else {
            self.indView.lc_top = -LCRefreshActivityIndicatorHeight;
        }
    } else if ([self isFooterRefreshingActionWithOffset:10]) {
        [self.indView startAnimating];
        if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
            self.indView.lc_left = self.scrollView.contentSize.width;
        } else {
            self.indView.lc_top = self.scrollView.contentSize.height;
        }
    }
}

- (BOOL)isHeaderRefreshingActionWithOffset:(CGFloat)offset {
    if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
        CGFloat offsetX = self.scrollView.contentOffset.x;
        CGFloat happenOffsetLeft = - _scrollViewSafeInset.left;
        return self.headerBlock && self.headerRefreshEnabled && offsetX < happenOffsetLeft && offsetX < (-offset+happenOffsetLeft);
    }
    CGFloat offsetY = self.scrollView.contentOffset.y;
    CGFloat happenOffsetTop = - _scrollViewSafeInset.top;
    return self.headerBlock && self.headerRefreshEnabled && offsetY < happenOffsetTop && offsetY < (-offset+happenOffsetTop);
}

- (BOOL)isFooterRefreshingActionWithOffset:(CGFloat)offset {
    if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
        CGFloat maxFootX = self.scrollView.contentSize.width - self.scrollView.lc_width;
        CGFloat offsetX = self.scrollView.contentOffset.x;
        return self.footerBlock && self.footerRefreshEnabled && maxFootX > 0 && offsetX > maxFootX && (offsetX - maxFootX) > offset;
    }
    CGFloat maxFootY = self.scrollView.contentSize.height - self.scrollView.lc_height;
    CGFloat offsetY = self.scrollView.contentOffset.y;
    return self.footerBlock && self.footerRefreshEnabled && maxFootY > 0 && offsetY > maxFootY && (offsetY - maxFootY) > offset;
}

-(void)addHeaderRefreshing: (LCRefreshActionHandler)completionHander {
    self.headerBlock = completionHander;
    [self addObservers];
}

-(void)addFooterRefreshing: (LCRefreshActionHandler)completionHander {
    self.footerBlock = completionHander;
    [self addObservers];
}

-(void)beginHeaderRefreshing {
    if (self.headerBlock && !self.indView.isAnimating && !_isRefreshing && self.headerRefreshEnabled) {
        [self.indView startAnimating];
        if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
            self.indView.lc_left = -LCRefreshActivityIndicatorHeight;
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets contentInset = self.scrollViewStartInset;
                contentInset.left += LCRefreshActivityIndicatorHeight;
                self.scrollView.contentInset = contentInset;
                CGPoint conentOffset = self.scrollView.contentOffset;
                conentOffset.x -= LCRefreshActivityIndicatorHeight;
                self.scrollView.contentOffset = conentOffset;
            } completion:^(BOOL finished) {
                self.isRefreshing = YES;
                self.headerBlock();
            }];
        } else {
            self.indView.lc_top = -LCRefreshActivityIndicatorHeight;
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets contentInset = self.scrollViewStartInset;
                contentInset.top += LCRefreshActivityIndicatorHeight;
                self.scrollView.contentInset = contentInset;
                CGPoint conentOffset = self.scrollView.contentOffset;
                conentOffset.y -= LCRefreshActivityIndicatorHeight;
                self.scrollView.contentOffset = conentOffset;
            } completion:^(BOOL finished) {
                self.isRefreshing = YES;
                self.headerBlock();
            }];
        }
    }
}

-(void)beginFooterRefreshing {
    if (self.footerBlock && !self.indView.isAnimating && !_isRefreshing && self.footerRefreshEnabled) {
        [self.indView startAnimating];
        if (_refreshScrollDirection == LCRefreshScrollDirectionHorizontal) {
            self.indView.lc_left = self.scrollView.contentSize.width;
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets contentInset = self.scrollViewStartInset;
                contentInset.right += LCRefreshActivityIndicatorHeight;
                self.scrollView.contentInset = contentInset;
                CGPoint conentOffset = self.scrollView.contentOffset;
                conentOffset.x += LCRefreshActivityIndicatorHeight;
                self.scrollView.contentOffset = conentOffset;
            } completion:^(BOOL finished) {
                self.isRefreshing = YES;
                self.footerBlock();
            }];
        } else {
            self.indView.lc_top = self.scrollView.contentSize.height;
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets contentInset = self.scrollViewStartInset;
                contentInset.bottom += LCRefreshActivityIndicatorHeight;
                self.scrollView.contentInset = contentInset;
                CGPoint conentOffset = self.scrollView.contentOffset;
                conentOffset.y += LCRefreshActivityIndicatorHeight;
                self.scrollView.contentOffset = conentOffset;
            } completion:^(BOOL finished) {
                self.isRefreshing = YES;
                self.footerBlock();
            }];
        }
       
    }
}

-(void)endRefreshing {
    [self endRefreshingAnimated:YES];
}

- (void)endRefreshingAnimated:(BOOL)animation {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (animation) {
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.contentInset = self.scrollViewStartInset;
            } completion:^(BOOL finished) {
                [self.indView stopAnimating];
                self.isRefreshing = NO;
            }];
        } else {
            self.scrollView.contentInset = self.scrollViewStartInset;
            [self.indView stopAnimating];
            self.isRefreshing = NO;
        }
    });
}

- (void)addObservers {
    if (self.isAddObserver) {
        return;
    }
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:LCRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView.panGestureRecognizer addObserver:self forKeyPath:LCRefreshKeyPathPanState options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:LCRefreshKeyPathContentSize options:options context:nil];

    self.isAddObserver = YES;
}

- (void)removeObservers {
    if (!self.isAddObserver) {
        return;
    }
    [self.scrollView removeObserver:self forKeyPath:LCRefreshKeyPathContentOffset context:nil];
    [self.scrollView.panGestureRecognizer removeObserver:self forKeyPath:LCRefreshKeyPathPanState context:nil];
    [self.scrollView removeObserver:self forKeyPath:LCRefreshKeyPathContentSize context:nil];

    self.isAddObserver = NO;
}

- (void)dealloc {
    [self removeObservers];
}

@end


@implementation UIScrollView (LCRefresh)

static const char LCPullToRefreshManagerKey = '\0';
- (LCPullToRefreshManager *)pullToRefreshManager
{
    LCPullToRefreshManager *manager = objc_getAssociatedObject(self, &LCPullToRefreshManagerKey);
    if (!manager) {
        manager = [[LCPullToRefreshManager alloc] initWithScrollView:self];
        objc_setAssociatedObject(self, &LCPullToRefreshManagerKey,
                                 manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}

- (void)setLc_refreshActivityIndicatorStyle:(UIActivityIndicatorViewStyle)lc_refreshActivityIndicatorStyle {
    [self pullToRefreshManager].activityIndicatorViewStyle = lc_refreshActivityIndicatorStyle;
}

- (UIActivityIndicatorViewStyle)lc_refreshActivityIndicatorStyle {
    return [self pullToRefreshManager].activityIndicatorViewStyle;
}

- (void)setLc_refreshScrollDirection:(LCRefreshScrollDirection)lc_refreshScrollDirection {
    [self pullToRefreshManager].refreshScrollDirection = lc_refreshScrollDirection;
}

- (LCRefreshScrollDirection)lc_refreshScrollDirection {
    return [self pullToRefreshManager].refreshScrollDirection;
}

- (void)setLc_headerRefreshEnabled:(BOOL)lc_headerRefreshEnabled {
    [self pullToRefreshManager].headerRefreshEnabled = lc_headerRefreshEnabled;
}

- (BOOL)lc_headerRefreshEnabled {
    return [self pullToRefreshManager].headerRefreshEnabled;
}

- (void)setLc_footerRefreshEnabled:(BOOL)lc_footerRefreshEnabled {
    [self pullToRefreshManager].footerRefreshEnabled = lc_footerRefreshEnabled;
}

- (BOOL)lc_footerRefreshEnabled {
    return [self pullToRefreshManager].footerRefreshEnabled;
}

- (BOOL)lc_refreshing {
    return [self pullToRefreshManager].isRefreshing;
}

- (void)lc_beginHeaderRefreshing {
    [[self pullToRefreshManager] beginHeaderRefreshing];
}

- (void)lc_beginFooterRefreshing {
    [[self pullToRefreshManager] beginFooterRefreshing];
}

- (void)lc_endRefreshing {
    [[self pullToRefreshManager] endRefreshing];
}

- (void)lc_endRefreshingAnimated:(BOOL)animation {
    [[self pullToRefreshManager] endRefreshingAnimated:animation];
}

-(void)lc_addHeaderRefreshingWithActionHandler:(LCRefreshActionHandler)actionHandler {
    [[self pullToRefreshManager] addHeaderRefreshing:actionHandler];
}

-(void)lc_addFooterRefreshingWithActionHandler:(LCRefreshActionHandler)actionHandler {
    [[self pullToRefreshManager] addFooterRefreshing:actionHandler];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        // 一旦被父视图移除将清空所有数据
        objc_setAssociatedObject(self, &LCPullToRefreshManagerKey,
                                 nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end


