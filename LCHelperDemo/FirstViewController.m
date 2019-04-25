//
//  FirstViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/25.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "FirstViewController.h"
#import "UIScrollView+LCRefresh.h"

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger count;
}
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 10;

    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    __weak __typeof(self) weakSelf = self;
    [tableView addFooterRefreshing:^{
        [weakSelf reload];
    }];
    
}

- (void)reload {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        count+=10;
        [self.tableView reloadData];
        
        [self.tableView endRefreshing];
        
    });

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}

- (void)dealloc {
    NSLog(@"FirstViewController dealloc");
}
@end
