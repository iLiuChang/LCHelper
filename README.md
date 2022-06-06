

# LCHelper

Extensions to UIKit and Foundation.

## Requirements

- **iOS 8.0+**

## CocoaPods

```objective-c
pod 'LCHelper' 
```
## Usage

### UIKit

- **UIView+LCHelp**

```objective-c
view.lc__left(10).lc__height(20).lc__bottomOffset(-20).lc__flexToRightOffset(-10);
```

- **UIColor+LCHelp**

```objective-c
self.view.backgroundColor = [UIColor lc_colorWithHex:@"#FFFFFF"];
```

- **UIControl+LCHelp**

```objective-c
UIButton *button = [UIButton new];
[button lc_addEventTouchUpInsideBlock:^(id  _Nonnull sender) {
    // to do
}];
```

- **UIImage+LCHelp**

```objective-c
UIImage *newImage = [[UIImage imageNamed:@"xxx"] lc_resizableImageWithSize:CGSizeMake(100, 100)];

UIImage *cornerImage = [[UIImage imageNamed:@"xxx"] lc_imageWithCornerRadius:10];
```

- **UIBarButtonItem+LCHelp**

```objective-c
UIBarButtonItem *item = [UIBarButtonItem lc_itemWithTarget:self action:@selector(tap) size:CGSizeMake(10, 10) image:[UIImage imageNamed:@"xxx"] highImage:nil];
```

- **UIButton+LCHelp**

  Change Image and Label position.

```objective-c
UIButton *button = [UIButton new];
[button lc_setEdgeInsetsStyle:(LCButtonEdgeInsetsStyleBottom) imageTitleSpace:0];
```

- **UIAlertController+LCHelp**

```objective-c
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
[alert lc_addActionWithTitle:@"sure" handler:^(UIAlertAction *action) {

}];
[self presentViewController:alert animated:YES completion:nil];
```

- **UIAlertView+LCHelp**

```objective-c
[[UIAlertView lc_alertWithTitle:@"alert" message:nil buttonIndex:nil buttonTitles:nil, nil] show];
```

- **UIActionSheet+LCHelp**

```objective-c
[[UIActionSheet lc_actionSheetWithTitle:@"alert" buttonIndex:nil cancelButtonTitle:nil otherButtonTitles:nil, nil] showInView:self.view];
```

### Foundation

- **NSDate+LCHelp** 

  Date conversion.

- **NSNumber+LCHelp**

  NSString to NSNumber.

- **NSObject+LCHelp**

  Runtime exchange method.

- **NSTimer+LCHelp**

  GCD timer.

- **NSString+LCHelp**

  String interception/get size, etc.

- **NSData+LCHelp**

  Json and base64 data processing.

- **NSDictionary+LCHelp**

  Data Security Handling.

- **NSArray+LCHelp**

  Data Safe Handling.

- **LCCrypto**

  MD5 and hmac encryption.

## Installation

### CocoaPods

To integrate LCHelper into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'LCHelper'
```

### Manual

1. Download everything in the LCHelper folder;
2. Add (drag and drop) the source files in LCHelper to your project;
3. Import `LCHelper.h`.

## License

LCHelper is provided under the MIT license. See LICENSE file for details.