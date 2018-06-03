//
//  ControlAirViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/30.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "ControlAirViewController.h"
#import "UIButton+CenterImageAndTitle.h"

@interface ControlAirViewController ()

@end

@implementation ControlAirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    UIButton *leftBtn = [[function sharedManager]getBtn:CGRectMake(10, 30, 50, 50) imageName:@"ic_in_tv_on1" title:@"开关"];
    [leftBtn verticalCenterImageAndTitle:30.0f];

    UIButton *rightBtn = [[function sharedManager]getBtn:CGRectMake(KScreenWidth - 60, 30, 50, 50) imageName:@"ic_in_air_pattern1" title:@"模式"];
    [rightBtn verticalCenterImageAndTitle:30.0f];
    
    UIButton *modelBtn = [[function sharedManager]getBtn:CGRectMake(10,leftBtn.bottom + 10, 50, 50) imageName:@"ic_in_air_snow" title:@""];
    modelBtn.centerX = (KScreenWidth / 2) /2 +30;
    UILabel *modelLabel = [[function sharedManager]getLabel:CGRectMake(10, modelBtn.bottom + 5, 80, 20) text:@"模式：制冷"];
    modelLabel.centerX = (KScreenWidth / 2) /2 + 30;
    UILabel *windLabel = [[function sharedManager]getLabel:CGRectMake(10, modelLabel.bottom + 5, 80, 20) text:@"风强：-"];
    windLabel.centerX = (KScreenWidth / 2) /2 + 30;
    UILabel *degreeLabel = [[function sharedManager]getLabel:CGRectMake(modelBtn.right + 100, rightBtn.bottom + 80, 100, 40) text:@"--adsf"];
    degreeLabel.font = SYSTEMFONT(20);
    degreeLabel.centerX = KScreenWidth / 2 + 80;
    
    
    [self.view addSubview:leftBtn];
    [self.view addSubview:rightBtn];
    [self.view addSubview:modelBtn];
    [self.view addSubview:modelLabel];
    [self.view addSubview:windLabel];
    [self.view addSubview:degreeLabel];
    
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
