//
//  ViewController.m
//  HLUtils
//
//  Created by JJB_iOS on 2022/5/23.
//

#import "ViewController.h"
#import "HLUtils/HLUtils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL isPhone = [HLUtils checkContent:@"15xxxxxxxx7" regex:REGEX_PHONE];
    NSLog(@"是否电话号码:%@", isPhone ? @"YES" : @"NO");
}


@end
