//
//  YXLoginViewController.m
//  LoginDemo
//
//  Created by Passaction on 2017/7/19.
//  Copyright © 2017年 passaction. All rights reserved.
//

#import "YXLoginViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AVOSCloud/AVOSCloud.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "YXHomeViewController.h"

@interface YXLoginViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation YXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self congfigureInterface];
    [self configureRAC];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)congfigureInterface {
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
    }];
    
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@240);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.logoImageView.mas_bottom).offset(36);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.equalTo(self.usernameTextField);
        make.top.equalTo(self.usernameTextField.mas_bottom).offset(10);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@180);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(30);
    }];
}

- (void)configureRAC {
    [[RACSignal combineLatest:@[self.usernameTextField.rac_textSignal, self.passwordTextField.rac_textSignal] reduce:^id(NSString *username, NSString *password){
        return @(username.length > 0 && password.length > 0);
    }] subscribeNext:^(id x) {
        self.loginButton.enabled = [x boolValue];
    }];
    
    [[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@0);
            make.width.equalTo(@0);
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
    
    [[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIKeyboardWillHideNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(80);
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
   
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"注册中....";
 
        [AVUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (error) {
                [self showErrorMessage:error.localizedDescription];
            } else {
                YXHomeViewController *homeVC = [[YXHomeViewController alloc] init];
                [self.navigationController pushViewController:homeVC animated:YES];
            }
        }];
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - views
- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _logoImageView;
}

- (UITextField *)usernameTextField {
    if (!_usernameTextField) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _usernameTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"Sign In" forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor colorWithRed:108 / 255.0 green:118 / 255.0 blue:206 / 255.0 alpha:1.0];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _loginButton.layer.cornerRadius = 6.0;
        _loginButton.clipsToBounds = YES;
        _loginButton.enabled = NO;
    }
    return _loginButton;
}

@end
