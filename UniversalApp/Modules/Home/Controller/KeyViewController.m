//
//  KeyViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "KeyViewController.h"
#import <MMAlertView.h>
#import "AlertView.h"
#import "AlertRoomView.h"
#import "AlertIconView.h"
static NSString *identifier = @"cellID";
@interface KeyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AlertRoomViewDelegate>{
    
}
@property(nonatomic, strong) UIView *currentView;
@property(nonatomic, strong) UIButton *currentButton;
@property(nonatomic, strong) UICollectionViewFlowLayout *flow;
@property(nonatomic, strong) NSArray *imgArr;
@property(nonatomic, strong) NSArray *titleArr;
@property(nonatomic, strong) NSArray *nameArr;
@property(nonatomic, strong) YYLabel *swichNameLabel;
@property(nonatomic, strong) YYLabel *swichZoneLabel;
@property(nonatomic, strong) YYLabel *swichKeyLabel;
@property (nonatomic, strong) NSArray* cacheRoom;
@property (nonatomic, strong) NSMutableDictionary* room;
@end

@implementation KeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.title;
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    //添加导航栏按钮
    [self addNavigationItemWithTitles
     :@[@"保存"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.collectionView.collectionViewLayout = self.flow;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
    
    
}

-(void)naviBtnClick:(UIButton *)btn{
    
//    RootViewController *v = [RootViewController new];
//    v.isHidenNaviBar = YES;
//    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        self.flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return _setNum;
    }
    self.flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    return 1;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        CGFloat row = indexPath.row + 1;
        NSString *imageName = [self.imgArr objectAtIndex:row];
        NSString *nameStr = [self.nameArr objectAtIndex:row];
        if (_dataDic != nil) {
            NSArray *arr = [[function sharedManager] stringToJSON:[_dataDic objectForKey:@"setting"]];
            NSDictionary *dic = [arr objectAtIndex:indexPath.row];
            imageName = [dic objectForKey:@"icon"];
            nameStr = [dic objectForKey:@"name"];
        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = 10000;
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.image.accessibilityIdentifier = imageName;
        imageView.frame = CGRectMake(0, 15, 50, 50);
        imageView.centerX = cell.contentView.centerX;
        imageView.tag = 1001;
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, KScreenWidth/4, 30)];
        name.textAlignment = NSTextAlignmentCenter;
        name.text = nameStr;
        name.centerX = cell.contentView.centerX;
        name.tag = 1002;
        
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:name];
        // cell点击变色
        UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
        selectedBGView.backgroundColor = [UIColor redColor];
        cell.selectedBackgroundView = selectedBGView;
        
        return cell;
    }
    
    UIButton *switchNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchNameBtn.frame = CGRectMake(0, 0, KScreenWidth, 50);
    
    UIView *line1 = [self getLine:CGRectMake(0, 0, KScreenWidth, 1)];
    
    YYLabel *swichName = [[YYLabel alloc] initWithFrame:CGRectMake(10, switchNameBtn.top + 10, 80, 30)];
    swichName.text = [self.titleArr objectAtIndex:indexPath.section];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(KScreenWidth - 20, switchNameBtn.top + 20, 10, 10);
    [rightBtn setImage:[UIImage imageNamed:@"in_arrow_right"] forState:UIControlStateNormal];
    
    YYLabel *swichNameLabel = [[YYLabel alloc] initWithFrame:CGRectMake(KScreenWidth - 20 - 90, switchNameBtn.top + 10, 80, 30)];
    NSString *text = @"";
    if (indexPath.section == 1) {
        _swichNameLabel = swichNameLabel;
        text = _dataDic != nil ? [_dataDic objectForKey:@"name"] : [self.nameArr objectAtIndex:_setNum];
    }else if (indexPath.section == 3){
        _swichKeyLabel = swichNameLabel;
    }else if (indexPath.section == 4){
        _swichZoneLabel = swichNameLabel;
    }
    swichNameLabel.text = text;
    swichNameLabel.tag = 8000;
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    //    NSLog(@"top:%f",switchNameBtn.top);
    [switchNameBtn addSubview:line1];
    [switchNameBtn addSubview:swichName];
    [switchNameBtn addSubview:rightBtn];
    [switchNameBtn addSubview:swichNameLabel];
    [switchNameBtn addSubview:line2];
    switchNameBtn.tag = [[NSString stringWithFormat:@"%ld000",indexPath.section] integerValue];
    [switchNameBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:switchNameBtn];
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _currentView = [collectionView cellForItemAtIndexPath:indexPath].contentView;
    }
    DLog(@"%ld",indexPath.section);
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section > 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_setNum == 1) {
            return CGSizeMake(KScreenWidth/2, 100);
        }
        int itemW = (self.view.frame.size.width - (_setNum + 1)*10) / _setNum;
        return CGSizeMake(itemW, 100);
    }
    return CGSizeMake(KScreenWidth, 50);
}

