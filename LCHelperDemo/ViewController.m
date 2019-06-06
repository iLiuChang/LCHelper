//
//  ViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 16/8/3.
//  Copyright © 2016年 LiuChang. All rights reserved.
//


#import "ViewController.h"
#import "FirstViewController.h"
#import "KeyboardViewController.h"
#import "LCHelper.h"

@interface ViewController ()<LCInfiniteScrollViewDelegate>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) LCInfiniteScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.images = @[[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)],
                    [UIImage imageWithColor:[UIColor yellowColor] size:CGSizeMake(20, 20)],
                    [UIImage imageWithColor:[UIColor orangeColor] size:CGSizeMake(20, 20)],
                    [UIImage imageWithColor:[UIColor magentaColor] size:CGSizeMake(20, 20)]];
    LCInfiniteScrollView *sv = [[LCInfiniteScrollView alloc] init];
    sv.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    sv.delegate = self;

    [self.view addSubview:sv];
    self.scrollView = sv;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [sv reloadData];
//    });
    
    [self.view addTapGestureRecognizer:^{
        NSLog(@"single tap");
    }];
    
    [self.view addDoubleTapGestureRecognizer:^{
        NSLog(@"double tap");
    }];
}

- (NSInteger)infiniteScrollNumberOfIndex {
    return self.images.count;
}

- (void)infiniteScrollWithReusableView:(UIView *)reusableView atIndex:(NSInteger)index {
    ((UIImageView *)reusableView).image = self.images[index];
    NSLog(@"infiniteScrollWithReusableView %ld", index);

}

- (void)infiniteScrollDidScrollIndex:(NSInteger)index {
    NSLog(@"infiniteScrollDidScrollIndex %ld", index);
}

- (void)infiniteScrollDidSelectIndex:(NSInteger)index {
    NSLog(@"infiniteScrollDidSelectIndex %ld", index);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    KeyboardViewController *vc = [[KeyboardViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    [[UIActionSheet actionSheetWithTitle:@"232" buttonIndex:^(NSInteger index) {
//                NSLog(@"%ld", index);
//
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"1",@"2", nil] showInView:self.view] ;
 
//    [[UIAlertView alertWithTitle:@"提示" message:@"好的" buttonIndex:^(NSInteger index) {
//        NSLog(@"%ld", index);
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"其他", @"开始", nil] show] ;
    
//    self.images = @[[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)],
//                    [UIImage imageWithColor:[UIColor yellowColor] size:CGSizeMake(20, 20)],
//                    [UIImage imageWithColor:[UIColor magentaColor] size:CGSizeMake(20, 20)]];
//
//    [self.scrollView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
