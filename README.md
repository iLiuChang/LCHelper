# LCHelper
常用分类

## 环境

- iOS 8.0+

## CocoaPods

```objective-c
pod 'LCHelper' 
```
## 使用

### UIView+LCKeyboardObserver

监听view是否被键盘遮挡

```objective-c
UITextField *t = [[UITextField alloc] init];
t.frame = CGRectMake(100, self.view.frame.size.height - 300, 100, 50);
[self.view addSubview:t];
// 添加键盘观察者
[t lc_addKeyboardObserver];
```

### UIScrollView+LCRefresh

根据`UIActivityIndicatorView`实现的简易刷新控件

```objective-c
UITableView *tableView = [[UITableView alloc] init];
// 添加上拉刷新
[tableView lc_addFooterRefreshing:^{
}];
// 开始刷新(显示菊花)
[tableView lc_startFooterRefreshing];
```

结束刷新

```objective-c
[self.tableView lc_endRefreshing];
```

## 联系我

有什么问题欢迎大家指出，谢谢！

- 微博： [@刘畅流畅](http://weibo.com/liuchang712)
- Twitter: [@_LiuChang](https://twitter.com/_LiuChang)
