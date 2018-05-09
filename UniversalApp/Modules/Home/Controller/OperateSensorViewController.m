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
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    
   _topLabel = [self getLabel:CGRectMake(KScreenWidth / 2, 80, 80, 30) text:@""];
    [self.view addSubview:_topLabel];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 100, KScreenWidth - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:100];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
    
    CGFloat width = KScreenWidth / 3;
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.tag = 988;
    openBtn.frame = CGRectMake(0, slider.bottom + 60, width, 60);
    UIImageView *openImageView = [self getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_open1"];
    UILabel *openLabel = [self getLabel:CGRectMake((openBtn.width - 40) / 2, openImageView.bottom + 10, 40, 20) text:@"开启"];
    [openBtn addSubview:openImageView];
    [openBtn addSubview:openLabel];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.tag = 989;
    stopBtn.frame = CGRectMake(openBtn.right, slider.bottom + 60, width, 60);
    UIImageView *stopImageView = [self getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_stop1"];
    UILabel *stopLabel = [self getLabel:CGRectMake((stopBtn.width - 40) / 2, stopImageView.bottom + 10, 40, 20) text:@"暂停"];
    [stopBtn addSubview:stopImageView];
    [stopBtn addSubview:stopLabel];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.tag = 990;
    [closeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(stopBtn.right, slider.bottom + 60, width, 60);
    UIImageView *closeImageView = [self getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_close1"];
    UILabel *closeLabel = [self getLabel:CGRectMake((closeBtn.width - 40) / 2, closeImageView.bottom + 10, 40, 20) text:@"关闭"];
    [closeBtn addSubview:closeImageView];
    [closeBtn addSubview:closeLabel];
    
    [self.view addSubview:openBtn];
    [self.view addSubview:stopBtn];
    [self.view addSubview:closeBtn];
}

-(void)sliderMethod:(UISlider*)slider
{
    DLog(@"vale:%f",slider.value);
    NSString *text = @"%";
    _topLabel.text = [NSString stringWithFormat:@"%f%@",slider.value,text];
}

-(void)clickBtn:(UIButton*)btn{
    CGFloat type = [[_dic objectForKey:@"type"] integerValue];
    CGFloat devid = [[_dic objectForKey:@"devid"] integerValue];
    CGFloat ch = [[_dic objectForKey:@"ch1"] integerValue];
    NSDictionary *params = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@"",@"ch":@(ch)};
    if (btn.tag == 988) {
        
    }else if (btn.tag == 989){
        
    }else if (btn.tag == 990){
        
    }
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

-(UIImageView *)getImageView:(CGRect)rect imageName:(NSString*)imageName{
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.frame = rect;
    return imageView;
}

-(UILabel*)getLabel:(CGRect)rect text:(NSString*)text{
    UILabel *label = [UILabel new];
    label.text = text;
    label.frame = rect;
    return label;
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
