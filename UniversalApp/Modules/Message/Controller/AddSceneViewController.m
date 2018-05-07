//
//  AddScene2ViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/4/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "AddSceneViewController.h"
#import "ConditionViewController.h"
#import "AddConditionViewController.h"
#import "DetailViewController.h"
#import "TaskViewController.h"
//#import "TextfieldAlertViewController.h"
//#import "SwitchIconSelectViewController.h"
static NSString *identifier = @"cellID";
static NSString *headerReuseIdentifier = @"hearderID";
NS_ENUM(NSInteger,ifState){
    
    //右上角编辑按钮的两种状态；
    //正常的状态，按钮显示“编辑”;
    NormalState,
    //正在删除时候的状态，按钮显示“完成”；
    DeleteState
    
};
NS_ENUM(NSInteger,thenState){
    
    //右上角编辑按钮的两种状态；
    //正常的状态，按钮显示“编辑”;
    NormaState,
    //正在删除时候的状态，按钮显示“完成”；
    DelState
    
};
NS_ENUM(NSInteger, enableState){
    //使能
    enable,
    //没有使能
    noenable
};
@interface AddSceneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
//@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *ifArr;
@property(nonatomic, strong) NSMutableArray *thenArr;
@property(nonatomic, strong) NSMutableDictionary *week;
@property(nonatomic,assign) enum ifState;
@property(nonatomic,assign) enum thenState;
@property(nonatomic, assign) enum enableState;
@property(nonatomic, strong) YYLabel *titleBtn;
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UISwitch *swt;
@end

