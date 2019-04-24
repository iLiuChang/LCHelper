//
//  ViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 16/8/3.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+LCRefresh.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger count;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *dic = @{
//                          @"我是中文字符": @"223333",
//                          @"aaa": @{
//                                  @"aaa": @"啦啦啦"
//                                  }
//                          };
//    NSLog(@"%@", dic);
    count = 10;

    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [tableView addFooterRefreshing:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            count+=10;
            [tableView reloadData];

            [tableView endRefreshing];

        });
    }];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
