//
//  BrandDeviceViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/27.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "BrandDeviceViewController.h"

@interface BrandDeviceViewController ()

@end

@implementation BrandDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(void)setupUI{
    UILabel *one = [[function sharedManager]getLabel:CGRectMake(10, 30, KScreenWidth - 10*2, 20) text:@"one"];
    UILabel *two = [[function sharedManager]getLabel:CGRectMake(10, one.bottom + 5, KScreenWidth - 10*2, 20) text:@"two"];
    UILabel *three = [[function sharedManager]getLabel:CGRectMake(10, two.bottom + 5, KScreenWidth - 10*2, 20) text:@"three"];
    [self.view addSubview:one];
    [self.view addSubview:two];
    [self.view addSubview:three];
    UIView *line = [self getLine:CGRectMake(10, three.bottom + 20, KScreenWidth - 10*2, 0.5)];
    [self.view addSubview:line];
    UILabel *number = [[function sharedManager]getLabel:CGRectMake(10, line.bottom + 50, KScreenWidth - 10*2, 20) text:@"one"];
    number.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:number];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, number.bottom + 20, KScreenWidth - 10*2, 50);
    button.imageView.image = [UIImage imageNamed:@"dot"];
    UILabel *name = [[function sharedManager]getLabel:CGRectMake(10, button.bottom + 10, KScreenWidth - 10*2, 20) text:@"one"];
    name.textAlignment = NSTextAlignmentCenter;
//    button.centerX = button.centerX;
    [self.view addSubview:button];
    [self.view addSubview:name];
    
}

-(void)loadData{
        NSDictionary *params = @{
                                 @"c":@"l",
                                 @"m":@"none",
                                 @"bid":_bid,
                                 @"appid":@"15108982334949",
                                 @"t":_t,
                                 @"v":@(3),
                                 @"f":@"FE54C5AFFF2BFAE4F690A526F294A122"
                                 };
        [[APIManager sharedManager] getBrandDeviceWithParameters:params success:^(id data) {
            DLog(@"success:%@",data);
        } failure:^(NSError *error) {
            DLog(@"error");
        }];
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
