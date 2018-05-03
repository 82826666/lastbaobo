//
//  UsualViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/2.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "UsualViewController.h"
#import <JMDropMenu.h>
#import <MJExtension.h>
#import "CodeGenerateViewController.h"
#import <MMAlertView.h>
//#import "AlertView.h"
#import "ScavengingCodeViewController.h"
#import "WifiConfigViewController.h"
#import "TwoWayViewController.h"
static NSString *identifier = @"cellID";
static NSString *headerReuseIdentifier = @"hearderID";
NS_ENUM(NSInteger,cellState){
    
    //右上角编辑按钮的两种状态；
    //正常的状态，按钮显示“编辑”;
    NormalState,
    //正在删除时候的状态，按钮显示“完成”；
    DeleteState
    
};
@interface UsualViewController ()<JMDropMenuDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (assign, nonatomic) NSDictionary* result;
@property (nonatomic, strong) YYLabel *cityBtn;
@property (nonatomic, strong) YYLabel *temperatureBtn;
@property (nonatomic, strong) YYLabel *weatherBtn;
@property (nonatomic, strong) YYLabel *bar44Btn;
@property (nonatomic, strong) YYLabel *bar33Btn;
@property (nonatomic, strong) YYLabel *bar22Btn;
@property (nonatomic, strong) YYLabel *bar11Btn;
@property (nonatomic, strong) YYLabel *bar1Btn;
@property (nonatomic, strong) YYLabel *currentHostLabel;
@property(nonatomic,assign) enum cellState;
@property(nonatomic, strong) NSMutableArray *sensorArr;//情景
@property(nonatomic, strong) NSMutableArray *deviceArr;//设备
//添加更多设备标题数组
@property (strong,nonatomic) NSMutableArray *moreEquipmentTitleArray;
//添加更多设备图片数组
@property (strong,nonatomic) NSMutableArray *moreEquipmentImgArray;
//主机名称数据
@property (strong,nonatomic) NSMutableArray *hostsArray;
@end

