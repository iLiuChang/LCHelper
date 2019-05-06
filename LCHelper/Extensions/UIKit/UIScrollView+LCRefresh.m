//
//  UIScrollView+LCRefresh.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/16.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIScrollView+LCRefresh.h"
#import "UIView+LCHelp.h"
#import <objc/runtime.h>

#define IndViewHeight 30
#define LCRefreshKeyPathContentOffset @"contentOffset"
#define LcRefreshKeyPathPanState @"state"

typedef void (^LCSrartRefreshingBlock)();

@interface LCRefreshScrollViewManager: NSObject

@property (strong, nonatomic) UIScrollView *scrollView;

@property(nonatomic, strong) UIActivityIndicatorView *indView;

@property(nonatomic, copy) LCSrartRefreshingBlock headerBlock;

@property(nonatomic, copy) LCSrartRefreshingBlock footerBlock;

@property(nonatomic, assign) BOOL isAddObserver;

@property(nonatomic, assign) UIGestureRecognizerState cuttentState;

@property(nonatomic, assign) LCRefreshStyle refreshStyle;

@property(nonatomic, assign) BOOL headerRefreshHidden;

@property(nonatomic, assign) BOOL footerRefreshHidden;

-(void)startHeaderRefreshing;

-(void)startFooterRefreshing;

-(void)endRefreshing;

-(void)addHeaderRefreshing: (LCSrartRefreshingBlock)completionHander;

-(void)addFooterRefreshing: (LCSrartRefreshingBlock)completionHander;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

@implementation LCRefreshScrollViewManager

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
    }
    return self;
}

- (UIActivityIndicatorView *)indView {
    if (!_indView) {
        UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        
        indView.frame = CGRectMake(0, -IndViewHeight, self.scrollView.width, IndViewHeight);
        [self.scrollView addSubview:indView];
        _indView = indView;
    }
    if (_indView.width == 0) {
        _indView.width = self.scrollView.width;
    }
    return _indView;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:LcRefreshKeyPathPanState]) {
        [self scrollViewPanStateDidChange:change];
    } else if ([keyPath isEqual: LCRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    
    self.cuttentState = self.scrollView.panGestureRecognizer.state;
    if (self.scrollView.panGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    if (self.refreshStyle == LCRefreshStyleDidChange) {
        return;
    }
    CGFloat offsetY = self.scrollView.contentOffset.y;
    // top
    if (self.headerBlock && !self.headerRefreshHidden && offsetY < 0) {
        if (offsetY < -IndViewHeight && self.indView.isAnimating) {
            self.headerBlock();
        } else {
            [self endRefreshing];
        }
    }
    // bottom
    CGFloat maxFootY = self.scrollView.contentSize.height - self.scrollView.height;
    if (self.footerBlock && !self.footerRefreshHidden && maxFootY > 0 && offsetY > maxFootY) {
        CGFloat b = offsetY - maxFootY;
        if (b > IndViewHeight && self.indView.isAnimating) {
            self.footerBlock();
        } else {
            [self endRefreshing];
        }
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    //    if (self.isZooming || self.zoomScale != self.minimumZoomScale) {
    //        return;
    //    }
    
    CGFloat offsetY = self.scrollView.contentOffset.y;
    // top
    if (self.headerBlock && !self.headerRefreshHidden && offsetY < 0) {
        if (offsetY > -IndViewHeight) {
            self.scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, 0, 0);
        }
        if (offsetY < -IndViewHeight && !self.indView.isAnimating) {
            if (self.refreshStyle == LCRefreshStyleDidChange) {
                [self startHeaderRefreshing];
                self.headerBlock();
            } else {
                if (self.scrollView.isTracking) {
                    [self startHeaderRefreshing];
                }
            }
        }
    }
    
    // bottom
    CGFloat maxFootY = self.scrollView.contentSize.height - self.scrollView.height;
    if (self.footerBlock && !self.footerRefreshHidden && maxFootY > 0 && offsetY > maxFootY) {
        CGFloat b = offsetY - maxFootY;
        if (b >= 0 && b < IndViewHeight) {
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, b, 0);
        }
        if (b > IndViewHeight && !self.indView.isAnimating) {
            if (self.refreshStyle == LCRefreshStyleDidChange) {
                [self startFooterRefreshing];
                self.footerBlock();
            } else {
                if (self.scrollView.isTracking) {
                    [self startFooterRefreshing];
                }
            }
        }
    }
    
}

-(BOOL)isRefreshing {
    return self.indView.isAnimating;
}

-(void)addHeaderRefreshing: (LCSrartRefreshingBlock)completionHander {
    self.headerBlock = completionHander;
    [self addObservers];
}

-(void)addFooterRefreshing: (LCSrartRefreshingBlock)completionHander {
    self.footerBlock = completionHander;
    [self addObservers];
}

-(void)startHeaderRefreshing {
    self.indView.top = -IndViewHeight;
    [self.indView startAnimating];
    self.scrollView.contentInset = UIEdgeInsetsMake(IndViewHeight, 0, 0, 0);
}

-(void)startFooterRefreshing {
    self.indView.top = self.scrollView.contentSize.height;
    [self.indView startAnimating];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, IndViewHeight, 0);
}

