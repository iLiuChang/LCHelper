//
//  UIAlertController+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIAlertController+LCHelp.h"

@implementation UIAlertController (LCHelp)

- (void)lc_addActionWithTitle:(NSString *)title handler:(void (^)(UIAlertAction *action))handler {
    [self lc_addActionWithTitle:title style:(UIAlertActionStyleDefault) handler:handler];
}

- (void)lc_addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *action))handler {
    if (!title) {
        NSLog(@"title can not be emety!");
        return;
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    [self addAction:action];
}

- (void)lc_addActionWithTitles:(NSArray *)titles handler:(void (^)(NSInteger index))handler {
    if (titles.count == 0) {
        return;
    }
    
    for (int i = 0; i < titles.count; i++) {
        [self lc_addActionWithTitle:titles[i] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            if (handler) {
                handler(i);
            }
        }];
    }
}

- (void)lc_setTitleColor:(UIColor *)color font:(UIFont *)font {
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    if (color) {
        [att setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [att setObject:font forKey:NSFontAttributeName];
    }
    [self setTitleAttribute:att];
}

- (void)lc_setMessageColor:(UIColor *)color font:(UIFont *)font {
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    if (color) {
        [att setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [att setObject:font forKey:NSFontAttributeName];
    }
    [self setMessageAttribute:att];
}

- (void)setTitleAttribute:(NSDictionary *)attribute {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 8.3) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.title];
        [att addAttributes:attribute range:NSMakeRange(0, self.title.length)];
        [self setValue:att forKey:@"attributedTitle"];
    }
}

- (void)setMessageAttribute:(NSDictionary *)attribute {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 8.3) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.message];
        [att addAttributes:attribute range:NSMakeRange(0, self.title.length)];
        [self setValue:att forKey:@"attributedMessage"];
    }
}

@end
