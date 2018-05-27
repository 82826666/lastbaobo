//
//  AimingSwitchViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/14.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "AimingSwitchViewController.h"

@interface AimingSwitchViewController ()
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIView *backgroudView;
@property(nonatomic, strong) UILabel *topLabel;
@property(nonatomic, strong) UIImageView *dotImageView;
@end

@implementation AimingSwitchViewController

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
    self.title = @"调色灯";
    _backgroudView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, 300, 300)];
    _backgroudView.layer.cornerRadius = 200;
    _backgroudView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_backgroudView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 300, 300)];
    self.image = [UIImage imageNamed:@"color-open"];
    imageView.image = self.image;
    [self.view addSubview:imageView];
    
    _dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 20, 20)];
    _dotImageView.image = [UIImage imageNamed:@"dot"];
    [self.view addSubview:_dotImageView];

    _topLabel = [[function sharedManager] getLabel:CGRectMake(KScreenWidth / 2, imageView.bottom + 50, 80, 30) text:@""];
    [self.view addSubview:_topLabel];
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, _topLabel.bottom + 10, KScreenWidth - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:100];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
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
        [self saveData];
    }else{
        self.image.accessibilityIdentifier = [NSString stringWithFormat:@"%lu",[self colorAtPixel:point]];
    }
    DLog(@"x:%d",x);
    DLog(@"y:%d",y);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    point.x = point.x - 10;
    point.y = point.y - 30;
    _dotImageView.frame = CGRectMake(point.x, point.y, 20, 30);
}
//当有一个或多个手指触摸事件在当前视图或window窗体中响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
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
-(void)saveData{
    CGFloat type = [[_dic objectForKey:@"type"] integerValue];
    CGFloat devid = [[_dic objectForKey:@"devid"] integerValue];
    CGFloat ch = [[_dic objectForKey:@"ch1"] integerValue];
    NSDictionary *cmd;
//    if (btn.tag == 988) {
        cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(1),@"ch":@(ch),@"level":@(_topLabel.tag * 10)};
//    }else if (btn.tag == 989){
//
//    }else if (btn.tag == 990){
//        cmd = @{@"devid":@(devid),@"type":@(type),@"cmd":@"edit",@"value":@(1),@"ch":@(ch),@"level":@(0)};
//    }
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
@end
