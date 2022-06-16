//
//  UIView+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIView+LCHelp.h"
#import <objc/runtime.h>

#define lc_weakify(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;
#define lc_strongify(object) autoreleasepool {} __strong  typeof(weak##object) object = weak##object;

@implementation UIView (LCHelp)

- (CGFloat)lc_left {
    return self.frame.origin.x;
}

- (void)setLc_left:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)lc_top {
    return self.frame.origin.y;
}
- (void)setLc_top:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)lc_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLc_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lc_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLc_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)lc_centerX {
    return self.center.x;
}

- (void)setLc_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)lc_centerY {
    return self.center.y;
}

- (void)setLc_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)lc_width {
    return self.frame.size.width;
}

- (void)setLc_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)lc_height {
    return self.frame.size.height;
}

- (void)setLc_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGPoint)lc_origin {
    return self.frame.origin;
}

- (void)setLc_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)lc_size
{
    return self.frame.size;
}

- (void)setLc_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(UIView *(^)(CGFloat))lc__top {
    @lc_weakify(self);
    return ^(CGFloat top){
        @lc_strongify(self);
        self.lc_top = top;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__bottom {
    @lc_weakify(self);
    return ^(CGFloat bottom){
        @lc_strongify(self);
        self.lc_bottom = bottom;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__bottomOffset {
    @lc_weakify(self);
    return ^(CGFloat offset){
        @lc_strongify(self);
        self.lc_bottom = self.superview.lc_height + offset;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__left {
    @lc_weakify(self);
    return ^(CGFloat left){
        @lc_strongify(self);
        self.lc_left = left;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__right {
    @lc_weakify(self);
    return ^(CGFloat right){
        @lc_strongify(self);
        self.lc_right = right;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__rightOffset {
    @lc_weakify(self);
    return ^(CGFloat offset){
        @lc_strongify(self);
        self.lc_right = self.superview.lc_width + offset;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__width {
    @lc_weakify(self);
    return ^(CGFloat width){
        @lc_strongify(self);
        self.lc_width = width;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__flexToRightOffset {
    @lc_weakify(self);
    return ^(CGFloat offset){
        @lc_strongify(self);
        self.lc_width = self.superview.lc_width - self.lc_left + offset;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__height {
    @lc_weakify(self);
    return ^(CGFloat height){
        @lc_strongify(self);
        self.lc_height = height;
        return self;
    };
}

-(UIView *(^)(CGFloat))lc__flexToBottomOffset {
    @lc_weakify(self);
    return ^(CGFloat offset){
        @lc_strongify(self);
        self.lc_height = self.superview.lc_height - self.lc_top + offset;
        return self;
    };
}

- (UIView *(^)(CGFloat))lc__centerX {
    @lc_weakify(self);
    return ^(CGFloat x){
        @lc_strongify(self);
        self.lc_centerX = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))lc__centerY {
    @lc_weakify(self);
    return ^(CGFloat y){
        @lc_strongify(self);
        self.lc_centerY = y;
        return self;
    };
}

-(UIView *(^)(void))lc__center {
    @lc_weakify(self);
    return ^{
        @lc_strongify(self);
        if (self.superview) {
            self.lc_centerX = self.superview.lc_width / 2;
            self.lc_centerY = self.superview.lc_height / 2;
        }
        return self;
    };
}
- (UIView *(^)(CGSize size))lc__size {
    @lc_weakify(self);
    return ^(CGSize size){
        @lc_strongify(self);
        self.lc_size = size;
        return self;
    };
}

- (UIView *(^)(CGPoint origin))lc__origin {
    @lc_weakify(self);
    return ^(CGPoint origin){
        @lc_strongify(self);
        self.lc_origin = origin;
        return self;
    };
}

- (UIView *(^)(CGFloat w, CGFloat h))lc__sizeToFitLessThan {
    @lc_weakify(self);
    return ^(CGFloat w, CGFloat h){
        @lc_strongify(self);
        [self sizeToFit];
        if (self.lc_width < w)
            self.lc_width = w;
        if (self.lc_height < h)
            self.lc_height = h;
        return self;
    };
}

- (UIView *)lc_descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child lc_descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView *)lc_ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview lc_ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}

- (UIViewController*)lc_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)lc_removeAllSubviews{
    for( UIView *v in [self subviews]){
        [v removeFromSuperview];
    }
}

- (void)lc_roundedCorners:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end

@implementation UIView (LCTapBlock)

static const char LCSingleTapGestureRecognizerKey = '\0';
- (void)setSingleTapBlock:(void (^)(void))tap{
    objc_setAssociatedObject(self, &LCSingleTapGestureRecognizerKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))singleTapBlock{
    return objc_getAssociatedObject(self, &LCSingleTapGestureRecognizerKey);
}

static const char LCDoubleTapGestureRecognizerKey = '\0';
- (void)setDoubleTapBlock:(void (^)(void))tap{
    objc_setAssociatedObject(self, &LCDoubleTapGestureRecognizerKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))doubleTapBlock{
    return objc_getAssociatedObject(self, &LCDoubleTapGestureRecognizerKey);
}

- (void)lc_addTapGestureRecognizer:(void (^)(void))handler {
    UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(lc_singleTap)];
    [self addRequiredToDoubleTapsRecognizer:gesture];
    [self setSingleTapBlock:handler];
}

- (void)lc_addDoubleTapGestureRecognizer:(void (^)(void))handler {
    UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:2 touches:1 selector:@selector(lc_doubleTap)];
    [self addRequirementToSingleTapsRecognizer:gesture];
    [self setDoubleTapBlock:handler];
}

- (void)lc_singleTap {
    if ([self singleTapBlock]) {
        [self singleTapBlock]();
    }
}

- (void)lc_doubleTap {
    if ([self doubleTapBlock]) {
        [self doubleTapBlock]();
    }
}

- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapGesture.numberOfTapsRequired = taps;
    tapGesture.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGesture];
    
    return tapGesture;
}

- (void) addRequirementToSingleTapsRecognizer:(UIGestureRecognizer*) recognizer {
    for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
            if (tapGesture.numberOfTouchesRequired == 1 && tapGesture.numberOfTapsRequired == 1) {
                [tapGesture requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void) addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer*) recognizer {
    for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
            if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
                [recognizer requireGestureRecognizerToFail:tapGesture];
            }
        }
    }
}
@end

