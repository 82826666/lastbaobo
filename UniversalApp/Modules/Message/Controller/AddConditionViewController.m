//
//  AddConditionViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/24.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "AddConditionViewController.h"
#import "AddSceneViewController.h"
#import "KMDatePicker.h"
#import "DateHelper.h"
#import "NSDate+CalculateDay.h"
#import "UIButton+CenterImageAndTitle.h"
@interface AddConditionViewController ()<UITextFieldDelegate,KMDatePickerDelegate>{
    
}
@property (nonatomic, strong) UITextField *txtFCurrent;
@property(nonatomic, strong)UITextField *start_Time;
@property(nonatomic, strong)UITextField *end_Time;
@property(nonatomic, strong)UISwitch *swt;
@property(nonatomic, strong)NSMutableDictionary *dic;
@property(nonatomic, strong) UIView *v3;
@end

@implementation AddConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
    [self initNav];
    [self layoutUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if (_tempDic != nil) {
        NSArray *value = [_tempDic objectForKey:@"value"];
        NSDictionary *one = [value objectAtIndex:0];
        NSDictionary *two = [value objectAtIndex:1];
        NSString *startTime = [NSString stringWithFormat:@"%@:%@",[one objectForKey:@"h"],[one objectForKey:@"mi"]];
        NSString *endTime = [NSString stringWithFormat:@"%@:%@",[two objectForKey:@"h"],[two objectForKey:@"mi"]];
        _start_Time.text = startTime;
        _end_Time.text = endTime;
    }
}

