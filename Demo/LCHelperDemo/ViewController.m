//
//  ViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 16/8/3.
//  Copyright © 2016年 LiuChang. All rights reserved.
//


#import "ViewController.h"
#import "LCHelper.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"1655257461042" ofType:@"jpg"]]];
    image = [image lc_roundedImageWithBorderWidth:50 borderColor:UIColor.redColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.lc_width, 300)];
    imageView.backgroundColor = UIColor.grayColor;
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
}


@end
