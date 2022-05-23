//
//  HLUtils.m
//  HLUtils
//
//  Created by JJB_iOS on 2022/5/23.
//

#import "HLUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HLUtils

// 获取pp版本
+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

// 随机颜色
+ (UIColor *)randomColor
{
    CGFloat red = (CGFloat)(arc4random() % 255)/255.0;
    CGFloat green = (CGFloat)(arc4random() % 255)/255.0;
    CGFloat blue = (CGFloat)(arc4random() % 255)/255.0;
    
    UIColor *color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:0.5];
    return color;
}

// 获取字符串高度
+ (float)heightForString:(NSString *)value
                    font:(UIFont *)font
                   width:(float)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                   options:(NSStringDrawingUsesLineFragmentOrigin |
                                            NSStringDrawingTruncatesLastVisibleLine)
                                attributes:attributes
                                   context:nil].size;
    return ceil(textSize.height);
}

// 获取字符串高度
+ (float)heightForString:(NSString *)value
                    font:(UIFont *)font
                   width:(float)width
             lineSpacing:(CGFloat)lineSpacing
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.lineSpacing  = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                   options:(NSStringDrawingUsesLineFragmentOrigin |
                                            NSStringDrawingTruncatesLastVisibleLine)
                                attributes:attributes
                                   context:nil].size;
    return ceil(textSize.height);
}

// 获取字符串宽度
+ (float)widthForString:(NSString *)value
                   font:(UIFont *)font
                 height:(float)height
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize;
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                   options:(NSStringDrawingUsesLineFragmentOrigin |
                                            NSStringDrawingTruncatesLastVisibleLine)
                                attributes:attributes
                                   context:nil].size;
    return ceil(textSize.width);
}

// md5 加密
+ (NSString *)md5:(NSString *)str
{
    if (!str) return nil;
    
    const char *cStr = str.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
    
}

// 正则表达式
+ (BOOL)checkContent:(NSString *)content regex:(NSString *)regex
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:content];
}

// 空字符串判断
+ (BOOL)isNullOrEmpty:(NSString *)string
{
    return string == nil
    || [string isEqual: (id)[NSNull null]]
    || [string isKindOfClass:[NSString class]] == NO
    || [@"" isEqualToString:string]
    || [[string stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0U
    || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0U;
}

// date 格式化为 string
+ (NSString *)stringFromFomate:(NSDate*)date
                       formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

// string 格式化为 date
+ (NSDate *)dateFromFomate:(NSString *)datestring
                   formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

// 时间戳转时间
+ (NSDate *)dateFromTimestamp:(NSNumber *)timestamp
{
    if ((!timestamp) || (![timestamp isKindOfClass:[NSNumber class]])) {
        return nil;
    }
        
    NSString *timestampString = [NSString stringWithFormat:@"%@", timestamp];
    if (timestampString.length > 11) {
        timestampString = [timestampString substringToIndex:10];
    }
    
    NSTimeInterval time = [timestampString longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return date;
}

// 时间戳转指定格式字符串
+ (NSString *)dateStringWithTimestamp:(NSNumber *)timestamp
                              formate:(NSString *)formate
{
    NSDate *docDate = [HLUtils dateFromTimestamp:timestamp];
    NSString *dateString = [HLUtils stringFromFomate:docDate formate:formate];
    return dateString;
}

// 获取keyWindow，兼容iOS13
+ (UIWindow *)getKeyWindow
{
    if([[[UIApplication sharedApplication] delegate] window]){
        return [[[UIApplication sharedApplication] delegate] window];
    }else {
        if (@available(iOS 13.0,*)) {
            NSArray *arr = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *windowScene =  (UIWindowScene *)arr[0];
            UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if(mainWindow){
                return mainWindow;
            }else{
                return [UIApplication sharedApplication].windows.lastObject;
            }
        } else {
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

// 当前viewController
+ (UIViewController *)topViewController
{
    UIViewController *rootViewController = [HLUtils getKeyWindow].rootViewController;
    return [self topVisibleViewControllerOfViewControlller:rootViewController];
}

+ (UIViewController *)topVisibleViewControllerOfViewControlller:(UIViewController *)vc {
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)vc;
        return [self topVisibleViewControllerOfViewControlller:tabBarController.selectedViewController];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)vc;
        return [self topVisibleViewControllerOfViewControlller:navigationController.visibleViewController];
        
    } else if (vc.presentedViewController) {
        return [self topVisibleViewControllerOfViewControlller:vc.presentedViewController]; }
    else if (vc.childViewControllers.count > 0){
        return [self topVisibleViewControllerOfViewControlller:vc.childViewControllers.lastObject];
        
    }
    return vc;
}

// 电话号码中间填充“xxxx”
+ (NSString *)phoneScarf:(NSString *)phone
{
    if ([HLUtils checkContent:phone regex:REGEX_PHONE]) {
        NSString *numberString = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"xxxx"];
        return numberString;
    }
    return phone;
}

// 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

// 拨打电话
+ (void)callPhone:(NSString *)phone
{
    if ([HLUtils isNullOrEmpty:phone]) {
        return;
    }
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (UIColor *)colorWithHexString:(NSString *)color
{
    if ([HLUtils isNullOrEmpty:color]) {
        return [UIColor blackColor];
    }
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
   
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
   
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
   
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
   
    //r
    NSString *rString = [cString substringWithRange:range];
   
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
   
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
   
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
   
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

// 价格格式化
+ (NSString *)priceFormat:(CGFloat)price
{
    if (price == 0) {
        return @"免费";
    } else {
        return [NSString stringWithFormat:@"¥%.2f", price];
    }
}

// 电话、身份证格式化 (0.电话 1.身份证)
+ (NSString *)numberFormat:(NSString *)number
                      type:(NSInteger)type
{
    if ([self isNullOrEmpty:number]) {
        return @"";
    }
    
    if (type == 0 && (![HLUtils checkContent:number regex:REGEX_PHONE])) {
        return number;
    }
    
    if (type == 1 && (![HLUtils checkContent:number regex:REGEX_ID_CARD])) {
        return number;
    }
    
    NSInteger toIndex = type==0?3:6;
    NSString *str = number;
    NSString *fStr = [number substringToIndex:toIndex];
    NSString *lStr = [number substringFromIndex:number.length-4];
    if (type == 0) {
        str = [NSString stringWithFormat:@"%@***%@", fStr, lStr];
    } else {
        str = [NSString stringWithFormat:@"%@**********%@", fStr, lStr];
    }
    
    return str;
}

// 64base字符串转图片
+ (UIImage *)stringToImage:(NSString *)str
{
    if ([HLUtils isNullOrEmpty:str]) {
        return nil;
    }
    if ([str containsString:@","]) {
        NSArray *arr = [str componentsSeparatedByString:@","];
        str = arr[1];
    }
    
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData ];
    return photo;
}

// 安全转换URL（解决url中带中文）
+ (NSURL *)safeURL:(NSString *)url
{
    if ([HLUtils isNullOrEmpty:url]) {
        url = @"";
    }
    NSURL *rUrl = [NSURL URLWithString:url];
    if (rUrl) {
        return rUrl;
    }
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    return [NSURL URLWithString:url];
}

// 根据下标获取对应大写字母
+ (NSString *)letterWithIndex:(NSInteger)index
{
    NSArray *letterArr = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    if (letterArr.count <= index) {
        return @"Z";
    }
    
    return letterArr[index];
}

@end