@implementation UsualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHidenNaviBar = YES;
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //最小item间距（默认是10）
    flow.minimumInteritemSpacing = 0;
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 55);
    self.collectionView.collectionViewLayout = flow;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //注册header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return self.sensorArr.count > 0 ? self.sensorArr.count : 0;
    }else if (section == 2){
        return self.deviceArr.count > 0 ? self.deviceArr.count : 0;
    }
    return 1;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    if (indexPath.section == 0) {
        UIColor *color = [UIColor colorWithRed:47.0f/255.0f green:190.0f/255.0f blue:221.0f/255.0f alpha:1];
        
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 00)];
//        view.backgroundColor = color;
//        [cell.contentView addSubview:view];
        CGFloat fontSize = 12;
        UIColor *textColor = [UIColor whiteColor];
        
        _currentHostLabel = [[YYLabel alloc] initWithFrame:CGRectMake(10, 25, 150, 30)];
        _currentHostLabel.text = @"主机";
        _currentHostLabel.font = [UIFont systemFontOfSize:fontSize];
        _currentHostLabel.textColor = textColor;
        _currentHostLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//            [self changeHost];
        };
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(KScreenWidth - 50, 25, 30, 30);
        [moreBtn setImage:[UIImage imageNamed:@"in_common_head_more"] forState:UIControlStateNormal];
        moreBtn.tag = 999;
        [moreBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        _cityBtn = [[YYLabel alloc] initWithFrame:CGRectMake(10, _currentHostLabel.bottom, 60, 20)];
        _cityBtn.text = @"福州";
        _cityBtn.font = [UIFont systemFontOfSize:fontSize];
        _cityBtn.textColor = textColor;
        _cityBtn.textAlignment = NSTextAlignmentCenter;
        
        _temperatureBtn = [[YYLabel alloc] initWithFrame:CGRectMake(10, _cityBtn.bottom, 60, 30)];
        _temperatureBtn.text = @"13%";
        _temperatureBtn.textColor = textColor;
        _temperatureBtn.textAlignment = NSTextAlignmentCenter;
        
        _weatherBtn = [[YYLabel alloc] initWithFrame:CGRectMake(10, _temperatureBtn.bottom, 60, 20)];
        _weatherBtn.text = @"情|空气良";
        _weatherBtn.font = [UIFont systemFontOfSize:fontSize];
        _weatherBtn.textColor = textColor;
        _weatherBtn.textAlignment = NSTextAlignmentCenter;
        
        YYLabel *bar4Btn = [[YYLabel alloc] initWithFrame:CGRectMake(KScreenWidth - 85, _weatherBtn.bottom + 10, 80, 20)];
        bar4Btn.text = @"室内温度";
        bar4Btn.font = [UIFont systemFontOfSize:fontSize];
        bar4Btn.textColor = textColor;
        bar4Btn.textAlignment = NSTextAlignmentCenter;
        
        YYLabel *bar3Btn = [[YYLabel alloc] initWithFrame:CGRectMake(bar4Btn.left - 70, _weatherBtn.bottom + 10, 80, 20)];
        bar3Btn.text = @"PM2.5";
        bar3Btn.font = [UIFont systemFontOfSize:fontSize];
        bar3Btn.textColor = textColor;
        bar3Btn.textAlignment = NSTextAlignmentCenter;
        
        YYLabel *bar2Btn = [[YYLabel alloc] initWithFrame:CGRectMake(bar3Btn.left - 50, _weatherBtn.bottom + 10, 80, 20)];
        bar2Btn.text = @"温度";
        bar2Btn.font = [UIFont systemFontOfSize:fontSize];
        bar2Btn.textColor = textColor;
        bar2Btn.textAlignment = NSTextAlignmentCenter;
        
        _bar1Btn = [[YYLabel alloc] initWithFrame:CGRectMake(bar2Btn.left - 50, _weatherBtn.bottom + 10, 80, 20)];
        _bar1Btn.text = @"东南风";
        _bar1Btn.font = [UIFont systemFontOfSize:fontSize];
        _bar1Btn.textColor = textColor;
        _bar1Btn.textAlignment = NSTextAlignmentCenter;
        
        _bar44Btn = [[YYLabel alloc] initWithFrame:CGRectMake(KScreenWidth - 85, _bar1Btn.bottom + 3, 80, 20)];
        _bar44Btn.text = @"13℃";
        _bar44Btn.font = [UIFont systemFontOfSize:fontSize];
        _bar44Btn.textColor = textColor;
        _bar44Btn.textAlignment = NSTextAlignmentCenter;
        
        _bar33Btn = [[YYLabel alloc] initWithFrame:CGRectMake(bar4Btn.left - 70, _bar1Btn.bottom + 3, 80, 20)];
        _bar33Btn.text = @"PM2.5";
        _bar33Btn.font = [UIFont systemFontOfSize:fontSize];
        _bar33Btn.textColor = textColor;
        _bar33Btn.textAlignment = NSTextAlignmentCenter;
        
        _bar22Btn = [[YYLabel alloc] initWithFrame:CGRectMake(bar3Btn.left - 50, _bar1Btn.bottom + 3, 80, 20)];
        _bar22Btn.text = @"温度";
        _bar22Btn.font = [UIFont systemFontOfSize:fontSize];
        _bar22Btn.textColor = textColor;
        _bar22Btn.textAlignment = NSTextAlignmentCenter;
        
        _bar11Btn = [[YYLabel alloc] initWithFrame:CGRectMake(bar2Btn.left - 50, _bar1Btn.bottom + 3, 80, 20)];
        _bar11Btn.text = @"东南风";
        _bar11Btn.font = [UIFont systemFontOfSize:fontSize];
        _bar11Btn.textColor = textColor;
        _bar11Btn.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:_currentHostLabel];
        [cell.contentView addSubview:moreBtn];
        [cell.contentView addSubview:_cityBtn];
        [cell.contentView addSubview:_temperatureBtn];
        [cell.contentView addSubview:_weatherBtn];
        [cell.contentView addSubview:bar4Btn];
        [cell.contentView addSubview:bar3Btn];
        [cell.contentView addSubview:bar2Btn];
        [cell.contentView addSubview:_bar1Btn];
        [cell.contentView addSubview:_bar44Btn];
        [cell.contentView addSubview:_bar33Btn];
        [cell.contentView addSubview:_bar22Btn];
        [cell.contentView addSubview:_bar11Btn];
        cell.contentView.backgroundColor = color;
        return cell;
    }
    NSString *imageName = @"";
    NSString *supText = @"";
    NSString *nameText = @"";
    NSDictionary *dic;
    if (indexPath.section == 1) {
        dic = [self.sensorArr objectAtIndex:indexPath.row];
        imageName = @"in_scene_select_hand";//[dic objectForKey:@"icon"]
        nameText = [dic objectForKey:@"name"];
    }else if (indexPath.section == 2){
        dic = [self.deviceArr objectAtIndex:indexPath.row];
        //        NSLog(@"devicearr:%@",self.deviceArr);
        imageName = [dic objectForKey:@"icon"];
        nameText = [dic objectForKey:@"name"];
        supText = [[dic objectForKey:@"status"] integerValue] == 1 ? @"开" : @"关";
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(0, 15, 50, 50);
    imageView.centerX = cell.contentView.centerX;
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.tag = 500500;
    delBtn.frame = CGRectMake(imageView.left -5, 2, 20, 20);
    [delBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    delBtn.accessibilityIdentifier = [NSString stringWithFormat:@"%ld",indexPath.section];
    delBtn.accessibilityLabel = [NSString stringWithFormat:@"%ld",indexPath.row];
    [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:delBtn];
//    UIButton *btn = (UIButton*)[cell.contentView subviewsWithTag:500500];
//    if (cellState == NormalState) {
//        btn.hidden = YES;
//    }else{
//        btn.hidden = NO;
//    }
    
    UILabel *sup = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right - 15, -5, 40, 30)];
    sup.text = supText;
    sup.accessibilityIdentifier = [dic objectForKey:@"type"];
    sup.accessibilityValue = @"0";
    sup.tag = 2330;
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, KScreenWidth/4, 30)];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = nameText;
    name.centerX = cell.contentView.centerX;
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:sup];
    [cell.contentView addSubview:name];
    
    return cell;
}