@implementation AddSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.title = @"情景添加";
    [self addNavigationItemWithTitles
     :@[@"添加"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    ifState = NormalState;
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //最小行间距（默认是10）
    flow.minimumLineSpacing = 0;
    //创建网格对象
    self.collectionView.collectionViewLayout = flow;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //注册header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return self.ifArr.count;
    }else if (section == 2){
        return  self.thenArr.count;
    }
    return 0;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    NSString *identifier = [NSString stringWithFormat:@"%ld:%ld",(long)indexPath.section,(long)indexPath.row];
    cell.accessibilityIdentifier = identifier;
    CGFloat sec = indexPath.section;
    NSDictionary *dic;
    if (sec == 1) {
        dic = [self.ifArr objectAtIndex:indexPath.row];
    }else if (sec == 2){
        dic = [self.thenArr objectAtIndex:indexPath.row];
        //        dic = [selfobjectAtIndex:indexPath.row];
    }
    
    //    NSLog(@"dic:%@",dic);
    NSString *titleText = @"";
    NSString *detailText = @"";
    CGFloat type = [[dic objectForKey:@"type"] integerValue];
    NSString *imageStr = @"20111";
    if (type == 33111) {
        NSArray *value = [dic objectForKey:@"value"];
        NSDictionary *startTime = [value objectAtIndex:0];
        NSDictionary *endTime = [value objectAtIndex:1];
        titleText = [NSString stringWithFormat:@"开始:%@:%@ 结束:%@:%@",[startTime objectForKey:@"h"],[startTime objectForKey:@"mi"],[endTime objectForKey:@"h"],[endTime objectForKey:@"mi"]];
        NSString *weekStr = [startTime objectForKey:@"w"];
        for (int i = 0; i < 7; i ++) {
            //            if (i == 7) {
            //                i = 0;
            //            }
            
            NSString *num = [NSString stringWithFormat:@"%d",i];
            if ([weekStr rangeOfString:num].location == NSNotFound) {
                //                NSLog(@"string 不存在 %@",num);
            } else {
                detailText = [NSString stringWithFormat:@"%@ %@",detailText,[self.week objectForKey:num]];
            }
        }
        detailText = [NSString stringWithFormat:@"重复星期:%@",detailText];
        imageStr = [dic objectForKey:@"type"];
    }else if (type == 20111 || type == 20121 || type == 20131 || type == 20141){
        imageStr = [dic objectForKey:@"icon1"];
        titleText = [dic objectForKey:@"name1"];
        detailText = [[dic objectForKey:@"status1"] integerValue] == 0 ? @"关" : @"开";
    }else if (type == 33011){
        imageStr = @"33011";
        titleText = [NSString stringWithFormat:@"延时: %@秒",[dic objectForKey:@"value"]];
        detailText = @"";
    }else if (type == 310110){
        imageStr = [dic objectForKey:@"icon1"];
        titleText = [dic objectForKey:@"name1"];
        detailText = @"开";
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    imageView.image = [UIImage imageNamed:imageStr];
    
    YYLabel *title = [[YYLabel alloc]initWithFrame:CGRectMake(imageView.right + 5, 5, KScreenWidth - imageView.right - 5 - 40, 20)];
    title.font = [UIFont systemFontOfSize:12];
    title.text = titleText;
    
    YYLabel *detail = [[YYLabel alloc]initWithFrame:CGRectMake(imageView.right + 5, title.bottom, KScreenWidth - imageView.right - 5 - 40, 20)];
    detail.font = [UIFont systemFontOfSize:12];
    detail.text = detailText;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 20 - 20, 15, 20, 20)];
    rightBtn.accessibilityIdentifier = identifier;
    if (sec == 1) {
        if (ifState == NormalState) {
            [rightBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        }else{
            [rightBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (sec == 2){
        if (thenState == NormaState) {
            [rightBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        }else{
            [rightBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, cell.contentView.bottom, KScreenWidth, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:title];
    [cell.contentView addSubview:detail];
    [cell.contentView addSubview:rightBtn];
    [cell.contentView addSubview:line2];
    return cell;
}

//设置collection头部/尾部
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *text = @"test";
    CGFloat sec = indexPath.section;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        [headerView removeAllSubviews];
        headerView.backgroundColor = [UIColor whiteColor];
        if (sec == 0) {
            text = @"情景名称";
            _btn = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn.frame = CGRectMake(0, 0, 50, headerView.height);
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
            NSString *imgName = @"33111";
            imageView.image = [UIImage imageNamed:imgName];
            imageView.tag = 331111;
            _btn.tag = 33111;
            _btn.accessibilityIdentifier = imgName;
            [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [_btn addSubview:imageView];
            [headerView addSubview:_btn];
            
            _titleBtn = [[YYLabel alloc] initWithFrame:CGRectMake(_btn.right, 0, KScreenWidth - _btn.right, headerView.height)];
            _titleBtn.textAlignment = NSTextAlignmentCenter;
            _titleBtn.text = text;
            _titleBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//                TextFieldAlertViewController *textalert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
//                [textalert setTitle:@"添加情景名称" EnterBlock:^(NSString *text) {
//                    if (text) {
//                        _titleBtn.text = text;
//                    }
//                } Cancle:^(NSString *text) {
//
//                }];
//                [textalert showWithParentViewController:nil];
//                [textalert showPopupview];
            };
            [headerView addSubview:_titleBtn];
            
            UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 20 - 20, 15, 20, 20)];
            rightView.image = [UIImage imageNamed:@"箭头"];
            [headerView addSubview:rightView];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }else if (sec == 1 || sec == 2){
            CGFloat tag;
            if (sec == 1) {
                tag = 1331;
                text = @"以下所有条件满足时";
            }else if (sec == 2){
                tag = 1333;
                text = @"按步骤执行以下任务";
            }
            UIView *headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.5)];
            headerLine.backgroundColor = [UIColor lightGrayColor];
            YYLabel *label = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, headerView.height)];
            label.text = text;
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            
            
            UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [reduceBtn setImage:[UIImage imageNamed:@"in_common_menu_reduce"] forState:UIControlStateNormal];
            reduceBtn.frame = CGRectMake(KScreenWidth - 50, 10, 30, 30);
            reduceBtn.tag = tag;
            [reduceBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setImage:[UIImage imageNamed:@"in_common_menu_add"] forState:UIControlStateNormal];
            addBtn.frame = CGRectMake(reduceBtn.left - 40, 10, 30, 30);
            addBtn.tag = tag + 1;
            [addBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom, KScreenWidth, 0.5)];
            line2.backgroundColor = [UIColor lightGrayColor];
            [headerView addSubview:headerLine];
            [headerView addSubview:label];
            [headerView addSubview:addBtn];
            [headerView addSubview:reduceBtn];
            [headerView addSubview:line2];
            return headerView;
        }else if (sec == 3){
            UIView *headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.5)];
            headerLine.backgroundColor = [UIColor lightGrayColor];
            YYLabel *label = [[YYLabel alloc]initWithFrame:CGRectMake(40, 0, 80, 50)];
            label.text = @"通知消息  ";
            YYLabel *label2 = [[YYLabel alloc]initWithFrame:CGRectMake(label.right, 0, 140, 50)];
            label2.text = @"情景自动触发时";
            label2.font = [UIFont systemFontOfSize:14];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom, KScreenWidth, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [headerView addSubview:headerLine];
            [headerView addSubview:label];
            [headerView addSubview:label2];
            [headerView addSubview:line];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line.bottom + 5, 40, 40)];
            imageView.image = [UIImage imageNamed:@"in_scene_message"];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, line.bottom + 5, KScreenWidth - imageView.right, 20)];
            title.text = @"向手机发送通知消息";
            title.font = [UIFont systemFontOfSize:14];
            UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, title.bottom, KScreenWidth - imageView.right, 20)];
            detail.text = @"消息:情景名称情景已自动触发";
            detail.font = [UIFont systemFontOfSize:14];
            UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            switchBtn.frame = CGRectMake(label2.right, 0, 51, 31);
            _swt = [[UISwitch alloc]initWithFrame:CGRectMake(0, switchBtn.top + 9.5, 51, 31)];
            [switchBtn addSubview:_swt];
            [_swt setOn:YES];
            enableState = enable;
            [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, detail.bottom + 10, KScreenWidth, 0.5)];
            line2.backgroundColor = [UIColor lightGrayColor];
            [headerView addSubview:imageView];
            [headerView addSubview:title];
            [headerView addSubview:detail];
            [headerView addSubview:switchBtn];
            [headerView addSubview:line2];
            return headerView;
        }
    }
    return nil;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat sec = indexPath.section;
    CGFloat row = indexPath.row;
    NSDictionary *dic;
    if (sec == 1) {
        dic = [self.ifArr objectAtIndex:row];
        CGFloat type = [[dic objectForKey:@"type"] integerValue];
        if (type == 33111) {
            AddConditionViewController *con = [AddConditionViewController new];
            con.tempDic = dic;
            con.row = row;
            [self pushViewController:con];
        }
    }else if (sec == 2){
        
    }
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return CGSizeMake(KScreenWidth, 100);
    }
    return CGSizeMake(KScreenWidth, 50);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 50);
}
#pragma mark ————— 方法 —————
-(void)setIfDic:(NSDictionary *)ifDic row:(CGFloat)row{
    if (row < 0) {
        [self.ifArr addObject:ifDic];
    }else{
        [self.ifArr replaceObjectAtIndex:row withObject:ifDic];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
}
-(void)setThenDic:(NSDictionary *)thenDic row:(CGFloat)row{
    if (row < 0) {
        [self.thenArr addObject:thenDic];
    }else{
        [self.thenArr replaceObjectAtIndex:row withObject:thenDic];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
}
-(void)setThenDic:(NSDictionary *)thenDic{
    if (thenDic != nil) {
        [self.thenArr addObject:thenDic];
    }
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
}
-(void)click:(UIButton*)sender{
    CGFloat tag = sender.tag;
    if (tag == 1331) {
        if (ifState == DeleteState) {
            ifState = NormalState;
        }else{
            ifState = DeleteState;
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        return ;
    }else if (tag == 1332){
        ConditionViewController *con = [ConditionViewController new];
        [self.navigationController pushViewController:con animated:YES];
        return ;
    }else if (tag == 1333){
        if (thenState == DeleteState) {
            thenState = NormaState;
        }else{
            thenState = DelState;
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
        return ;
    }else if (tag == 1334){
        TaskViewController *con = [TaskViewController new];
        [self pushViewController:con];
//        [self.navigationController pushViewController:con animated:YES];
        return ;
    }else if (tag == 33111){
//        SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
//        [switchIcon setImgArray:@[@"20111",@"20121"] titleArray:@[@"一键开关",@"二键开关"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
//            //按钮的返回事件
//            UIImageView *imageView = (UIImageView*)[_btn subviewsWithTag:331111];
//            imageView.image = [UIImage imageNamed:imagestr];
//            _btn.accessibilityIdentifier = imagestr;
//
//        }] ;
//        [switchIcon showWithParentViewController:nil];
//        [switchIcon showPopupview];
    }else{
        NSArray *secRow = [sender.accessibilityIdentifier componentsSeparatedByString:@":"];
        CGFloat sec = [[secRow objectAtIndex:0] integerValue];
        CGFloat row = [[secRow objectAtIndex:1] integerValue];
        if (sec == 1) {
            [self.ifArr removeObjectAtIndex:row];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }else if (sec == 2){
            [self.thenArr removeObjectAtIndex:row];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
        }
    }
}
-(void)switchAction:(id)sender
{
    BOOL isButtonOn = [_swt isOn];
    if (isButtonOn) {
        [_swt setOn:NO];
        enableState = noenable;
    }else {
        [_swt setOn:YES];
        enableState = enable;
    }
}
#pragma mark ————— 懒加载 —————
-(NSMutableArray*)ifArr{
    if (_ifArr == nil) {
        _ifArr = [NSMutableArray new];
    }
    return _ifArr;
}

-(NSMutableArray*)thenArr{
    if (_thenArr == nil) {
        _thenArr = [NSMutableArray new];
    }
    return _thenArr;
}

-(NSMutableDictionary*)week{
    if (!_week) {
        _week = [[NSMutableDictionary alloc]init];
        [_week setObject:@"日" forKey:@"0"];
        [_week setObject:@"一" forKey:@"1"];
        [_week setObject:@"二" forKey:@"2"];
        [_week setObject:@"三" forKey:@"3"];
        [_week setObject:@"四" forKey:@"4"];
        [_week setObject:@"五" forKey:@"5"];
        [_week setObject:@"六" forKey:@"6"];
    }
    return _week;
}

- (void) naviBtnClick:(UIButton*)btn{
    if (btn.tag == 1000) {
        [self save];
    }
}
- (void) save{
    if (self.ifArr.count <= 0) {
//        [[AlertManager alertManager] showError:3.0 string:@"请添加条件"];
//        return ;
    }
    if (self.thenArr.count <= 0) {
//        [[AlertManager alertManager] showError:3.0 string:@"请选择执行"];
//        return ;
    }
    NSString *devid = @"";
    NSString *name = _titleBtn.text;
    NSString *is_push = enableState == noenable ? @"0" : @"1";
    NSString *enable = @"0";
    NSMutableArray *devceid = [NSMutableArray new];
    NSMutableArray *ifArr = [NSMutableArray new];
    NSMutableArray *thenArr = [NSMutableArray new];
    for (int i = 0; i < self.ifArr.count; i++) {
        NSDictionary *dic = [self.ifArr objectAtIndex:i];
        CGFloat type = [[dic objectForKey:@"type"] integerValue];
        if (type != 33111) {
            CGFloat type = [[dic objectForKey:@"type"] integerValue];
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            [devceid addObject:@{@"type":@(type),@"device_id":@(devid)}];
        }
        NSDictionary *params;
        if (type == 33111) {
            params = @{
                       @"type": @(type),
                       @"value": [dic objectForKey:@"value"]
                       };
        }else if (type == 25711){
            CGFloat ch = [[dic objectForKey:@"ch1"] integerValue];
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            CGFloat value = [[dic objectForKey:@"value"] integerValue];
            params = @{
                       @"type":@(type),
                       @"devid":@(devid),
                       @"compare":@">",
                       @"value":@(value),
                       @"ch":@(ch)
                       };
        }else{
            CGFloat status1 = [[dic objectForKey:@"status1"] integerValue];
            CGFloat ch = [[dic objectForKey:@"ch1"] integerValue];
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            params = @{
                       @"type":@(type),
                       @"devid":@(devid),
                       @"compare":@"==",
                       @"value":@(status1),
                       @"ch":@(ch)
                       };
        }
        [ifArr addObject:params];
    }
    //    NSLog(@"thenarr:%@",self.thenArr);
    for (int i = 0; i < self.thenArr.count; i++) {
        NSDictionary *dic = [self.thenArr objectAtIndex:i];
        CGFloat type = [[dic objectForKey:@"type"] integerValue];
        if (type != 310110 && type != 33011) {
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            [devceid addObject:@{@"type":@(type),@"device_id":@(devid)}];
        }else if (type == 310110){
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            [devceid addObject:@{@"type":@(33011),@"device_id":@(devid)}];
            enable = @"1";
        }
        NSDictionary *params;
        NSString *compare = @"==";
        if (type == 33011) {
            CGFloat value = [[dic objectForKey:@"value"] integerValue];
            params = @{
                       @"type":@(type),
                       @"value":@(value)
                       };
        }else if (type == 25711){
            
        }else if(type == 31011 || type == 310110){
            CGFloat status = [[dic objectForKey:@"status"] integerValue];
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            params = @{
                       @"type":@(31011),@"sta":@(status),@"devid":@(devid)
                       };
        }else{
            CGFloat devid = [[dic objectForKey:@"devid"] integerValue];
            CGFloat status1 = [[dic objectForKey:@"status1"] integerValue];
            CGFloat ch = [[dic objectForKey:@"ch1"] integerValue];
            params = @{
                       @"type":@(type),
                       @"devid":@(devid),
                       @"compare":compare,
                       @"value":@(status1),
                       @"ch": @(ch)
                       };
        }
        if (params != nil) {
            [thenArr addObject:params];
        }
    }
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"name":name,
                             @"devid":devid,
                             @"icon":@"3001",
                             @"condition":[[function sharedManager] formatToJson:ifArr],
                             @"action":[[function sharedManager] formatToJson:thenArr],
                             @"message":@"情景名称情景已自动触发",
                             @"is_push":is_push,
                             @"enable":enable,
                             @"scene_devices":[[function sharedManager] formatToJson:devceid]
                             };
    //    NSLog(@"params:%@",params);
    [[APIManager sharedManager]deviceAddSceneWithParameters:params success:^(id data) {
        NSDictionary *dic = data;
        NSInteger code = [[dic objectForKey:@"code"] integerValue];
        if (code == 0) {
            NSLog(@"msg:%@",[data objectForKey:@"msg"]);
        }else{
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[DetailViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            DetailViewController *controller = [[DetailViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"saf:%@",error);
    }];
}
#pragma mark 返回
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
