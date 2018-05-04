//
//  AccountLoginViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/4/30.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "AccountLoginViewController.h"
#import "RegisterViewController.h"

@interface AccountLoginViewController ()

@end

@implementation AccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    [self setupUI];
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(0, KScreenHeight/5, 105, 105);
    imageView.image = [UIImage imageNamed:@"in_login_newlogo"];
    imageView.centerX = self.view.centerX;
    
    UIImageView *people = [UIImageView new];
    people.frame = CGRectMake(20, imageView.bottom + 20, 21, 25);
    people.image = [UIImage imageNamed:@"in_login_people"];
    UITextField *peopleField = [UITextField new];
    peopleField.frame =CGRectMake(people.right + 5, imageView.bottom + 20, KScreenWidth - people.right - 2*20, 25);
    peopleField.placeholder = @"请输入注册的手机号";
    peopleField.keyboardType = UIKeyboardTypeNumberPad;
    UIView *line1 = [self getLine:CGRectMake(20, people.bottom + 5, KScreenWidth - 2*20, 0.5)];
    
    
    UIImageView *lock = [UIImageView new];
    lock.frame = CGRectMake(20, line1.bottom + 10, 21, 25);
    lock.image = [UIImage imageNamed:@"in_login_lock"];
    UITextField *lockField = [UITextField new];
    lockField.placeholder = @"请输入注册时的密码";
    lockField.secureTextEntry = YES;
    lockField.frame =CGRectMake(lock.right + 5, line1.bottom + 10, KScreenWidth - lock.right - 2*20, 25);
    UIView *line2 = [self getLine:CGRectMake(20, lock.bottom + 5, KScreenWidth - 2*20, 0.5)];
    
    
    
    YYLabel *snowBtn = [[YYLabel alloc] initWithFrame:CGRectMake(20, line2.bottom + 20, KScreenWidth - 2*20, 40)];
    snowBtn.text = @"登录";
    snowBtn.font = SYSTEMFONT(20);
    snowBtn.textColor = KWhiteColor;
    snowBtn.backgroundColor = KBtnColor;
    snowBtn.textAlignment = NSTextAlignmentCenter;
    snowBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    snowBtn.centerX = KScreenWidth/2;
    kWeakSelf(self);
    snowBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakself AccountLogin:peopleField.text password:lockField.text];
    };
    
    YYLabel *snowBtn2 = [[YYLabel alloc] initWithFrame:CGRectMake(snowBtn.left, snowBtn.bottom, 60, 40)];
    snowBtn2.text = @"新用户";
    snowBtn2.font = SYSTEMFONT(10);
    snowBtn2.textColor = KGrayColor;
    snowBtn2.textAlignment = NSTextAlignmentLeft;
    snowBtn2.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        RegisterViewController * reg = [RegisterViewController new];
        reg.setType = Register;
        [self pushViewController:reg];
    };
    
    YYLabel *snowBtn3 = [[YYLabel alloc] initWithFrame:CGRectMake(snowBtn.right - 80, snowBtn.bottom, 80, 40)];
    snowBtn3.text = @"忘记密码";
    snowBtn3.font = SYSTEMFONT(10);
    snowBtn3.textColor = KGrayColor;
        snowBtn3.textAlignment = NSTextAlignmentRight;
    snowBtn3.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        RegisterViewController * forget = [RegisterViewController new];
        forget.setType = Forget;
        [self pushViewController:forget];
    };
    
    YYLabel *snowBtn4 = [[YYLabel alloc] initWithFrame:CGRectMake(20, snowBtn3.bottom + 50, KScreenWidth - 2*20, 40)];
    snowBtn4.text = @"Corpight@2017-2018@baobo";
    snowBtn4.font = SYSTEMFONT(10);
    snowBtn4.textColor = KGray2Color;
//    snowBtn4.backgroundColor = [UIColor colorWithRed:32/255.0 green:190/255.0 blue:240/255.0 alpha:1];
    snowBtn4.textAlignment = NSTextAlignmentCenter;
    snowBtn4.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    snowBtn4.centerX = KScreenWidth/2;
    snowBtn4.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //        [MBProgressHUD showTopTipMessage:NSStringFormat(@"%@马上开始",str) isWindow:YES];
        //        [weakself WXLogin];
    };
    
    [self.view addSubview:imageView];
    [self.view addSubview:people];
    [self.view addSubview:peopleField];
    [self.view addSubview:line1];
    [self.view addSubview:lock];
    [self.view addSubview:lockField];
    [self.view addSubview:line2];
    [self.view addSubview:snowBtn];
    [self.view addSubview:snowBtn2];
    [self.view addSubview:snowBtn3];
    [self.view addSubview:snowBtn4];
}

-(void)AccountLogin:(NSString *)mobile password:(NSString *)password{
    NSDictionary *params = @{@"mobile":mobile,@"password":[[function sharedManager]md5:password],@"clientType":@(2)};
    [[UserManager sharedUserManager]login:kUserLoginTypePwd params:params completion:^(BOOL success, NSString *des) {
        if (success == NO) {
            [MBProgressHUD showErrorMessage:des];
        }else{
            [MBProgressHUD showSuccessMessage:des];
            KPostNotification(KNotificationLoginStateChange, @YES);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
