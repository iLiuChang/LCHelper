//
//  UIImageView+Extension.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/7/28.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIImageView+LCHelp.h"
#import <objc/runtime.h>
#define LCImageFile(url) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

static const NSString *_lc_imageCache_operations_key = @"_lc_imageCache_operations_key";
static const NSString *_lc_imageCache_queue_key = @"_lc_imageCache_queue_key";

// ------------------------ImageDownloadOperation----------------------------------
@interface ImageDownloadOperation : NSOperation

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, copy) void(^downloadOperationFinishBlock)(ImageDownloadOperation *operation,UIImage *image);

@end

@implementation ImageDownloadOperation
- (void)main {
    
    // main方法可能在异步线程调用，这样就不恩能够访问主线程的自动释放池
    // 因此，在这里新建一个属于当前线程的自动释放池
    @autoreleasepool {
        NSLog(@"main ====  %@",[NSThread currentThread]);
        if (self.isCancelled) return;
        
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (self.isCancelled) return;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (self.downloadOperationFinishBlock) {
                self.downloadOperationFinishBlock(self, image);
            }
            
        }];
    }
}
@end

// --------------------------------end------------------------------


@implementation UIImageView (LCHelp)

- (void)setImageWithUrl:(NSString *)url indexPath:(NSIndexPath *)indexPath placeholderImage:(UIImage *)pImage didFinishDownload:(void(^)(UIImage *image,NSIndexPath *indexPath))completionHandler{
    NSString *file = LCImageFile(url);
    NSData *data = [NSData dataWithContentsOfFile:file];
    if (data) {
        UIImage *fImage = [UIImage imageWithData:data];
        self.image = fImage;
    }else {
        self.image = pImage;
        [self downloadImage:url indexPath:indexPath didFinishDownload:completionHandler];
    }
    
}

- (void)downloadImage:(NSString *)url indexPath:(NSIndexPath *)indexPath didFinishDownload:(void(^)(UIImage *image,NSIndexPath *indexPath))completionHandler{
    NSMutableDictionary *operations = [self operations];
    NSOperationQueue *queue = [self queue];
    ImageDownloadOperation *imageOperation = operations[url];
    if (!imageOperation) {
        imageOperation = [[ImageDownloadOperation alloc] init];
        imageOperation.imageUrl = url;
        imageOperation.indexPath = indexPath;
        [queue addOperation:imageOperation];
        operations[url] = imageOperation;
        imageOperation.downloadOperationFinishBlock = ^(ImageDownloadOperation *operation,UIImage *image) {
            self.image = image;
            NSString *file = LCImageFile(operation.imageUrl);
            NSData *data = UIImagePNGRepresentation(image);
            [data writeToFile:file atomically:YES];
            completionHandler(image, operation.indexPath);
        };
    }
}

- (NSOperationQueue *)queue {
    NSOperationQueue *q = objc_getAssociatedObject(self, &_lc_imageCache_queue_key);
    if (!q) {
        q = [[NSOperationQueue alloc] init];
        objc_setAssociatedObject(self, &_lc_imageCache_queue_key, q, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return q;
}

- (NSMutableDictionary *)operations {
    NSMutableDictionary *dic = objc_getAssociatedObject(self, &_lc_imageCache_operations_key);
    if (!dic) {
        dic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &_lc_imageCache_operations_key, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}



@end