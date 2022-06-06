//
//  UIBarButtonItem+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIBarButtonItem+LCHelp.h"
#import "UIView+LCHelp.h"
@implementation UIBarButtonItem (LCHelp)

+ (UIBarButtonItem *)lc_itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.lc_size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)lc_itemWithTarget:(id)target action:(SEL)action size:(CGSize)size image:(UIImage *)image highImage:(UIImage *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.lc_size = size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