//设置collection头部/尾部
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *image;
    int tag = 0;
    NSString *text;
    if (indexPath.section == 1) {
        image = @"in_common_menu_common";
        tag = 1000;
        text = @"情景快捷";
    }else if (indexPath.section == 2){
        image = @"in_common_menu_equipment";
        tag = 1002;
        text = @"设备快捷";
    }
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        [headerView removeAllSubviews];
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenHeight, 0.5)];
        line1.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line1.bottom + 10, 30, 30)];
        [imageView setImage:[UIImage imageNamed:image]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, line1.bottom + 10, 200, 30)];
        label.tag = 3003303;
        label.text = text;
        
        UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [reduceBtn setImage:[UIImage imageNamed:@"in_common_menu_reduce"] forState:UIControlStateNormal];
        reduceBtn.frame = CGRectMake(KScreenWidth - 50, 10, 30, 30);
        reduceBtn.tag = tag + 1;
        [reduceBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"in_common_menu_add"] forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(reduceBtn.left - 40, 10, 30, 30);
        addBtn.tag = tag;
        [addBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom + 10, KScreenHeight, 0.5)];
        line2.backgroundColor = [UIColor lightGrayColor];
        
        [headerView addSubview:line1];
        [headerView addSubview:imageView];
        [headerView addSubview:label];
        [headerView addSubview:addBtn];
        [headerView addSubview:reduceBtn];
        [headerView addSubview:line2];
        return headerView;
    }
    return nil;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]; //即为要得到的cell
    UILabel *label;
    for (UIView *view in [cell.contentView subviews]) {
        CGFloat tag = view.tag;
        if (tag == 2330) {
            label = (UILabel*)view;
        }
        NSLog(@"tag:%f",tag);
    }
