//
//  BrandDeviceViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/27.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "BrandDeviceViewController.h"
#import "AlertRoomView.h"
#import <MMSheetView.h>
#import "RfDevicesViewController.h"
@interface BrandDeviceViewController ()<AlertRoomViewDelegate>
@property(nonatomic, strong) NSString *devid;
@property(nonatomic,strong) UILabel *number;
@property(nonatomic, strong) NSMutableArray *rs;
@property(nonatomic, strong) NSString *sm;
@property(nonatomic, strong) NSString *code;
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
//房间delegate
-(void)roomDidSelect:(NSDictionary *)dic{
    NSString *deviceId = [_dic objectForKey:@"devid"];
    NSString *name = [_dic objectForKey:@"name"];
    NSString *icon = [_dic objectForKey:@"type"];
    NSDictionary *params = @{
                             @"device_id":deviceId,
                             @"type":[_dic objectForKey:@"type"],
                             @"dataid":_devid,
                             @"name":name,
                             @"room_id":[dic objectForKey:@"id"],
                             @"icon":icon,
                             @"code":_code,
                             @"setting":@""
                             };
    DLog(@"params:%@",params);
    [[APIManager sharedManager] deviceDeviceEditRfDeviceWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        if([[datadic objectForKey:@"code"] intValue] == 200 ){
            [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
            RfDevicesViewController *vc = [RfDevicesViewController new];
            [self pushViewController:vc];
        }else{
            [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        DLog(@"error:%@",error);
    }];
}

-(void)setupUI{
    UILabel *one = [[function sharedManager]getLabel:CGRectMake(10, 30, KScreenWidth - 10*2, 20) text:@"1.请将红外设备对准您的空调"];
    UILabel *two = [[function sharedManager]getLabel:CGRectMake(10, one.bottom + 5, KScreenWidth - 10*2, 20) text:@"2.点击按钮发送红外指令"];
    UILabel *three = [[function sharedManager]getLabel:CGRectMake(10, two.bottom + 5, KScreenWidth - 10*2, 20) text:@"3.选择响应结果"];
    [self.view addSubview:one];
    [self.view addSubview:two];
    [self.view addSubview:three];
    UIView *line = [self getLine:CGRectMake(10, three.bottom + 20, KScreenWidth - 10*2, 0.5)];
    [self.view addSubview:line];
    _number = [[UILabel alloc]initWithFrame:CGRectMake(10, line.bottom + 50, KScreenWidth - 10*2, 20)];
    _number.text = @"one";
    _number.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_number];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(KScreenWidth/2 - 25, _number.bottom + 20, 50, 50);
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_in_tv_on1"]];
    imageView.frame = CGRectMake(KScreenWidth/2 - 25, button.top, 50, 50);
    UILabel *name = [[function sharedManager]getLabel:CGRectMake(10, button.bottom + 10, KScreenWidth - 10*2, 20) text:@"开关"];
    name.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:imageView];
    [self.view addSubview:button];
    [self.view addSubview:name];
    
}

-(void)click:(UIButton*)btn{
    NSDictionary *dic = [self.rs objectAtIndex:0];
    NSString *src = [[[dic objectForKey:@"rc_command"] objectForKey:@"on"]objectForKey:@"src"];
    NSDictionary *cmd = @{
                          @"cmd":@"send_data",
                          @"type":@(22111),
                          @"devid":@(7),
                          @"value":src,
                          @"ch":@(1)
                          };
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"device_type":@(22111),
                             @"cmd":[cmd jsonStringEncoded]
                             };
    NSString *rid = [dic objectForKey:@"rid"];
    DLog(@"params:%@",params);
    [[APIManager sharedManager]deviceZigbeeCmdsWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        if([[datadic objectForKey:@"code"] intValue] == 200 ){
            MMPopupItemHandler block = ^(NSInteger index){
                if (index == 0) {
                    NSDictionary *params = @{
                                             @"c":@"d",
                                             @"m":@"none",
                                             @"r":rid,
                                             @"appid":@"15108982334949",
                                             @"f":@"FE54C5AFFF2BFAE4F690A526F294A122"
                                             };
                    [[APIManager sharedManager]getAllDeviceWithParameters:params success:^(id data) {
                        NSString *str = data;
                        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
                        
                        str = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
                        MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
                            //        NSLog(@"animation complete");
                        };
                        _code = [str stringByReplacingOccurrencesOfString:@"]" withString:@""];
                        AlertRoomView *sheetView = [AlertRoomView new];
                        sheetView.delegate = self;
                        [sheetView showWithBlock:completeBlock];
                    } failure:^(NSError *error) {
                        
                    }];
                }
            };

            MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
                NSLog(@"animation complete");
            };
            NSArray *items =
            @[MMItemMake(@"有响应", MMItemTypeNormal, block),
              MMItemMake(@"无响应", MMItemTypeNormal, block)];

            MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"设备开关/关机了吗？"
                                                                  items:items];
            sheetView.attachedView = self.view;
            [sheetView showWithBlock:completeBlock];
//            if ([[[datadic objectForKey:@"data"] objectForKey:@"status"] integerValue] >= 0) {
                [MBProgressHUD showSuccessMessage:@"发送cmd命令成功"];
//            }
        }else{
            [MBProgressHUD showErrorMessage:@"发送cmd命令失败"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"系统发生错误"];
    }];
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
            NSArray *dt = [[function sharedManager]stringToJSON:data];
            NSDictionary *rs = [dt objectAtIndex:0];
            self.rs = [rs objectForKey:@"rs"];
            _sm = [rs objectForKey:@"sm"];
        } failure:^(NSError *error) {
            DLog(@"error");
        }];
    [[APIManager sharedManager]deviceGetDevidWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        DLog(@"data:%@",data);
        if ([[data objectForKey:@"code"] integerValue] == 200) {
            _devid = [data objectForKey:@"data"][0];
        }else{
            [MBProgressHUD showErrorMessage:@"信息获取错误"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"服务器错误"];
    }];
}

-(NSMutableArray*)rs{
    if (_rs == nil) {
        _rs = [NSMutableArray new];
    }
    return _rs;
}

-(void)initData{
    _number.text = @"testsdaf";
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
