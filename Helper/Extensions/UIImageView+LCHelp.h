//
//  UIImageView+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/7/28.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LCHelp)
- (void)setImageWithUrl:(NSString *)url
              indexPath:(NSIndexPath *)indexPath
       placeholderImage:(UIImage *)pImage
      didFinishDownload:(void(^)(UIImage *image,NSIndexPath *indexPath))completionHandler;
@end