//    UILabel *label = (UILabel*)[cell.contentView subviewsWithTag:2330];
    CGFloat value = [label.accessibilityValue integerValue];
    if (value == 1) {
        return ;
    }else{
        label.accessibilityValue = @"1";
    }
    NSInteger section  = indexPath.section;
    NSInteger row = indexPath.row;
    NSDictionary *dic;
    if (section == 1) {
        dic = [self.sensorArr objectAtIndex:row];
        NSLog(@"dic:%@",dic);
        NSDictionary *params = @{@"master_id":GET_USERDEFAULT(MASTER_ID),@"scene_id":[dic objectForKey:@"scene_id"]};
        [[APIManager sharedManager]deviceTriggerSceneWithParameters:params success:^(id data) {
            NSDictionary *datadic = data;
            label.accessibilityValue = @"0";
            //            NSLog(@"data:%@",data);
            if([[datadic objectForKey:@"code"] intValue] == 200){

                label.text = [label.text isEqualToString:@"开"] ?  @"关" : @"开";
            }else{

            }
        } failure:^(NSError *error) {

        }];
    }else if (section == 2){
        dic = [self.deviceArr objectAtIndex:row];
        CGFloat type = [[dic objectForKey:@"type"] integerValue];
        CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
        CGFloat status = [label.text isEqualToString:@"开"] ? 0 : 1;
        CGFloat ch = [[dic objectForKey:@"ch"]integerValue];
        NSDictionary *cmd = @{
                              @"cmd":@"edit",
                              @"type":@(type),
                              @"devid":@(devid),
                              @"value":@(status),
                              @"ch":@(ch)
                              };
        NSDictionary *params = @{
                                 @"master_id":GET_USERDEFAULT(MASTER_ID),
                                 @"device_type":@(type),
                                 @"cmd":[cmd jsonStringEncoded]
                                 };
        [[APIManager sharedManager]deviceZigbeeCmdsWithParameters:params success:^(id data) {
            NSDictionary *datadic = data;
            label.accessibilityValue = @"0";
            if([[datadic objectForKey:@"code"] intValue] == 200 ){
                if ([[[datadic objectForKey:@"data"] objectForKey:@"status"] integerValue] >= 0) {

                    label.text = [label.text isEqualToString:@"开"] ?  @"关" : @"开";
                }
            }else{

            }
        } failure:^(NSError *error) {

        }];
    }
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(KScreenWidth, 190);
    }
    int itemW = (self.view.frame.size.width - 5*10) / 4;
    return CGSizeMake(itemW, itemW / 0.68);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 50);
}

//设备下拉菜单选择代理
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image;
{
    if (index==0) {
        //分享功能
        CodeGenerateViewController *vc = [[CodeGenerateViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1){
        MMPopupItemHandler block = ^(NSInteger index){
            if(index == 0){
                ScavengingCodeViewController *vc = [ScavengingCodeViewController new];
                [self pushViewController:vc];
            }else if (index == 1){
                WifiConfigViewController *vc = [WifiConfigViewController new];
                [self pushViewController:vc];
            }
        };
        NSArray *items =
        @[MMItemMake(@"智能zigbee主机", MMItemTypeNormal, block),
          MMItemMake(@"智能RF主机", MMItemTypeNormal, block),
          MMItemMake(@"取消", MMItemTypeNormal, block)];
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"添加主机"
                                                             detail:@""
                                                              items:items];
        alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
        [alertView show];
    }else if (index == 2){
        MMPopupItemHandler block = ^(NSInteger index){
            if(index == 0){
                TwoWayViewController *vc = [TwoWayViewController new];
                [self pushViewController:vc];
            }else if (index == 1){
                WifiConfigViewController *vc = [WifiConfigViewController new];
                [self pushViewController:vc];
            }
        };
        NSArray *items =
        @[MMItemMake(@"智能搜索", MMItemTypeNormal, block),
          MMItemMake(@"WIFI搜索", MMItemTypeNormal, block),
          MMItemMake(@"取消", MMItemTypeNormal, block)];
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"设备选择"
                                                             detail:@""
                                                              items:items];
        alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
        [alertView show];
    }
}
#pragma mark ————— 懒加载 —————
-(NSMutableArray*)hostsArray{
    if (_hostsArray == nil) {
        _hostsArray = [NSMutableArray new];
    }
    return _hostsArray;
}

-(NSMutableArray*)moreEquipmentTitleArray{
    if (_moreEquipmentImgArray == nil) {
        _moreEquipmentImgArray = [NSMutableArray new];
    }
    return _moreEquipmentImgArray;
}

-(NSMutableArray*)moreEquipmentImgArray{
    if (_moreEquipmentImgArray == nil) {
        _moreEquipmentImgArray = [NSMutableArray new];
    }
    return _moreEquipmentImgArray;
}