//设置点击高亮和非高亮效果！
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
}
//房间delegate
-(void)roomDidSelect:(NSDictionary *)dic{
    _swichZoneLabel.text = [dic objectForKey:@"name"];
    _swichZoneLabel.accessibilityLabel = [dic objectForKey:@"id"];
}
//房间delegate
-(void)iconDidSelect:(NSDictionary *)dic{
    DLog(@"dic:%@",dic);
    //按钮的返回事件
    UIImageView *imageView;
    for (UIView *view in [_currentView subviews]) {
        CGFloat tag = view.tag;
        if (tag == 1001) {
            imageView = (UIImageView*)view;
            DLog(@"te");
            break;
        }
    }
    if (imageView != nil) {
        [imageView setImage:[UIImage imageNamed:[[Picture sharedPicture] geticonTostr:[dic objectForKey:@"icon"]]]];
        imageView.image.accessibilityIdentifier = [dic objectForKey:@"icon"];
    }
}
#pragma mark ————— 懒加载 —————
-(UICollectionViewFlowLayout *)flow{
    if (_flow == nil) {
        _flow = [[UICollectionViewFlowLayout alloc]init];
    }
    return _flow;
}

-(NSArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [[NSArray alloc]initWithObjects:@"",@"开关名称",@"按钮图标",@"按键名称",@"按钮区域", nil];
    }
    return _titleArr;
}

-(NSArray *)imgArr{
    if (_imgArr == nil) {
        _imgArr = [[NSArray alloc]initWithObjects:@"",[[Picture sharedPicture] getDeviceIconForType:@"20111"],[[Picture sharedPicture] getDeviceIconForType:@"20121"],[[Picture sharedPicture] getDeviceIconForType:@"20131"],[[Picture sharedPicture] getDeviceIconForType:@"20141"], nil];
    }
    return _imgArr;
}

-(NSArray *)nameArr{
    if (_nameArr == nil) {
        _nameArr = [[NSArray alloc]initWithObjects:@"",[[Picture sharedPicture] getDeviceNameForType:@"20111"],[[Picture sharedPicture] getDeviceNameForType:@"20121"],[[Picture sharedPicture] getDeviceNameForType:@"20131"],[[Picture sharedPicture] getDeviceNameForType:@"20141"], nil];
    }
    return _nameArr;
}

-(NSMutableDictionary *)room{
    if (_room == nil) {
        _room = [NSMutableDictionary new];
    }
    return _room;
}

