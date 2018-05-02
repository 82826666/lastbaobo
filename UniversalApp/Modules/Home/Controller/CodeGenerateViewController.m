//
//  CodeGenerateViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "CodeGenerateViewController.h"
#import <SGQRCode.h>
@interface CodeGenerateViewController ()

@end

@implementation CodeGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码生成";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.87 alpha:1.0];
    
    // 生成二维码(Default)
    //    [self setupGenerateQRCode];
    
    // 生成二维码(中间带有图标)
    [self setupGenerate_Icon_QRCode];
    
    // 生成二维码(彩色)
    //    [self setupGenerate_Color_QRCode];
    
}

// 生成二维码
- (void)setupGenerateQRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 80;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    // 2、将CIImage转换成UIImage，并放大显示
    imageView.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"https://github.com/kingsic" imageViewWidth:imageViewW];
    
#pragma mark - - - 模仿支付宝二维码样式（添加用户头像）
    CGFloat scale = 0.22;
    CGFloat borderW = 5;
    UIView *borderView = [[UIView alloc] init];
    CGFloat borderViewW = imageViewW * scale;
    CGFloat borderViewH = imageViewH * scale;
    CGFloat borderViewX = 0.5 * (imageViewW - borderViewW);
    CGFloat borderViewY = 0.5 * (imageViewH - borderViewH);
    borderView.frame = CGRectMake(borderViewX, borderViewY, borderViewW, borderViewH);
    borderView.layer.borderWidth = borderW;
    borderView.layer.borderColor = [UIColor purpleColor].CGColor;
    borderView.layer.cornerRadius = 10;
    borderView.layer.masksToBounds = YES;
    borderView.layer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    
    //[imageView addSubview:borderView];
}

#pragma mark - - - 中间带有图标二维码生成
- (void)setupGenerate_Icon_QRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
//    CGFloat imageViewW = 150;
//    CGFloat imageViewH = imageViewW;
//    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
//    CGFloat imageViewY = ;
//    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.frame = CGRectMake(0, 0, 150, 150);
    imageView.centerX = self.view.centerX;
    imageView.centerY = self.view.centerY - 75;
    [self.view addSubview:imageView];
    
    CGFloat scale = 0.2;
    // 2、将最终合得的图片显示在UIImageView上
    [[APIManager sharedManager]deviceGetShareCodeWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"] integerValue] == 200) {
            imageView.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:[dic objectForKey:@"data"] logoImageName:@"logo" logoScaleToSuperView:scale];
        }else{
            [MBProgressHUD showErrorMessage:[dic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"服务器异常"];
    }];
}

#pragma mark - - - 彩色图标二维码生成
- (void)setupGenerate_Color_QRCode {
    
    // 1、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 150;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = (self.view.frame.size.width - imageViewW) / 2;
    CGFloat imageViewY = 400;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:imageView];
    
    // 2、将二维码显示在UIImageView上
    imageView.image = [SGQRCodeGenerateManager generateWithColorQRCodeData:@"https://github.com/kingsic" backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8] mainColor:[CIColor colorWithRed:0.3 green:0.2 blue:0.4]];
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
