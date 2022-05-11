# LCHelper
常用分类

## 环境

- iOS 8.0+

## CocoaPods

```objective-c
pod 'LCHelper' 
```
## 使用

### UIView+LCHelp

链式调用

```objective-c
view.lc__left(10).lc__height(20).lc__bottomOffset(-20).lc__flexToRightOffset(-10);
```

### UIView+LCKeyboardObserver

监听输入框是否被键盘遮挡

```objective-c
UITextField *t = [[UITextField alloc] init];
t.frame = CGRectMake(100, self.view.frame.size.height - 300, 100, 50);
[self.view addSubview:t];
// 添加键盘观察者
[self.view lc_addKeyboardObserver];
```

### UIScrollView+LCRefresh

简易刷新控件(支持水平和垂直滚动刷新)

```objective-c
UITableView *tableView = [[UITableView alloc] init];
// 添加上拉刷新
[tableView lc_addFooterRefreshingWithActionHandler:^{
}];
// 开始刷新
[tableView lc_beginFooterRefreshing];
```

结束刷新

```objective-c
[self.tableView lc_endRefreshing];
```

## 全部分类目录

#### Foundation

- NSDate+LCHelp (日期转换)

- NSNumber+LCHelp (NSString转NSNumber)

- NSObject+LCHelp (runtime交换方法)

- NSTimer+LCHelp (GCD定时器)
- NSString+LCHelp (字符串截取/获取大小等)

- NSData+LCHelp (json和base64数据处理)

- NSDictionary+LCHelp (数据安全处理)

- NSArray+LCHelp (数据安全处理)

- LCCrypto (md5和hmac加密)

#### UIKit

- UIBarButtonItem+LCHelp

- UIColor+LCHelp (hex色值)

- UIControl+LCHelp (支持闭包事件)

- UIImage+LCHelp (图片剪切)

- UIView+LCHelp (支持链式调用)

- UIView+LCKeyboardObserver (输入框位置检测)

- UIScrollView+LCRefresh (上拉和下拉刷新)

- UIActionSheet+LCHelp

- UIAlertView+LCHelp

- UIAlertController+LCHelp

- UIButton+LCHelp (改变Image和Label位置)