-(NSArray *)cacheRoom{
    if (_cacheRoom == nil) {
        _cacheRoom = [NSArray new];
    }
    return _cacheRoom;
}
#pragma mark ————— 方法 —————
-(void)click:(UIButton*)sender{
    _currentButton = sender;
    NSInteger tag = sender.tag;
    
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
//        NSLog(@"animation complete");
    };
    if (tag == 1000) {
        if (_currentButton == nil) {
            [MBProgressHUD showWarnMessage:@"请选择按键"];
        }else{
            MMAlertView *alertView = [[MMAlertView alloc] initWithInputTitle:@"开关名称" detail:@"" placeholder:_swichNameLabel.text handler:^(NSString *text) {
                if(text.length!=0){
                    _swichNameLabel.text = text;
                }
            }];
            alertView.attachedView = self.view;
            alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleExtraLight;
            [alertView showWithBlock:completeBlock];
        }
    }else if (tag == 2000){
        if (_currentView == nil) {
            [MBProgressHUD showWarnMessage:@"请选择按键"];
        }else{
            AlertIconView *sheetView = [[AlertIconView alloc]initWithTitle:@"test" items:@[@{@"icon":@"1001"},@{@"icon":@"1004"},@{@"icon":@"1001"},@{@"icon":@"1004"},@{@"icon":@"1001"},@{@"icon":@"1004"}]];
            sheetView.delegate = self;
            [sheetView showWithBlock:completeBlock];
//            MMPopupItemHandler block = ^(NSInteger index){
//                        NSLog(@"clickd %@ button",@(index));
//            };
//            NSArray *items =
//            @[MMItemMake(@"Done", MMItemTypeNormal, block),
//              MMItemMake(@"Save", MMItemTypeHighlight, block),
//              MMItemMake(@"Cancel", MMItemTypeNormal, block)];
//            AlertView *sheetView = [[AlertView alloc] initWithTitle:@"点击切换主机"
//                                                              items:items];
//            sheetView.attachedView = self.view;
//            sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
//            [sheetView showWithBlock:completeBlock];
//            SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
//            [switchIcon setImgArray:@[@"20111",@"20121",@"20131",@"20141"] titleArray:@[@"一键",@"二建",@"三键",@"四键"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
//                //按钮的返回事件
//                UIImageView *imageView = (UIImageView*)[_currentView subviewsWithTag:1001];
//                [imageView setImage:[UIImage imageNamed:imagestr]];
//                imageView.image.accessibilityIdentifier = imagestr;
//            }] ;
//            [switchIcon showWithParentViewController:nil];
//            [switchIcon showPopupview];
        }
    }else if (tag == 3000){
        if (_currentButton == nil) {
            [MBProgressHUD showWarnMessage:@"请选择按键"];
        }else{
            MMAlertView *alertView = [[MMAlertView alloc] initWithInputTitle:@"按键名称" detail:@"" placeholder:_swichKeyLabel.text handler:^(NSString *text) {
                if(text.length!=0){
                    _swichKeyLabel.text = text;
                }
            }];
            alertView.attachedView = self.view;
            //        alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
            alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleExtraLight;
            [alertView showWithBlock:completeBlock];
        }
    }else if (tag == 4000){
        AlertRoomView *sheetView = [AlertRoomView new];
        sheetView.delegate = self;
        [sheetView showWithBlock:completeBlock];
    }
}
#pragma mark - 数据保存
-(void)saveData{
//    if (_swichZoneLabel.text == nil) {
//        [MBProgressHUD showErrorMessage:@"请选择所属区域"];
//        return ;
//    }
//    NSMutableArray *setting = [NSMutableArray new];
//    int i = 0;
//    for (UIView *view in self.collectionView.subviews) {
//        for (UIView *con in view.subviews) {
//            if ([con subviewsWithTag:1001] != nil) {
//                i++;
//                UIImageView *imageView = (UIImageView *)[con subviewsWithTag:1001];
//                UILabel *label = (UILabel *)[con subviewsWithTag:1002];
//                NSDictionary *dic = @{
//                                      @"icon":imageView.image.accessibilityIdentifier,
//                                      @"name":label.text,
//                                      @"ch":[NSString stringWithFormat:@"%d",i],
//                                      @"status":@"0",
//                                      @"order":@"0"
//                                      };
//                [setting addObject:dic];
//            }
//        }
//    }
//    NSString *type = @"";
//    if (_setNum == 1) {
//        type = @"20111";
//    }else if (_setNum == 2){
//        type = @"20121";
//    }else if (_setNum == 3){
//        type = @"20131";
//    }else if (_setNum == 4){
//        type = @"20141";
//    }
//    [self.room enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        if ([obj isEqualToString: _swichZoneLabel.text]) {
//            if (_dataDic != nil) {
//                NSDictionary *params = @{
//                                         @"device_id":[_dataDic objectForKey:@"id"],
//                                         @"name":_swichNameLabel.text,
//                                         @"room_id":key,
//                                         @"setting":[CommonCode formatToJson:setting],
//                                         @"icon":type,//[CommonCode getImageType:@"in_equipment_switch_one"]
//                                         };
//                [[APIManager sharedManager]deviceDeviceEditWithParameters:params success:^(id data) {
//                    NSDictionary *datadic = data;
//                    if([[datadic objectForKey:@"code"] intValue] == 200){
//                        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
//                    }else{
//                        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
//                    }
//                } failure:^(NSError *error) {
//                }];
//            }else{
//                NSDictionary *params = @{
//                                         @"master_id":GET_USERDEFAULT(MASTER_ID),
//                                         @"name":_swichNameLabel.text,
//                                         @"type":type,
//                                         @"room_id":key,
//                                         @"setting":[CommonCode formatToJson:setting],
//                                         @"icon":type,//[CommonCode getImageType:@"in_equipment_switch_one"]
//                                         @"mac":_mac
//                                         };
//                [[APIManager sharedManager]deviceDeviceAddWithParameters:params success:^(id data) {
//                    NSDictionary *datadic = data;
//
//                    if([[datadic objectForKey:@"code"] intValue] == 200){
//                        [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
//                    }else{
//                        [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
//                    }
//                } failure:^(NSError *error) {
//
//                }];
//            }
//        }
//    }];
    
}

#pragma mark - 数据加载
-(void)loadData{
    [[APIManager sharedManager]deviceGetMasterRoomWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"]integerValue] == 200) {
            self.cacheRoom = [dic objectForKey:@"data"];
            for (int i = 0; i < self.cacheRoom.count; i ++) {
                NSDictionary *roomOne = [self.cacheRoom objectAtIndex:i];
                [self.room setValue:[roomOne objectForKey:@"name"] forKey:[NSString stringWithFormat:@"%@",[roomOne objectForKey:@"id"]]];
            }
            if (_dataDic != nil) {
                _swichZoneLabel.text = [self.room objectForKey:[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"room_id"]]];
            }
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
