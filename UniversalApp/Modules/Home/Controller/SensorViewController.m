//
//  SensorViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/10.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "SensorViewController.h"
#import <MMAlertView.h>
#import "AlertRoomView.h"
@interface SensorViewController ()<AlertRoomViewDelegate>
@property(nonatomic, strong) UILabel *topLabel;
@property(nonatomic, strong) UILabel *nameDetailLabel;
@property(nonatomic, strong) UILabel *roomDetailLabel;
@property(nonatomic, strong) NSString *devid;
@property(nonatomic, strong) NSMutableDictionary *room;
@property(nonatomic,strong) NSString *saveStatus;
@property(nonatomic, strong) UISlider *slider;
@end

@implementation SensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏按钮
    [self addNavigationItemWithTitles
     :@[@"保存"] isLeft:NO target:self action:@selector(clickBtn:) tags:@[@1000]];
    [self setupUI];
    DLog(@"dic:%@",_dic);
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI{
    _topLabel = [[function sharedManager] getLabel:CGRectMake(KScreenWidth / 2, 80, 80, 30) text:@""];
    [self.view addSubview:_topLabel];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 100, KScreenWidth - 2*50, 30)];
    [_slider setContinuous:YES];
    [_slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
//    [slider addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchCancel];
    [_slider setMaximumValue:100];
    [_slider setMinimumValue:0];
    [_slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:_slider];
    
    CGFloat width = KScreenWidth / 3;
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.tag = 988;
    [openBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    openBtn.frame = CGRectMake(0, _slider.bottom + 60, width, 60);
    UIImageView *openImageView = [[function sharedManager] getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_open1"];
    UILabel *openLabel = [[function sharedManager] getLabel:CGRectMake((openBtn.width - 40) / 2, openImageView.bottom + 10, 40, 20) text:@"开启"];
    [openBtn addSubview:openImageView];
    [openBtn addSubview:openLabel];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    stopBtn.tag = 989;
    stopBtn.frame = CGRectMake(openBtn.right, _slider.bottom + 60, width, 60);
    UIImageView *stopImageView = [[function sharedManager] getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_stop1"];
    UILabel *stopLabel = [[function sharedManager] getLabel:CGRectMake((stopBtn.width - 40) / 2, stopImageView.bottom + 10, 40, 20) text:@"暂停"];
    [stopBtn addSubview:stopImageView];
    [stopBtn addSubview:stopLabel];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 990;
    [closeBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(stopBtn.right, _slider.bottom + 60, width, 60);
    UIImageView *closeImageView = [[function sharedManager] getImageView:CGRectMake((width - 40)/2, 10, 40, 40) imageName:@"in_curtain_close1"];
    UILabel *closeLabel = [[function sharedManager] getLabel:CGRectMake((closeBtn.width - 40) / 2, closeImageView.bottom + 10, 40, 20) text:@"关闭"];
    [closeBtn addSubview:closeImageView];
    [closeBtn addSubview:closeLabel];
    
    
    UIButton *nameBtn = [[function sharedManager]getBtn:CGRectMake(0, 300, KScreenWidth, 50)];
    nameBtn.tag = 991;
    [nameBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line1 = [self getLine:CGRectMake(0, nameBtn.top, KScreenWidth, 0.5)];
    UILabel *nameLabel = [[function sharedManager]getLabel:CGRectMake(20, nameBtn.top + 10, 80, 30) text:@"开关名称"];
    _nameDetailLabel = [[function sharedManager]getLabel:CGRectMake(100, nameBtn.top + 10, KScreenWidth - 100 - 40, 30) text:@""];
    _nameDetailLabel.textAlignment = NSTextAlignmentRight;
    UIImageView *line1ImageView = [[function sharedManager]getImageView:CGRectMake(KScreenWidth - 30, nameBtn.top + 15, 10, 20) imageName:@"in_arrow_right"];
    
    UIButton *roomBtn = [[function sharedManager]getBtn:CGRectMake(0, nameBtn.bottom, KScreenWidth, 50)];
    roomBtn.tag = 992;
    [roomBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line2 = [self getLine:CGRectMake(0, roomBtn.top, KScreenWidth, 0.5)];
    UILabel *roomLabel = [[function sharedManager]getLabel:CGRectMake(20, roomBtn.top + 10, 80, 30) text:@"区域名称"];
    _roomDetailLabel = [[function sharedManager]getLabel:CGRectMake(100, roomBtn.top + 10, KScreenWidth - 100 - 40, 30) text:@""];
    _roomDetailLabel.textAlignment = NSTextAlignmentRight;
    UIImageView *line2ImageView = [[function sharedManager]getImageView:CGRectMake(KScreenWidth - 30, roomBtn.top + 15, 10, 20) imageName:@"in_arrow_right"];
    UIView *line3 = [self getLine:CGRectMake(0, roomBtn.bottom, KScreenWidth, 0.5)];
    
    if (_dic != nil) {
        _nameDetailLabel.text = [_dic objectForKey:@"name"];
        NSString *roomid = [_dic objectForKey:@"room_id"];
        _roomDetailLabel.text = [self.room objectForKey:roomid];
        _roomDetailLabel.accessibilityLabel = [_dic objectForKey:@"room_id"];
        NSArray *setting = [[function sharedManager]stringToJSON:[_dic objectForKey:@"setting"]];
        NSDictionary *dic = [setting objectAtIndex:0];
        CGFloat level = [[dic objectForKey:@"level"] integerValue];
        NSArray *arr = [[NSString stringWithFormat:@"%f",level] componentsSeparatedByString:@"."];
        [_slider setValue:[[arr objectAtIndex:0]integerValue] / 10];
        NSString *ext = @"%";
        _topLabel.text = [NSString stringWithFormat:@"%ld%@",[[arr objectAtIndex:0]integerValue]/10,ext];
    }
    
    [self.view addSubview:openBtn];
    [self.view addSubview:stopBtn];
    [self.view addSubview:closeBtn];
    [self.view addSubview:nameBtn];
    [self.view addSubview:line1];
    [self.view addSubview:nameLabel];
    [self.view addSubview:_nameDetailLabel];
    [self.view addSubview:line1ImageView];
    [self.view addSubview:roomBtn];
    [self.view addSubview:line2];
    [self.view addSubview:roomLabel];
    [self.view addSubview:_roomDetailLabel];
    [self.view addSubview:line2ImageView];
    [self.view addSubview:line3];
}

-(void)sliderMethod:(UISlider*)slider
{
    NSString *text = @"%";
    NSArray *arr = [[NSString stringWithFormat:@"%f",slider.value] componentsSeparatedByString:@"."];
    _topLabel.text = [NSString stringWithFormat:@"%@%@",[arr objectAtIndex:0],text];
}

-(void)clickBtn:(UIButton*)btn{
    CGFloat tag = btn.tag;
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        
    };
    NSDictionary *cmd;
    CGFloat type;
    if (btn.tag == 988) {
        if (_dic == nil) {
            type = 20511;
            cmd = @{@"mac":_mac,@"type":@(20511),@"cmd":@"edit",@"value":@(1),@"ch":@(1),@"level":@(1000)};
        }else{
            type = [[_dic objectForKey:@"type"] integerValue];
            CGFloat devid = [[_dic objectForKey:@"devid"] integerValue];
            CGFloat ch = [[_dic objectForKey:@"ch1"] integerValue];
            cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(1),@"ch":@(ch),@"level":@(1000)};
        }
        NSDictionary *params = @{
                                 @"master_id":GET_USERDEFAULT(MASTER_ID),
                                 @"device_type":@(type),
                                 @"cmd":[cmd jsonStringEncoded]
                                 };
        [self sendCmd:params];
    }else if (btn.tag == 989){
        NSArray *arr = [[NSString stringWithFormat:@"%f",_slider.value] componentsSeparatedByString:@"."];
        CGFloat level = [[arr objectAtIndex:0]integerValue];
        if (_dic == nil) {
            type = 20511;
            cmd = @{@"mac":_mac,@"type":@(20511),@"cmd":@"edit",@"value":@(0),@"ch":@(1),@"level":@(level* 10)};
        }else{
            type = [[_dic objectForKey:@"type"] integerValue];
            CGFloat devid = [[_dic objectForKey:@"devid"] integerValue];
            CGFloat ch = [[_dic objectForKey:@"ch1"] integerValue];
            cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(0),@"ch":@(ch),@"level":@(level * 10)};
        }
        NSDictionary *params = @{
                                 @"master_id":GET_USERDEFAULT(MASTER_ID),
                                 @"device_type":@(type),
                                 @"cmd":[cmd jsonStringEncoded]
                                 };
        [self sendCmd:params];
    }else if (btn.tag == 990){
        if (_dic == nil) {
            type = 20511;
            cmd = @{@"mac":_mac,@"type":@(20511),@"cmd":@"edit",@"value":@(1),@"ch":@(1),@"level":@(0)};
        }else{
            type = [[_dic objectForKey:@"type"] integerValue];
            CGFloat devid = [[_dic objectForKey:@"devid"] integerValue];
            CGFloat ch = [[_dic objectForKey:@"ch1"] integerValue];
            cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(1),@"ch":@(ch),@"level":@(0)};
        }
        NSDictionary *params = @{
                                 @"master_id":GET_USERDEFAULT(MASTER_ID),
                                 @"device_type":@(type),
                                 @"cmd":[cmd jsonStringEncoded]
                                 };
        [self sendCmd:params];
    }else if (tag == 991){
        MMAlertView *alertView = [[MMAlertView alloc] initWithInputTitle:@"开关名称" detail:@"" placeholder:_nameDetailLabel.text handler:^(NSString *text) {
            if(text.length!=0){
                _nameDetailLabel.text = text;
            }
        }];
        alertView.attachedView = self.view;
        alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleExtraLight;
        [alertView showWithBlock:completeBlock];
    }else if (tag == 992){
        AlertRoomView *sheetView = [AlertRoomView new];
        sheetView.delegate = self;
        [sheetView showWithBlock:completeBlock];
    }else if (tag == 1000){
        NSMutableArray *setting = [NSMutableArray new];
        NSArray *arr = [[NSString stringWithFormat:@"%f",_slider.value] componentsSeparatedByString:@"."];
        NSDictionary *dic = @{@"ch":@(1),@"name":_nameDetailLabel.text,@"icon":@(20511),@"status":@(0),@"order":@(1),@"level":@([[arr objectAtIndex:0] integerValue] * 10)};
        [setting addObject:dic];
        if (_dic != nil) {
//            DLog(@"name:%@",_nameDetailLabel.text);
//            DLog(@"room_id:%@",_roomDetailLabel.accessibilityLabel);
            NSDictionary *params = @{
                                     @"device_id":[_dic objectForKey:@"id"],
                                     @"name":_nameDetailLabel.text,
                                     @"room_id":_roomDetailLabel.accessibilityLabel,
                                     @"setting":[[function sharedManager]formatToJson:setting],
                                     @"icon":@(20511),//[CommonCode getImageType:@"in_equipment_switch_one"]
                                     };
            DLog(@"params:%@",params);
            [[APIManager sharedManager]deviceDeviceEditWithParameters:params success:^(id data) {
                NSDictionary *datadic = data;
                if([[datadic objectForKey:@"code"] intValue] == 200){
                    self.saveStatus = @"0";
                    [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
                    [self backBtnClicked];
                }else{
                    self.saveStatus = @"0";
                    [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
                }
            } failure:^(NSError *error) {
                self.saveStatus = @"0";
            }];
        }else{
            NSDictionary *params = @{
                                     @"master_id":GET_USERDEFAULT(MASTER_ID),
                                     @"name":_nameDetailLabel.text,
                                     @"type":@"20511",
                                     @"room_id":_roomDetailLabel.accessibilityLabel,
                                     @"setting":[[function sharedManager]formatToJson:setting],
                                     @"icon":@(20511),//[CommonCode getImageType:@"in_equipment_switch_one"]
                                     @"mac":_mac
                                     };
            [[APIManager sharedManager]deviceDeviceAddWithParameters:params success:^(id data) {
                NSDictionary *datadic = data;
                self.saveStatus = @"0";
                if([[datadic objectForKey:@"code"] intValue] == 200){
                    [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
                    [self backBtnClicked];
                }else{
                    [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
                }
            } failure:^(NSError *error) {
                self.saveStatus = @"0";
                [MBProgressHUD showErrorMessage:@"服务器异常"];
            }];
        }
    }
}

- (void)roomDidSelect:(NSDictionary*)dic{
    _roomDetailLabel.text = [dic objectForKey:@"name"];
    _roomDetailLabel.accessibilityLabel = [dic objectForKey:@"id"];
}

-(void)sendCmd:(NSDictionary*)params{
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


-(void)loadData{
    if (_dic == nil) {
        [[APIManager sharedManager]deviceGetDevidWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
            if ([[data objectForKey:@"code"] integerValue] == 200) {
                _devid = [data objectForKey:@"data"];
            }else{
                [MBProgressHUD showErrorMessage:@"信息获取错误"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showErrorMessage:@"服务器错误"];
        }];
    }
    [[APIManager sharedManager]deviceGetMasterRoomWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"]integerValue] == 200) {
            [self.room removeAllObjects];
            NSArray *room = [dic objectForKey:@"data"];
            for (int i = 0; i < room.count; i ++) {
                NSDictionary *roomOne = [room objectAtIndex:i];
                [self.room setValue:[roomOne objectForKey:@"name"] forKey:[NSString stringWithFormat:@"%@",[roomOne objectForKey:@"id"]]];
            }
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(NSMutableDictionary *)room{
    if (_room == nil) {
        _room = [NSMutableDictionary new];
    }
    return _room;
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
