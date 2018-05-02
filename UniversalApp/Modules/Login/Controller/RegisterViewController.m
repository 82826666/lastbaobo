//
//  RegisterViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface RegisterViewController ()
@property (strong,nonatomic) NSTimer *verityTimer;
@property (strong,nonatomic) YYLabel *snowBtn;
@end

@implementation RegisterViewController
static int vertifyTime=60;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(_setType == Forget){
        self.title = @"忘记密码";
    }else{
        self.title = @"手机注册";
    }
    [self setupUI];
    // Do any additional setup after loading the view.
}

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    kWeakSelf(self);
    
    UITextField *mobileField = [UITextField new];
    mobileField.frame =CGRectMake(20, 20, KScreenWidth - 2*20, 25);
    mobileField.placeholder = @"请输入手机号";
    UIView *line1 = [self getLine:CGRectMake(20, mobileField.bottom + 10, KScreenWidth - 2*20, 0.5)];
    
    UITextField *passwordField = [UITextField new];
    passwordField.placeholder = @"密码";
    passwordField.frame =CGRectMake(20, line1.bottom + 10, KScreenWidth - 2*20, 25);
    UIView *line2 = [self getLine:CGRectMake(20, passwordField.bottom + 10, KScreenWidth - 2*20, 0.5)];
    
    UITextField *confirmPasswordField = [UITextField new];
    confirmPasswordField.placeholder = @"确认密码";
    confirmPasswordField.frame =CGRectMake(20, line2.bottom + 10, KScreenWidth - 2*20, 25);
    UIView *line3 = [self getLine:CGRectMake(20, confirmPasswordField.bottom + 10, KScreenWidth - 2*20, 0.5)];
    
    UITextField *codeField = [UITextField new];
    codeField.placeholder = @"请输入验证码";
    codeField.frame =CGRectMake(20, line3.bottom + 10, 130, 40);
    UIView *line4 = [self getLine:CGRectMake(20, codeField.bottom + 10, codeField.width - 20, 0.5)];
    _snowBtn = [[YYLabel alloc] initWithFrame:CGRectMake(codeField.right + 3, line3.bottom + 20, KScreenWidth - codeField.width - 20*2, 40)];
    _snowBtn.text = @"获取验证码";
    _snowBtn.font = SYSTEMFONT(20);
    _snowBtn.textColor = KWhiteColor;
    _snowBtn.backgroundColor = KBtnColor;
    _snowBtn.textAlignment = NSTextAlignmentCenter;
    _snowBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _snowBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (vertifyTime==60) {
            _verityTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(verifyTimeAction) userInfo:nil repeats:YES];
            [weakself sendCode:mobileField.text];
        }else{
            [MBProgressHUD showErrorMessage:@"请勿重复发送"];
        }
    };
    
    YYLabel *regBtn = [[YYLabel alloc] initWithFrame:CGRectMake(20, line4.bottom + 30, KScreenWidth - 2*20, 40)];
    if(_setType == Forget){
        regBtn.text = @"重置密码";
    }else{
        regBtn.text = @"注册";
    }
    
    regBtn.font = SYSTEMFONT(20);
    regBtn.textColor = KWhiteColor;
    regBtn.backgroundColor = KBtnColor;
    regBtn.textAlignment = NSTextAlignmentCenter;
    regBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    regBtn.centerX = KScreenWidth/2;
    regBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self doReg:mobileField.text password:passwordField.text confirmPassword:confirmPasswordField.text code:codeField.text];
    };
    
    [self.view addSubview:mobileField];
    [self.view addSubview:line1];
    [self.view addSubview:passwordField];
    [self.view addSubview:line2];
    [self.view addSubview:confirmPasswordField];
    [self.view addSubview:line3];
    [self.view addSubview:codeField];
    [self.view addSubview:_snowBtn];
    [self.view addSubview:line4];
    [self.view addSubview:regBtn];
}

- (void)verifyTimeAction
{
    vertifyTime--;
    if (vertifyTime>0) {
        _snowBtn.text = [NSString stringWithFormat:@"重新获取(%d)秒",vertifyTime];
    }
    else{
        _snowBtn.text = [NSString stringWithFormat:@"重新获取验证码"];
        [_verityTimer invalidate];
        _verityTimer = NULL;
        vertifyTime = 60;
    }
}

-(void)sendCode:(NSString*)mobile{
    NSString *type = @"1";
    if(_setType == Forget){
        type = @"2";
    }
    NSDictionary *parameters = @{@"mobile": mobile, @"type": type};
//    if([[function sharedManager]validateMobile:mobile]){
//        [MBProgressHUD showErrorMessage:@"请输入正确的手机号码"];
//        return ;
//    }
    [[APIManager sharedManager] sendCodeWithParameters:parameters success:^(id data) {
        //请求数据成功
        NSDictionary *datadic = data;
        if ([[datadic objectForKey:@"code"] intValue] != 200) {
            //请求失败
            [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
        }else{
            //请求成功
            [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        //请求数据失败，网络错误
        [MBProgressHUD showErrorMessage:@"服务器异常"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doReg:(NSString *)mobile password:(NSString *)password confirmPassword:(NSString *)confirmPassword code:(NSString*)code{
    if (ValidStr(mobile) == NO) {
        [MBProgressHUD showErrorMessage:@"请输入手机号！"];
        return ;
    }
    if (ValidStr(password) == NO) {
        [MBProgressHUD showErrorMessage:@"请输入密码！"];
        return ;
    }
    if (ValidStr(confirmPassword) == NO) {
        [MBProgressHUD showErrorMessage:@"请输入确认密码！"];
        return ;
    }
    if (ValidStr(code) == NO) {
        [MBProgressHUD showErrorMessage:@"请输入手机验证码！"];
        return ;
    }
    if([password isEqualToString:confirmPassword] == NO){
        [MBProgressHUD showErrorMessage:@"两次密码不一致！"];
        return ;
    }
    NSDictionary *parameters = @{@"mobile": mobile, @"password": [[function sharedManager]md5:password], @"code":code, @"repassword":confirmPassword};
    if(_setType == Forget){//忘记密码
        //等待网络请求
        [[APIManager sharedManager] forgetpwdWithParameters:parameters success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
            if ([[datadic objectForKey:@"code"] intValue] != 200) {
                //请求失败
                [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
                
            }else{
                //请求成功
                [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
            }
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [MBProgressHUD showErrorMessage:@"服务器异常"];
            
        }];
    }else{
        //等待网络请求
        [[APIManager sharedManager] registerWithParameters:parameters success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
            if ([[datadic objectForKey:@"code"] intValue] != 200) {
                //请求失败
                [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
            }else{
                //请求成功
                [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
            }
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [MBProgressHUD showErrorMessage:@"服务器异常"];
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
