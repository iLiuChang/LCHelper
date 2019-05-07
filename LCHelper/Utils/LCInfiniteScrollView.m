//
//  LCInfiniteScrollView.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/7.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "LCInfiniteScrollView.h"
@interface LCInfiniteScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *reusableView;

@property (nonatomic, strong) UIImageView *centerView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LCInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];

        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        _centerView = [[UIImageView alloc] init];
        _centerView.tag = 0;
        _centerView.userInteractionEnabled = YES;
        UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [_centerView addGestureRecognizer:centerTap];
        
        [_scrollView addSubview:_centerView];
        
        _reusableView = [[UIImageView alloc] init];
        _reusableView.userInteractionEnabled = YES;
        UITapGestureRecognizer *reusableTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [_reusableView addGestureRecognizer:reusableTap];

        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(w * 3, 0);
    self.scrollView.contentOffset = CGPointMake(w, 0);
    
    self.centerView.frame = CGRectMake(w, 0, w, h);

//    self.reusableView.frame = self.scrollView.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self reloadData];
    }
}

- (void)setAllowsAutoScroll:(BOOL)allowsAutoScroll {
    _allowsAutoScroll = allowsAutoScroll;
    if (allowsAutoScroll) {
        [self addTimer];
    } else {
        [self removeTimer];
    }
}

- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval {
    if (_autoScrollTimeInterval != autoScrollTimeInterval) {
        _autoScrollTimeInterval = autoScrollTimeInterval;
        if (_allowsAutoScroll) {
            [self removeTimer];
            [self addTimer];
        }
    }
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval > 0 ? self.autoScrollTimeInterval : 2.5 target:self selector:@selector(loopScroll) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)reloadData {
    if ([self.delegate respondsToSelector:@selector(infiniteScrollWithReusableView:atIndex:)]) {
        [self.delegate infiniteScrollWithReusableView:_centerView atIndex:_centerView.tag];
    }
}

- (void)imageViewTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(infiniteScrollDidSelectIndex:)]) {
        [self.delegate infiniteScrollDidSelectIndex:tap.view.tag];
    }
}

- (void)loopScroll {
    CGFloat w = self.scrollView.bounds.size.width;
    if (w > 0) {
        [self.scrollView setContentOffset:CGPointMake(w*2, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger totalCount = [self.delegate infiniteScrollNumberOfIndex];
    if (totalCount <= 0) {
        return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat w = scrollView.frame.size.width;
    
    CGRect rf = _reusableView.frame;
    NSInteger index = 0;
    if (offsetX > _centerView.frame.origin.x) { // left
        rf.origin.x = scrollView.contentSize.width - w;
        index = _centerView.tag + 1;
        if (index >= totalCount) index = 0;
    } else { // right
        rf.origin.x = 0;
        index = _centerView.tag - 1;
        if (index < 0) index = totalCount - 1;
    }
    _reusableView.frame = rf;
    _reusableView.tag = index;
    
    [self.delegate infiniteScrollWithReusableView:_reusableView atIndex:index];
    
    if (offsetX <= 0 || offsetX >= w * 2) {
        UIImageView *temp = _centerView;
        _centerView = _reusableView;
        _reusableView = temp;
        
        _centerView.frame = _reusableView.frame;
        scrollView.contentOffset = CGPointMake(w, 0);
        [_reusableView removeFromSuperview];
    } else {
        [_scrollView addSubview:_reusableView];
    }
    
    if ([self.delegate respondsToSelector:@selector(infiniteScrollDidScrollIndex:)]) {
        [self.delegate infiniteScrollDidScrollIndex:_centerView.tag];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.allowsAutoScroll) {
        return;
    }
    
    if (!self.timer) {
        [self addTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.allowsAutoScroll) {
        return;
    }

    [self removeTimer];
}

@end
