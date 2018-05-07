//
//  AddDelayedViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/26.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "AddDelayedViewController.h"
#import "AddSceneViewController.h"
#import "KMDatePicker.h"
@interface AddDelayedViewController ()<UITextFieldDelegate,KMDatePickerDelegate>{
    
}
@property (nonatomic, strong) UITextField *txtFCurrent;
@property(nonatomic, strong)UITextField *start_Time;
@property(nonatomic, strong)NSMutableArray *dic;
@property(nonatomic, strong) UIView *v3;
@property(nonatomic, strong) UIView *priceView;
@property(nonatomic, strong) NSMutableArray *priceArr;
@property(nonatomic, strong) KMDatePicker *datePicker;
@end

@implementation AddDelayedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
    [self layoutUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = KScreenWidth;
    CGFloat height = 50;
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(30, 60, width - 2*30, height)];
    
    UILabel *v1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2 - 10, 100, 20)];
    v1Label.text = @"延时时间";
    
    _start_Time = [[UITextField alloc]initWithFrame:CGRectMake(width / 2 - 20, height / 2 - 10, width - v1Label.bounds.size.width, 20)];
    _start_Time.placeholder = @"请输入延时时间";
    
    UIView *v1LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 - 0.5, width - 2*30, 0.5)];
    v1LineView.backgroundColor = [UIColor lightGrayColor];
    [v1 addSubview:v1Label];
    [v1 addSubview:_start_Time];
    [v1 addSubview:v1LineView];
    [self.view addSubview:v1];
    
    _priceView = [[UIView alloc]initWithFrame:CGRectMake(30, 10 + 50 + 50 + 50, width - 2*30, height)];
    UILabel *v3Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 80)];
    v3Label.numberOfLines = 0;
    v3Label.text = @"重复时间";
    [_priceView addSubview:v3Label];
    for (int i = 0; i< 7; i++)
    {
        NSDictionary *dic = [self.dic objectAtIndex:i];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(4*i + 28*i + 40, 20, 28, 45);
        button1.tag = 8888;
        NSString *imgName = @"";
        imgName = @"未选中";
        //        if ([w rangeOfString:num].location == NSNotFound) {
        //
        //        } else {
        //            imgName = @"未选中勾";
        //        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = [UIImage imageNamed:imgName];
        imageView.accessibilityIdentifier = imgName;
        imageView.accessibilityValue = [NSString stringWithFormat:@"%d",i];
        imageView.tag = 9999;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom + 2, button1.width, 20)];
        label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
        //        label.textAlignment = NSTextAlignmentCenter;
        
        [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button1 addSubview:imageView];
        [button1 addSubview:label];
        [_priceView addSubview:button1];
    }
    [self.view addSubview:_priceView];
}

-(void)btnClick:(UIButton*)sender{
    UIView *UIViewBtnGroup = sender.superview;
    UIImageView *imageView;
    for (UIView *view in [UIViewBtnGroup subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            for (UIView *v in btn.subviews) {
                if (v.tag == 9999) {
                    imageView = (UIImageView*)v;
                }
            }
            NSString *imgName = @"未选中";
            btn.accessibilityIdentifier = imgName;
            imageView.accessibilityIdentifier = imgName;
            imageView.image = [UIImage imageNamed:imgName];
        }
    }
    
    NSDictionary *dic = [self.dic objectAtIndex:[imageView.accessibilityValue integerValue]];
    
    NSString *imgName = @"未选中勾";
    sender.accessibilityIdentifier = imgName;
    imageView.accessibilityIdentifier = imgName;
    imageView.image = [UIImage imageNamed:imgName];
    _start_Time.text = [dic objectForKey:@"value"];
    _txtFCurrent.text = [dic objectForKey:@"value"];
}

- (void)layoutUI {
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0.0, 0.0, rect.size.width, 216.0);
    // 时分
    _datePicker = [[KMDatePicker alloc]
                   initWithFrame:rect
                   delegate:self
                   datePickerStyle:KMDatePickerStyleHourSecond];
    _start_Time.inputView = _datePicker;
    _start_Time.delegate = self;
    [self addNavigationItemWithTitles
     :@[@"确定"] isLeft:NO target:self action:@selector(save:) tags:@[@1000]];
}

#pragma mark - KMDatePickerDelegate
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(KMDatePickerDateModel *)datePickerDate {
    NSString *dateStr = [NSString stringWithFormat:@"%@:%@",
                         datePickerDate.hour,
                         datePickerDate.minute
                         ];
    _txtFCurrent.text = dateStr;
}

-(NSMutableArray *)dic{
    if (!_dic)
    {
        NSArray *  arr = @[   @{@"title":@"0.5",@"value":@"00:30"},
                              @{@"title":@"1",@"value":@"01:00"},
                              @{@"title":@"5",@"value":@"05:00"},
                              @{@"title":@"10",@"value":@"10:00"},
                              @{@"title":@"15",@"value":@"15:00"},
                              @{@"title":@"30",@"value":@"30:00"},
                              @{@"title":@"60",@"value":@"60:00"},
                              ];
        
        _dic =[[NSMutableArray alloc]initWithArray:arr];
    }
    return _dic;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _txtFCurrent = textField;
}
- (void) save:(UIButton*)btn{
    NSString *str = _start_Time.text;
    if ([str isEqualToString:@""]) {
        [MBProgressHUD showWarnMessage:@"请选择延时时间"];
        return ;
    }
    NSArray *startTime = [str componentsSeparatedByString:@":"];
    NSInteger time = [[startTime objectAtIndex:0] integerValue] * 60 + [[startTime objectAtIndex:1] integerValue];
    NSDictionary *dic = @{@"type":@"33011",@"value":[NSString stringWithFormat:@"%ld",time]};
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AddSceneViewController class]]) {
            AddSceneViewController *con = (AddSceneViewController*)controller;
            if (_tempDic == nil) {
                _row = -1;
            }
            [con setThenDic:dic row:_row];
            [self pushViewController:con];
//            [self.navigationController popToViewController:con animated:YES];
        }
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
