

# LCHelper

Extensions to UIKit and Foundation.

## Requirements

- **iOS 8.0+**

## Usage

### UIKit

- **UIView+LCHelp**

```objective-c
@property(nonatomic, assign) CGFloat lc_left;
@property(nonatomic, assign) CGFloat lc_top;
@property(nonatomic, assign) CGFloat lc_right;
@property(nonatomic, assign) CGFloat lc_bottom;
@property(nonatomic, assign) CGFloat lc_width;
@property(nonatomic, assign) CGFloat lc_height;
@property(nonatomic, assign) CGFloat lc_centerX;
@property(nonatomic, assign) CGFloat lc_centerY;
@property(nonatomic, assign) CGPoint lc_origin;
@property(nonatomic, assign) CGSize lc_size;

// 链式编程
- (UIView *(^)(CGFloat top))lc__top;
- (UIView *(^)(CGFloat bottom))lc__bottom;
- (UIView *(^)(CGFloat offset))lc__bottomOffset;
- (UIView *(^)(CGFloat left))lc__left;
- (UIView *(^)(CGFloat right))lc__right;
- (UIView *(^)(CGFloat offset))lc__rightOffset;
- (UIView *(^)(CGFloat width))lc__width;
- (UIView *(^)(CGFloat offset))lc__flexToRightOffset; // width
- (UIView *(^)(CGFloat height))lc__height;
- (UIView *(^)(CGFloat offset))lc__flexToBottomOffset; // height
- (UIView *(^)(CGFloat x))lc__centerX;
- (UIView *(^)(CGFloat y))lc__centerY;
- (UIView *(^)(void))lc__center;
- (UIView *(^)(CGSize size))lc__size;
- (UIView *(^)(CGPoint origin))lc__origin;
- (UIView *(^)(CGFloat w, CGFloat h))lc__sizeToFitLessThan;
```

- **UIColor+LCHelp**

```objective-c
+ (UIColor *)lc_colorWithHex:(NSString *)hexStr; // @"0xF0F", @"66ccff", @"#66CCFF88"
+ (UIColor *)lc_colorWithRGB:(uint32_t)rgbValue;
+ (UIColor *)lc_colorWithRGBA:(uint32_t)rgbaValue;
+ (UIColor *)lc_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;
```

- **UIControl+LCHelp**

```objective-c
- (void)lc_addEventTouchUpInsideBlock:(void (^)(id sender))block;
- (void)lc_addEvents:(UIControlEvents)controlEvents invoke:(void (^)(id sender))block;
- (void)lc_setEvents:(UIControlEvents)controlEvents invoke:(void (^)(id sender))block;
- (void)lc_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)lc_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;
- (void)lc_removeAllTargets;
```

- **UIImage+LCHelp**

```objective-c
/// Captures a new image with a given view.
+ (UIImage *)lc_imageWithCaptureView:(UIView *)view;

/// Returns a new image with a given color.
+ (UIImage *)lc_imageWithColor:(UIColor *)color;

/// Returns a new image with a given color.
+ (UIImage *)lc_imageWithColor:(UIColor *)color size:(CGSize)size;

/// Returns a round image.
- (UIImage *)lc_roundedImage;

/// Returns a round image with a given `borderWidth` and `borderColor`.
- (UIImage *)lc_roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/// Returns a new image which is resized from this image. You can specify a larger or smaller size than the image size. The image content will be changed with the scale mode.
- (UIImage *)lc_resizedImageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/// Returns a new image which is cropped from this image.
- (UIImage *)lc_croppedImageWithRect:(CGRect)rect;

/// Rounds a new image with a given corner radius.
- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius;

/// Rounds a new image with a given corner radius and corners.
- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius
                                     corners:(UIRectCorner)corners
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nullable UIColor *)borderColor;
```

- **UIBarButtonItem+LCHelp**

```objective-c
+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(nullable UIImage *)image
                             highImage:(nullable UIImage *)highImage;

+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                                action:(SEL)action
                                  size:(CGSize)size
                                 image:(nullable UIImage *)image
                             highImage:(nullable UIImage *)highImage;
```

- **UIButton+LCHelp**

```objective-c
typedef NS_ENUM(NSUInteger, LCButtonEdgeInsetsStyle) {
    LCButtonEdgeInsetsStyleTop, // Image Top，Label Bottom
    LCButtonEdgeInsetsStyleLeft, // Image Left，Label Right
    LCButtonEdgeInsetsStyleBottom, // Image Bottom，Label Top
    LCButtonEdgeInsetsStyleRight // Image Right，Label Left
};

@interface UIButton (LCHelp)
- (void)lc_setEdgeInsetsStyle:(LCButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
@end
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
+ (instancetype)lc_alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)lc_alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
```

- **UIActionSheet+LCHelp**

```objective-c
+ (instancetype)lc_actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)lc_actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
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