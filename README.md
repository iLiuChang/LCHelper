# LCHelper
项目中一些总结, 主要是一些分类

## 环境

- iOS 8.0+

## CocoaPods

#### Podfile

```objective-c
pod 'LCHelper' 
```
#### Subspecs

```objective-c
pod 'LCHelper/Extension' 
pod 'LCHelper/Util' 
```

## 文件目录

### LCHelper.h

包含所有文件

### LCUtil.h 

- LCSingleton 
- LCInfiniteScrollView


### LCExtension.h

- Foundation
  - NSDate+LCHelp
  - NSNumber+LCHelp
  - NSObject+LCHelp
  - NSTimer+LCHelp
  - NSString+LCHelp
  - NSData+LCHelp
  - NSDictionary+LCHelp
  - NSArray+LCHelp

- UIKit

  - UIBarButtonItem+LCHelp
  - UIColor+LCHelp
  - UIControl+LCHelp
  - UIImage+LCHelp
  - UIView+LCHelp
  - UIView+LCKeyboardObserver
  - UIScrollView+LCRefresh
  - UIActionSheet+LCHelp
  - UIAlertView+LCHelp
  - UIAlertController+LCHelp

## 使用

### UIView+LCKeyboardObserver

监听view是否被键盘遮挡

```objective-c
UITextField *t = [[UITextField alloc] init];
t.frame = CGRectMake(100, self.view.frame.size.height - 300, 100, 50);
[self.view addSubview:t];
// 添加键盘观察者
[t addKeyboardObserver];
```

### UIScrollView+LCRefresh

根据`UIActivityIndicatorView`实现的简易刷新控件

```objective-c
UITableView *tableView = [[UITableView alloc] init];
// 添加上拉刷新
[tableView addFooterRefreshing:^{
}];
// 开始刷新(显示菊花)
[tableView startFooterRefreshing];
```

结束刷新

```objective-c
[self.tableView endRefreshing];
```

### LCInfiniteScrollView

无限滚动控件

```objective-c
// 创建控件
LCInfiniteScrollView *sv = [[LCInfiniteScrollView alloc] init];
sv.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
sv.delegate = self;
[self.view addSubview:sv];
```

实现代理方法

```objective-c
// 必须实现的代理方法
- (NSInteger)numberOfIndexInInfiniteScrollView:(LCInfiniteScrollView *)infiniteScrollView {
    return self.images.count;
}

- (void)infiniteScrollView:(LCInfiniteScrollView *)infiniteScrollView reusableView:(UIView *)reusableView atIndex:(NSInteger)index {
    ((UIImageView *)reusableView).image = self.images[index];
}

```

默认重用的view为`UIImageView`, 如果需要自定义重用view, 需要实现代理`reusableViewInInfiniteScrollView:`

```objective-c
- (UIView *)reusableViewInInfiniteScrollView:(LCInfiniteScrollView *)infiniteScrollView {
    return [[UIImageView alloc] init];
}
```



## 联系我

有什么问题欢迎大家指出，谢谢！

- 微博： [@刘畅流畅](http://weibo.com/liuchang712)
- Twitter: [@_LiuChang](https://twitter.com/_LiuChang)
