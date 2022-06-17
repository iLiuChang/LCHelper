//
//  UIButton+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2022/5/10.
//  Copyright © 2022 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LCButtonEdgeInsetsStyle) {
    LCButtonEdgeInsetsStyleTop, // Image Top，Label Bottom
    LCButtonEdgeInsetsStyleLeft, // Image Left，Label Right
    LCButtonEdgeInsetsStyleBottom, // Image Bottom，Label Top
    LCButtonEdgeInsetsStyleRight // Image Right，Label Left
};

@interface UIButton (LCHelp)
- (void)lc_setEdgeInsetsStyle:(LCButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
