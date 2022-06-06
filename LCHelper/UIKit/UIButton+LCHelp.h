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
    LCButtonEdgeInsetsStyleTop, // Image上，Label下
    LCButtonEdgeInsetsStyleLeft, // Image左，Label右
    LCButtonEdgeInsetsStyleBottom, // Image下，Label上
    LCButtonEdgeInsetsStyleRight // Image右，Label左
};

@interface UIButton (LCHelp)
- (void)lc_setEdgeInsetsStyle:(LCButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
