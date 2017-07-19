//
//  YXBaseViewController.m
//  LoginDemo
//
//  Created by Passaction on 2017/7/19.
//  Copyright © 2017年 passaction. All rights reserved.
//

#import "YXBaseViewController.h"

@interface YXBaseViewController ()

@end

@implementation YXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)showErrorMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"错误提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