-(void)endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.indView stopAnimating];
        self.scrollView.contentInset = UIEdgeInsetsZero;
    });
}

- (void)addObservers {
    if (self.isAddObserver) {
        return;
    }
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:LCRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView.panGestureRecognizer addObserver:self forKeyPath:LcRefreshKeyPathPanState options:options context:nil];
    self.isAddObserver = YES;
}

- (void)removeObservers {
    if (!self.isAddObserver) {
        return;
    }
    [self.scrollView removeObserver:self forKeyPath:LCRefreshKeyPathContentOffset context:nil];
    [self.scrollView.panGestureRecognizer removeObserver:self forKeyPath:LcRefreshKeyPathPanState context:nil];
    self.isAddObserver = NO;
}

- (void)dealloc {
    [self removeObservers];
}

@end


@implementation UIScrollView (LCRefresh)

static const char LCRefreshScrollViewManagerKey = '\0';
- (LCRefreshScrollViewManager *)refreshManager
{
    LCRefreshScrollViewManager *manager = objc_getAssociatedObject(self, &LCRefreshScrollViewManagerKey);
    if (!manager) {
        manager = [[LCRefreshScrollViewManager alloc] initWithScrollView:self];
        objc_setAssociatedObject(self, &LCRefreshScrollViewManagerKey,
                                 manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}

- (void)setRefreshStyle:(LCRefreshStyle)refreshStyle {
    [self refreshManager].refreshStyle = refreshStyle;
}

- (LCRefreshStyle)refreshStyle {
    return [self refreshManager].refreshStyle;
}

- (void)setRefreshActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)refreshActivityIndicatorViewStyle {
    [self refreshManager].indView.activityIndicatorViewStyle = refreshActivityIndicatorViewStyle;
}

- (UIActivityIndicatorViewStyle)refreshActivityIndicatorViewStyle {
    return [self refreshManager].indView.activityIndicatorViewStyle;
}

- (void)setHeaderRefreshHidden:(BOOL)headerRefreshHidden {
    [self refreshManager].headerRefreshHidden = headerRefreshHidden;
}

- (BOOL)headerRefreshHidden {
    return [self refreshManager].headerRefreshHidden;
}

- (void)setFooterRefreshHidden:(BOOL)footerRefreshHidden {
    [self refreshManager].footerRefreshHidden = footerRefreshHidden;
}

- (BOOL)footerRefreshHidden {
    return [self refreshManager].footerRefreshHidden;
}

- (BOOL)isRefreshing {
    return [self refreshManager].isRefreshing;
}

- (void)startHeaderRefreshing {
    [[self refreshManager] startHeaderRefreshing];
}

- (void)startFooterRefreshing {
    [[self refreshManager] startFooterRefreshing];
}

- (void)endRefreshing {
    [[self refreshManager] endRefreshing];
}

- (void)addHeaderRefreshing:(void (^)())completionHander {
    [[self refreshManager] addHeaderRefreshing:completionHander];
}

- (void)addFooterRefreshing:(void (^)())completionHander {
    [[self refreshManager] addFooterRefreshing:completionHander];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        // 一旦被父视图移除将清空所有数据
        objc_setAssociatedObject(self, &LCRefreshScrollViewManagerKey,
                                 nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end

