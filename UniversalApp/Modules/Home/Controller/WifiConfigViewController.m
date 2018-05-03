//
//  WifiConfigViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "WifiConfigViewController.h"

@interface WifiConfigViewController ()

@end

@implementation WifiConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WIFI配置";
    [self setupUI];
    // Do any additional setup after loading the view.
}

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
//    kWeakSelf(self);
    
    UITextField *mobileField = [UITextField new];
    mobileField.frame =CGRectMake(20, 30, KScreenWidth - 2*20, 35);
    mobileField.placeholder = @"请输入手机号";
    [mobileField setBorderStyle:UITextBorderStyleRoundedRect];
    mobileField.layer.borderColor = [[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1] CGColor];
    mobileField.layer.borderWidth = 0.5f;
    mobileField.layer.cornerRadius = 5.0f;
    
    UITextField *passwordField = [UITextField new];
    passwordField.placeholder = @"密码";
    passwordField.frame =CGRectMake(20, mobileField.bottom + 30, KScreenWidth - 2*20, 35);
    [passwordField setBorderStyle:UITextBorderStyleRoundedRect];
    passwordField.layer.borderColor = [[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1] CGColor];
    passwordField.layer.borderWidth = 0.5f;
    passwordField.layer.cornerRadius = 5.0f;
    
    YYLabel *regBtn = [[YYLabel alloc] initWithFrame:CGRectMake(20, passwordField.bottom + 30, KScreenWidth - 2*20, 40)];
    regBtn.text = @"开始配置";
    regBtn.font = SYSTEMFONT(20);
    regBtn.textColor = KWhiteColor;
    regBtn.backgroundColor = KBtnColor;
    regBtn.textAlignment = NSTextAlignmentCenter;
    regBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    regBtn.centerX = KScreenWidth/2;
    regBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    };
    [self.view addSubview:mobileField];
    [self.view addSubview:passwordField];
    [self.view addSubview:regBtn];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
