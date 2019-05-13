//
//  UIBarButtonItem+Extension.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIBarButtonItem+LCHelp.h"
#import "UIView+LCHelp.h"
@implementation UIBarButtonItem (LCHelp)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action size:(CGSize)size image:(UIImage *)image highImage:(UIImage *)highImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.size = size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