- (void) initNav{
    self.title = @"触发时间";
    [self addNavigationItemWithTitles
     :@[@"确定"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
}
-(void)naviBtnClick:(UIButton*)btn{
    [self save];
}
- (void) save{
    NSString *str = @"";
    for (UIView *view in _v3.subviews) {
        if (view.tag == 8888) {
            UIImageView *imageView;
            for (UIView *vc in view.subviews) {
                if (vc.tag == 9999) {
                    imageView =  (UIImageView*)vc;
                }
            }
            if ([imageView.accessibilityIdentifier isEqualToString:@"未选中勾"]) {
                str = [NSString stringWithFormat:@"%@%@",str,imageView.accessibilityValue];
            }
        }
    }
    if ([str isEqualToString:@""]) {
        [MBProgressHUD showWarnMessage:@"请选择重复时间"];
        return ;
    }
    if ([_start_Time.text isEqualToString:@""]) {
        [MBProgressHUD showWarnMessage:@"请输入开始时间"];
        return ;
    }
    if ([_end_Time.text isEqualToString:@""]) {
        [MBProgressHUD showWarnMessage:@"请输入结束时间"];
        return ;
    }
    NSArray *startTime = [_start_Time.text componentsSeparatedByString:@":"];
    NSArray *endTime = [_end_Time.text componentsSeparatedByString:@":"];
    CGFloat sh = [[startTime objectAtIndex:0] integerValue];
    CGFloat smi = [[startTime objectAtIndex:1] integerValue];
    CGFloat eh = [[endTime objectAtIndex:0] integerValue];
    CGFloat emi = [[endTime objectAtIndex:1] integerValue];
    NSDictionary *dic = @{@"type":@"33111",@"value":@[
                                  @{@"w":str,@"h":@(sh),@"mi":@(smi)},          @{@"w":str,@"h":@(eh),@"mi":@(emi)},
                                  ]};
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AddSceneViewController class]]) {
            AddSceneViewController *con = (AddSceneViewController*)controller;
            if (_tempDic == nil) {
                _row = -1;
            }
            [con setIfDic:dic row:_row];
            [self pushViewController:con];
//            [self.navigationController popToViewController:con animated:YES];
        }
    }
}
#pragma mark 返回
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)layoutSubviews{
    NSString *w = @"";
    if (_tempDic != nil) {
        NSArray *value = [_tempDic objectForKey:@"value"];
        w = [[value objectAtIndex:0] objectForKey:@"w"];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = KScreenWidth;
    CGFloat height = 50;
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(30, 60, width - 2*30, height)];
    
    UILabel *v1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2 - 10, 100, 20)];
    v1Label.text = @"开始时间";
    
    _start_Time = [[UITextField alloc]initWithFrame:CGRectMake(width / 2 - 20, height / 2 - 10, width - v1Label.bounds.size.width, 20)];
    _start_Time.placeholder = @"开始时间";
    
    UIView *v1LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 - 0.5, width - 2*30, 0.5)];
    v1LineView.backgroundColor = [UIColor lightGrayColor];
    [v1 addSubview:v1Label];
    [v1 addSubview:_start_Time];
    [v1 addSubview:v1LineView];
    [self.view addSubview:v1];
    
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(30, 10 + 50 + 50, width - 2*30, height)];
    
    UILabel *v2Label = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2 - 10, 100, 20)];
    v2Label.text = @"结束时间";
    
    _end_Time = [[UITextField alloc]initWithFrame:CGRectMake(width / 2 - 20, height / 2 - 10, width - v2Label.bounds.size.width - 51, 20)];
    _end_Time.placeholder = @"结束时间";
    
    _swt = [[UISwitch alloc]initWithFrame:CGRectMake(width - 51 - 30*2, height / 2 - 15, 51, 31)];//默认就是51*31
    
    UIView *v2LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 - 0.5, width - 2*30, 0.5)];
    v2LineView.backgroundColor = [UIColor lightGrayColor];
    [v2 addSubview:v2Label];
    [v2 addSubview:_end_Time];
    [v2 addSubview:_swt];
    [v2 addSubview:v2LineView];
    [self.view addSubview:v2];
    
    _v3 = [[UIView alloc]initWithFrame:CGRectMake(30, 10 + 50 + 50 + 50, width - 2*30, height)];
    UILabel *v3Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 80)];
    v3Label.numberOfLines = 0;
    v3Label.text = @"重复时间";
    [_v3 addSubview:v3Label];
    NSDictionary *dic = self.dic;
    for (int i = 0; i< 7; i++)
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(4*i + 28*i + 40, 20, 28, 45);
        button1.tag = 8888;
        NSString *num = [NSString stringWithFormat:@"%d",i];
        NSString *imgName = @"";
        if ([w rangeOfString:num].location == NSNotFound) {
            imgName = @"未选中";
        } else {
            imgName = @"未选中勾";
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = [UIImage imageNamed:imgName];
        imageView.accessibilityIdentifier = imgName;
        imageView.accessibilityValue = i == 6 ? @"0" : [NSString stringWithFormat:@"%d",i+1];
        imageView.tag = 9999;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom + 2, button1.width, 20)];
        label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:[NSString stringWithFormat:@"%d",i]]];
        
        [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button1 addSubview:imageView];
        [button1 addSubview:label];
        [_v3 addSubview:button1];
    }
    UIView *v3LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 80 - 0.5, width - 2*30, 0.5)];
    v3LineView.backgroundColor = [UIColor lightGrayColor];
    [_v3 addSubview:v3LineView];
    [self.view addSubview:_v3];
}
-(void)btnClick:(UIButton*)sender{
    UIImageView *imageView;
    for (UIView *vc in sender.subviews) {
        if (vc.tag == 9999) {
            imageView = (UIImageView*)vc;
        }
    }
    NSString *imgName = @"未选中";
    if ([imageView.accessibilityIdentifier  isEqual: @"未选中"]) {
        imgName = @"未选中勾";
    }
    sender.accessibilityIdentifier = imgName;
    imageView.accessibilityIdentifier = imgName;
    imageView.image = [UIImage imageNamed:imgName];
}
- (void)layoutUI {
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0.0, 0.0, rect.size.width, 216.0);
    // 时分
    KMDatePicker *datePicker = [[KMDatePicker alloc]
                                initWithFrame:rect
                                delegate:self
                                datePickerStyle:KMDatePickerStyleHourMinute];
    _start_Time.inputView = datePicker;
    _start_Time.delegate = self;
    
    // 时分
    datePicker = [[KMDatePicker alloc]
                  initWithFrame:rect
                  delegate:self
                  datePickerStyle:KMDatePickerStyleHourMinute];
    _end_Time.inputView = datePicker;
    _end_Time.delegate = self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _txtFCurrent = textField;
}

#pragma mark - KMDatePickerDelegate
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(KMDatePickerDateModel *)datePickerDate {
    NSString *dateStr = [NSString stringWithFormat:@"%@:%@",
                         datePickerDate.hour,
                         datePickerDate.minute
                         ];
    _txtFCurrent.text = dateStr;
}
#pragma mark - 懒加载
-(NSMutableDictionary*)dic{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
        [_dic setObject:@"一" forKey:@"0"];
        [_dic setObject:@"二" forKey:@"1"];
        [_dic setObject:@"三" forKey:@"2"];
        [_dic setObject:@"四" forKey:@"3"];
        [_dic setObject:@"五" forKey:@"4"];
        [_dic setObject:@"六" forKey:@"5"];
        [_dic setObject:@"日" forKey:@"6"];
    }
    return _dic;
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
