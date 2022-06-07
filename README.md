# HLUtils
iOS开发中常用工具类

##### 支持使用CocoaPods引入, Podfile文件中添加:

``` objc
pod 'HLUtils', '1.0.0'
```
HLUtils中全是类方法，导入即用。

基本使用方法:<p>

``` objc
// 获取app版本
+ (NSString *)appVersion;

// 随机颜色
+ (UIColor *)randomColor;

// 获取字符串高度
+ (float)heightForString:(NSString *)value
                    font:(UIFont *)font
                   width:(float)width;

// 获取字符串高度
+ (float)heightForString:(NSString *)value
                    font:(UIFont *)font
                   width:(float)width
             lineSpacing:(CGFloat)lineSpacing;

// 获取字符串宽度
+ (float)widthForString:(NSString *)value
                   font:(UIFont *)font
                 height:(float)height;

//MD5加密
+ (NSString *)md5:(NSString *)str;

// 正则表达式
+ (BOOL)checkContent:(NSString *)content
               regex:(NSString *)regex;

// 空字符串判断
+ (BOOL)isNullOrEmpty:(NSString *)string;

// date 格式化为 string
+ (NSString *)stringFromFomate:(NSDate *)date
                       formate:(NSString *)formate;

// string 格式化为 date
+ (NSDate *)dateFromFomate:(NSString *)datestring
                   formate:(NSString *)formate;

// 时间戳转时间
+ (NSDate *)dateFromTimestamp:(NSNumber *)timestamp;

// 时间戳转指定格式字符串
+ (NSString *)dateStringWithTimestamp:(NSNumber *)timestamp
                              formate:(NSString *)formate;

// 获取keyWindow，兼容iOS13
+ (UIWindow *)getKeyWindow;

// 当前viewController
+ (UIViewController *)topViewController;

// 电话号码中间填充“xxxx”
+ (NSString *)phoneScarf:(NSString *)phone;

// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 拨打电话
+ (void)callPhone:(NSString *)phone;

// #开头颜色获取
+ (UIColor *)colorWithHexString:(NSString *)color;

// 价格格式化
+ (NSString *)priceFormat:(CGFloat)price;

// 电话、身份证格式化 (0.电话 1.身份证)
+ (NSString *)numberFormat:(NSString *)number
                      type:(NSInteger)type;

// 64base字符串转图片
+ (UIImage *)stringToImage:(NSString *)str;

// 安全转换URL（解决url中带中文）
+ (NSURL *)safeURL:(NSString *)url;

// 根据下标获取对应大写字母
+ (NSString *)letterWithIndex:(NSInteger)index;

/**
 *  图片压缩
 *  @param  sourceImage 图片
 *  @param  maxSize     最大尺寸（KB）
 */
+ (NSData *)resetSizeOfImageData:(UIImage *)sourceImage
                         maxSize:(NSInteger)maxSize;

/**
 *  剪裁图片
 *  @param  sourceImage 图片
 *  @param  size        剪裁后尺寸
 *
 */
+ (UIImage *)newSizeImage:(CGSize)size
                    image:(UIImage *)sourceImage;
```

# Requirements

iOS 9.0 +, Xcode 7.0 +

# Version

* 1.0.1 :

  新增图片压缩和剪裁方法

* 1.0.0 :

  完成HLUtils基础搭建

# License
HLNetworkManager is available under the MIT license. See the LICENSE file for more info.