-(NSMutableArray *)sensorArr{
    if (_sensorArr == nil) {
        _sensorArr = [[NSMutableArray new]mutableCopy];
    }
    return _sensorArr;
}

-(NSMutableArray *)deviceArr{
    if (_deviceArr == nil) {
        _deviceArr = [NSMutableArray new];
    }
    return _deviceArr;
}

#pragma mark ————— 方法 —————

-(void)click:(UIButton*)sender{
    if (sender.tag == 999) {
        self.moreEquipmentTitleArray = [NSMutableArray arrayWithArray:@[@"分享",@"添加主机",@"添加设备"]];
        self.moreEquipmentImgArray = [NSMutableArray arrayWithArray:@[@"in_common_more_share",@"in_common_more_add",@"in_common_more_equipment"]];
        //获取按钮相对于self.view的相对位置
        CGRect btnRectInwindow = [sender.superview convertRect:sender.frame toView:self.view];
        [JMDropMenu showDropMenuFrame:CGRectMake(self.view.frame.size.width - 128, btnRectInwindow.origin.y+btnRectInwindow.size.height, 120, 128) ArrowOffset:90.f TitleArr:_moreEquipmentTitleArray ImageArr:_moreEquipmentImgArray Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeNormal RowHeight:40.f Delegate:self];
    }else if(sender.tag == 1000){
//        getSensorViewController *control = [[getSensorViewController alloc] init];
//        [self.navigationController pushViewController:control animated:YES];
    }else if (sender.tag == 1001){
//        if (cellState == DeleteState) {
//            cellState = NormalState;
//        }else{
//            cellState = DeleteState;
//        }
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }else if(sender.tag == 1002){
//        GetDeviceViewController *control = [[GetDeviceViewController alloc] init];
//        [self.navigationController pushViewController:control animated:YES];
    }else if (sender.tag == 1003){
//        if (cellState == DeleteState) {
//            cellState = NormalState;
//        }else{
//            cellState = DeleteState;
//        }
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
    }
}

-(void)loadData{
    if (GET_USERDEFAULT(MASTER_ID) > 0) {
        [self getWeather];
        [self getSensor];
        [self getDevice];
        if (GET_USERDEFAULT(MASTER) != nil) {
            if([GET_USERDEFAULT(MASTER) isKindOfClass:[NSArray class]])
            {
                NSMutableArray *master = GET_USERDEFAULT(MASTER);
                for (int i = 0; i < master.count; i++) {
                    NSDictionary *dic = master[i];
                    if ([[dic objectForKey:@"master_id"] integerValue] == [GET_USERDEFAULT(MASTER_ID) integerValue]) {
                        _currentHostLabel.text = [dic objectForKey:@"master_name"];
                    }
                    [self.hostsArray addObject:[dic objectForKey:@"master_name"]];
                    //            _hostsArray = [NSMutableArray arrayWithArray:@[[dic objectForKey:@"master_name"]];
                }
            }else{
                NSDictionary *dic = GET_USERDEFAULT(MASTER);
                if ([[dic objectForKey:@"master_id"] integerValue] == [GET_USERDEFAULT(MASTER_ID) integerValue]) {
                    _currentHostLabel.text = [dic objectForKey:@"master_name"];
                }
                [self.hostsArray addObject:[dic objectForKey:@"master_name"]];
                
            }
        }
    }
}

//获取天气
-(void) getWeather{
    NSString* master_id = GET_USERDEFAULT(MASTER_ID);
    if(master_id != nil){
        [[APIManager sharedManager] deviceWeatherWithParameters:@{@"masterId": master_id} success:^(id data) {
            NSDictionary *datadic = [data objectForKey:@"data"];
            UsualViewController *user = [UsualViewController mj_objectWithKeyValues:datadic];
            NSDictionary* result = user.result;
            NSDictionary* api = [result objectForKey:@"aqi"];
            _cityBtn.text = [result objectForKey:@"city"];
            _temperatureBtn.text = [NSString stringWithFormat:@"%@℃",[result objectForKey:@"temp"]];
            _weatherBtn.text = [[NSString alloc] initWithFormat:@"%@ | 空气%@",[result objectForKey:@"weather"],[api objectForKey:@"quality"]];
            _bar1Btn.text = [result objectForKey:@"winddirect"];
            _bar11Btn.text = [result objectForKey:@"windpower"];
            _bar22Btn.text = [[NSString alloc] initWithFormat:@"%@%@",[result objectForKey:@"humidity"],@"%"];
            _bar33Btn.text = [api objectForKey:@"ipm2_5"];
            //            NSLog(@"%@",[api objectForKey:@"ipm2_5"]);
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [MBProgressHUD showErrorMessage:@"请求失败"];
        }];
    }
}

