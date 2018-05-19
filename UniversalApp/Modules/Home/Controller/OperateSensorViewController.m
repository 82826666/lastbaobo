//
//  OperateSensorViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/9.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "OperateSensorViewController.h"

@interface OperateSensorViewController ()
@property(nonatomic, strong) UILabel *topLabel;
@end

@implementation OperateSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    DLog(@"dic:%@",_dic);
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    
   _topLabel = [[function sharedManager] getLabel:CGRectMake(KScreenWidth / 2, 80, 80, 30) text:@""];
    [self.view addSubview:_topLabel];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 100, KScreenWidth - 2*50, 30)];
    
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
//    [slider addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchCancel];
    [slider setMaximumValue:100];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
    
    CGFloat width = KScreenWidth / 3;
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.tag = 988;
    [openBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    openBtn.frame = CGRectMake(0, slider.bottom + 60, width, 60);
    UIImageView *openImageView = [[function sharedManager] getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_open1"];
    UILabel *openLabel = [[function sharedManager] getLabel:CGRectMake((openBtn.width - 40) / 2, openImageView.bottom + 10, 40, 20) text:@"开启"];
    [openBtn addSubview:openImageView];
    [openBtn addSubview:openLabel];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    stopBtn.tag = 989;
    stopBtn.frame = CGRectMake(openBtn.right, slider.bottom + 60, width, 60);
    UIImageView *stopImageView = [[function sharedManager] getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"color-close"];
    UILabel *stopLabel = [[function sharedManager] getLabel:CGRectMake((stopBtn.width - 40) / 2, stopImageView.bottom + 10, 40, 20) text:@"暂停"];
    [stopBtn addSubview:stopImageView];
    [stopBtn addSubview:stopLabel];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 990;
    [closeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(stopBtn.right, slider.bottom + 60, width, 60);
    UIImageView *closeImageView = [[function sharedManager] getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_close1"];
    UILabel *closeLabel = [[function sharedManager] getLabel:CGRectMake((closeBtn.width - 40) / 2, closeImageView.bottom + 10, 40, 20) text:@"关闭"];
    [closeBtn addSubview:closeImageView];
    [closeBtn addSubview:closeLabel];
    
    [self.view addSubview:openBtn];
    [self.view addSubview:stopBtn];
    [self.view addSubview:closeBtn];
}

-(void)sliderMethod:(UISlider*)slider
{
    NSString *text = @"%";
    NSArray *arr = [[NSString stringWithFormat:@"%f",slider.value] componentsSeparatedByString:@"."];
    _topLabel.text = [NSString stringWithFormat:@"%@%@",[arr objectAtIndex:0],text];
}

-(void)cancle:(UISlider*)slider
{
    DLog(@"sdf");
}

-(void)clickBtn:(UIButton*)btn{
    CGFloat type = [[_dic objectForKey:@"type"] integerValue];
    CGFloat devid = [[_dic objectForKey:@"devid"] integerValue];
    CGFloat ch = [[_dic objectForKey:@"ch1"] integerValue];
    NSDictionary *cmd;
    if (btn.tag == 988) {
        cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(1),@"ch":@(ch),@"level":@(1000)};
    }else if (btn.tag == 989){
        
    }else if (btn.tag == 990){
        cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(1),@"ch":@(ch),@"level":@(0)};
    }
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"device_type":@(type),
                             @"cmd":[cmd jsonStringEncoded]
                             };
    DLog(@"params:%@",params);
    [[APIManager sharedManager]deviceZigbeeCmdsWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        if([[datadic objectForKey:@"code"] intValue] == 200 ){
            if ([[[datadic objectForKey:@"data"] objectForKey:@"status"] integerValue] >= 0) {
                [MBProgressHUD showSuccessMessage:@"发送cmd命令成功"];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"发送cmd命令失败"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"系统发生错误"];
    }];
}

-(void)sendCmd:(NSDictionary*)params{
    [[APIManager sharedManager]deviceZigbeeCmdsWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        if([[datadic objectForKey:@"code"] intValue] == 200 ){
            if ([[[datadic objectForKey:@"data"] objectForKey:@"status"] integerValue] >= 0) {
                [MBProgressHUD showSuccessMessage:@"发送cmd命令成功"];
            }
        }else{
            [MBProgressHUD showErrorMessage:@"发送cmd命令失败"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"系统发生错误"];
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
