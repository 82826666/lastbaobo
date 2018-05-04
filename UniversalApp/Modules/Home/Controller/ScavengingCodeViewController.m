//
//  ScavengingCodeViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "ScavengingCodeViewController.h"
#import "CodeScanningViewController.h"

@interface ScavengingCodeViewController ()

@end

@implementation ScavengingCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描主机二维码";
    [self setupUI];
    // Do any additional setup after loading the view.
}

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(30, 50, KScreenWidth - 2*30, 150);
    imageView.image = [UIImage imageNamed:@"masterlink"];
    
    YYLabel *tipBtn= [[YYLabel alloc] initWithFrame:CGRectMake(30, imageView.bottom + 80, KScreenWidth - 2*30, 40)];
    tipBtn.text = @"主机接通电源,插入网线,确定主机处于待接入状态扫码主机背面二维码,添加主机";
    tipBtn.numberOfLines = 3;
    tipBtn.font = SYSTEMFONT(10);
    tipBtn.textColor = KGray2Color;
    //    snowBtn4.backgroundColor = [UIColor colorWithRed:32/255.0 green:190/255.0 blue:240/255.0 alpha:1];
    tipBtn.textAlignment = NSTextAlignmentCenter;
    tipBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    tipBtn.centerX = KScreenWidth/2;
    tipBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
    };
    
    YYLabel *scavengingBtn = [[YYLabel alloc] initWithFrame:CGRectMake(0, tipBtn.bottom + 100, 150, 40)];
    scavengingBtn.text = @"扫描主机二维码";
    scavengingBtn.font = SYSTEMFONT(15);
    scavengingBtn.backgroundColor = KBtnColor;
    scavengingBtn.textAlignment = NSTextAlignmentCenter;
    scavengingBtn.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    scavengingBtn.centerX = KScreenWidth/2;
    scavengingBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        CodeScanningViewController *vc = [CodeScanningViewController new];
        [self pushViewController:vc];
    };
    [self.view addSubview:imageView];
    [self.view addSubview:tipBtn];
    [self.view addSubview:scavengingBtn];
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