-(void)getSensor{
    [[APIManager sharedManager]deviceGetSceneShortcutWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSMutableArray *arr = [data objectForKey:@"data"];
        if ([arr isKindOfClass:[NSArray class]]) {
            self.sensorArr = arr;
        }else{
            self.sensorArr = [[NSMutableArray alloc]init];
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    } failure:^(NSError *error) {
        
    }];
    //    [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
    //        NSMutableArray *arr = [data objectForKey:@"data"];
    //        if ([arr isKindOfClass:[NSArray class]]) {
    //            self.sensorArr = arr;
    //        }else{
    //            self.sensorArr = [[NSMutableArray alloc]init];
    //        }
    //        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    //    } failure:^(NSError *error) {
    //
    //    }];
}


-(void)getDevice{
    [[APIManager sharedManager]deviceGetDeviceShortcutWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSMutableArray *arr = [data objectForKey:@"data"];
        //        NSLog(@"arr:%@",arr);
        if ([arr isKindOfClass:[NSArray class]]) {
            self.deviceArr = arr;
        }else{
            self.deviceArr = [[NSMutableArray alloc]init];
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
    } failure:^(NSError *error) {
        
    }];
}

-(void)changeHost{
//    [SelectAlert showWithTitle:@"切换当前主机" titles:_hostsArray TitleLabColor:RGBA(0,228,255,1.0) RightImg:[UIImage imageNamed:@"in_arrow_right"] BottomBtnTitle:@"添加新主机" CellHeight:50 selectIndex:^(NSInteger selectIndex) {
//        NSArray *master = GET_USERDEFAULT(MASTER);
//        NSDictionary *dic = [master objectAtIndex:selectIndex];
//        SET_USERDEFAULT(MASTER_ID, [dic objectForKey:@"master_id"]);
//        _currentHostLabel.text = [dic objectForKey:@"master_name"];
//        //切换主机
//    } selectValue:^(NSString *selectValue) {
//        //不做操作
//    } CloseActionBlock:^{
//        //添加主机
//        [self.navigationController pushViewController:[WifiConfigViewController shareInstance] animated:YES];
//    } showCloseButton:YES];
}

-(void)delBtnClick:(UIButton*)sender{
    NSInteger section = [sender.accessibilityIdentifier integerValue];
    NSInteger row = [sender.accessibilityLabel integerValue];
    NSString *shortcut_id;
    NSDictionary *dic;
    NSLog(@"section:%ld",section);
    if (section == 1) {
        dic = [self.sensorArr objectAtIndex:row];
        shortcut_id = [dic objectForKey:@"id"];
    }else if (section == 2){
        dic = [self.deviceArr objectAtIndex:row];
        NSLog(@"dic:%@",dic);
        shortcut_id = [dic objectForKey:@"shortcut_id"];
    }
    NSLog(@"sensor:%@",self.sensorArr);
    NSLog(@"dic:%@",dic);
    NSDictionary *params = @{
                             @"shortcut_id":shortcut_id
                             };
    if (section == 1) {
        [[APIManager sharedManager]deviceDeleteSceneShortcutWithParameters:params success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
//            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
            if ([[datadic objectForKey:@"code"] intValue] == 200) {
                [self loadData];
            }
        } failure:^(NSError *error) {
            
        }];
    }else if (section == 2){
        [[APIManager sharedManager]deviceDeleteDeviceShortcutWithParameters:params success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
            
//            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
            if ([[datadic objectForKey:@"code"] intValue] == 200) {
                [self loadData];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    //    NSLog(@"%@",sender.accessibilityIdentifier);
    //    NSLog(@"%@",sender.accessibilityLabel);
}
@end
