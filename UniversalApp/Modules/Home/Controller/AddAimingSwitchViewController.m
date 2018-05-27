//
//  AddAimingSwitchViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/24.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "AddAimingSwitchViewController.h"
#import <MMAlertView.h>
#import "AlertRoomView.h"

@interface AddAimingSwitchViewController ()<AlertRoomViewDelegate>
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIView *backgroudView;
@property(nonatomic, strong) UILabel *topLabel;
@property(nonatomic, strong) UIImageView *dotImageView;
@property(nonatomic, strong) UILabel *nameDetailLabel;
@property(nonatomic, strong) UILabel *roomDetailLabel;
@property(nonatomic, strong) UISlider *slider;
@property(nonatomic, strong) NSString *devid;
@property(nonatomic, strong) NSMutableDictionary *room;
@property(nonatomic,strong) NSString *saveStatus;
@property(nonatomic, strong) NSString *x;
@property(nonatomic, strong) NSString *y;
@end

@implementation AddAimingSwitchViewController

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
    //添加导航栏按钮
    [self addNavigationItemWithTitles
     :@[@"保存"] isLeft:NO target:self action:@selector(clickBtn:) tags:@[@1000]];
    self.title = @"调色灯";
    _backgroudView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 0, 300)];
    _backgroudView.layer.cornerRadius = 200;
    _backgroudView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_backgroudView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 300, 300)];
    self.image = [UIImage imageNamed:@"color-open"];
    imageView.image = self.image;
    [self.view addSubview:imageView];
    self.x = [NSString stringWithFormat:@"%f",(imageView.left + 60)];
    self.y = [NSString stringWithFormat:@"%f",(imageView.top + 60)];
    
    _topLabel = [[function sharedManager] getLabel:CGRectMake(KScreenWidth / 2, imageView.bottom, 80, 30) text:@""];
    [self.view addSubview:_topLabel];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, _topLabel.bottom + 5, KScreenWidth - 2*50, 30)];
    [_slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [_slider setMaximumValue:100];
    [_slider setMinimumValue:0];
    [_slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:_slider];
    
    UIButton *nameBtn = [[function sharedManager]getBtn:CGRectMake(0, _slider.bottom, KScreenWidth, 50)];
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
        self.x = [dic objectForKey:@"x"];
        self.y = [dic objectForKey:@"y"];
    }
    _dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake([self.x integerValue], [self.y integerValue], 20, 20)];
    _dotImageView.image = [UIImage imageNamed:@"dot"];
    [self.view addSubview:_dotImageView];
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

- (void)roomDidSelect:(NSDictionary*)dic{
    _roomDetailLabel.text = [dic objectForKey:@"name"];
    _roomDetailLabel.accessibilityLabel = [dic objectForKey:@"id"];
}

-(void)clickBtn:(UIButton*)btn{
    CGFloat tag = btn.tag;
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        
    };
    if (tag == 991){
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
        NSString *rgb = self.image.accessibilityIdentifier;
        NSDictionary *dic = @{@"ch":@(1),@"name":_nameDetailLabel.text,@"icon":@(20711),@"status":@(1),@"order":@(1),@"rgb":rgb,@"x":self.x,@"y":self.y,@"level":@([[arr objectAtIndex:0] integerValue] * 10)};
        [setting addObject:dic];
        if (_dic != nil) {
            NSDictionary *params = @{
                                     @"device_id":[_dic objectForKey:@"id"],
                                     @"name":_nameDetailLabel.text,
                                     @"room_id":_roomDetailLabel.accessibilityLabel,
                                     @"setting":[[function sharedManager]formatToJson:setting],
                                     @"icon":@(20711),//[CommonCode getImageType:@"in_equipment_switch_one"]
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
                                     @"type":@"20711",
                                     @"room_id":_roomDetailLabel.accessibilityLabel,
                                     @"setting":[[function sharedManager]formatToJson:setting],
                                     @"icon":@(20711),//[CommonCode getImageType:@"in_equipment_switch_one"]
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

-(void)sliderMethod:(UISlider*)slider
{
    NSString *text = @"%";
    NSArray *arr = [[NSString stringWithFormat:@"%f",slider.value] componentsSeparatedByString:@"."];
    _topLabel.tag = [[arr objectAtIndex:0] integerValue];
    _topLabel.text = [NSString stringWithFormat:@"%@%@",[arr objectAtIndex:0],text];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    point.x = point.x - 10;
    point.y = point.y - 30;
    int x = point.x;
    int y = point.y;
    if((x>83 && x<196) && (y>60 && y < 177)){
//        [self saveData];
    }else{
        self.image.accessibilityIdentifier = [NSString stringWithFormat:@"%lu",[self colorAtPixel:point]];
        self.x = [NSString stringWithFormat:@"%f",point.x];
        self.y = [NSString stringWithFormat:@"%f",point.y];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    point.x = point.x - 10;
    point.y = point.y - 30;
    _dotImageView.frame = CGRectMake(point.x, point.y, 20, 30);
}

//获取图片某一点的颜色
- (unsigned long)colorAtPixel:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.image.size.width, self.image.size.height), point)) {
        return 0;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.image.CGImage;
    NSUInteger width = self.image.size.width;
    NSUInteger height = self.image.size.height;
    DLog(@"width:%ld",width);
    DLog(@"height:%ld",height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    //    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    CGFloat r = (CGFloat)pixelData[0] / 255.0f;
    CGFloat g = (CGFloat)pixelData[1] / 255.0f;
    CGFloat b = (CGFloat)pixelData[2] / 255.0f;
    _backgroudView.backgroundColor = [UIColor colorWithRed:pixelData[0] / 255.0f green:pixelData[1] / 255.0f blue:pixelData[2] / 255.0f alpha:pixelData[3] / 255.0f];
    unsigned long rgb;
    unsigned char red = (unsigned char)[NSString stringWithFormat:@"%f",r];
    unsigned char green  = (unsigned char)[NSString stringWithFormat:@"%f",g];
    unsigned char blue  = (unsigned char)[NSString stringWithFormat:@"%f",b];
    rgb =  (((unsigned long)red<<16) & 0xFF0000) | (((unsigned long)green<<8) & 0x00FF00) | (((unsigned long)blue) & 0x0000FF);
    return rgb;
}
- (BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect {
    CGFloat radius = rect.size.width/2.0;
    CGPoint center = CGPointMake(rect.origin.x + radius, rect.origin.y + radius);
    double dx = fabs(point.x - center.x);
    double dy = fabs(point.y - center.y);
    double dis = hypot(dx, dy);
    return dis <= radius;
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
