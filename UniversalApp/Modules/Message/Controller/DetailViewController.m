//
//  Detail2ViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/4/20.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "DetailViewController.h"
#import "AddSceneViewController.h"
//#import "RecodeViewController.h"
static NSString *identifier = @"cellID";
@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
}
@property(nonatomic, strong) NSMutableArray *dataSouce;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.title = @"情景";
    //添加导航栏按钮
    [self addNavigationItemWithTitles
     :@[@"消息"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@999]];
    [self addNavigationItemWithTitles
     :@[@"添加"] isLeft:NO target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //创建网格对象
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight -kNavBarHeight - kTabBarHeight);
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self createLongPressGesture];
    [self loadData];
}
#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSouce.count;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSouce objectAtIndex:indexPath.section];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:[[Picture sharedPicture]geticonTostr:[dic objectForKey:@"icon"]]]];
    imageView.frame = CGRectMake(15, 5, 40, 40);
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 5, 3, KScreenWidth - imageView.right - 71, 15)];
    title.font = [UIFont systemFontOfSize:15];
    title.text = [dic objectForKey:@"name"];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 5, title.bottom + 2, KScreenWidth - imageView.right - 71, 12)];
    detail.font = [UIFont systemFontOfSize:12];
//    detail.text = [self getStr:[CommonCode stringToJSON:[dic objectForKey:@"condition"]]];
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 5, detail.bottom + 2, KScreenWidth - imageView.right - 71, 12)];
    text.font = [UIFont systemFontOfSize:12];
    text.text = @"关";
    
    UISwitch *swt = [[UISwitch alloc]initWithFrame:CGRectMake(KScreenWidth - 51 - 20, 10, 51, 30)];
    if ([[dic objectForKey:@"enable"]integerValue] == 1) {
        [swt setOn:YES animated:NO];
    }else{
        [swt setOn:NO animated:NO];
    }
    swt.tag = [[dic objectForKey:@"scene_id"]integerValue];
    [swt addTarget:self action:@selector(swtClick:) forControlEvents:UIControlEventValueChanged];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:title];
    [cell.contentView addSubview:detail];
    [cell.contentView addSubview:text];
    [cell.contentView addSubview:swt];
    [cell.contentView addSubview:line];
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self alertMsg:@"确定要退出？" cancelAction:^(UIAlertAction * _Nonnull action) {
//
//    } successAction:^(UIAlertAction * _Nonnull action) {
//
//    }];
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KScreenWidth, 50);
}

#pragma mark ————— 懒加载 —————
-(NSMutableArray*)dataSouce{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray new];
    }
    return _dataSouce;
}
#pragma mark ————— 方法 —————
-(void)alertMsg:(NSString*)msg cancelAction:(void (^)(UIAlertAction * _Nonnull action))cancel successAction:(void (^)(UIAlertAction * _Nonnull action))success{
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:cancel];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:success];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)loadData{
    [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        self.dataSouce = [NSMutableArray new];
        if(ValidArray([dic objectForKey:@"data"])){
            NSArray *arr = [dic objectForKey:@"data"];
            for (int i = 0; i < arr.count; i++) {
                [self.dataSouce addObject:[arr objectAtIndex:i]];
            }
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void) cellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
        NSDictionary *dic = [self.dataSouce objectAtIndex:indexPath.section];
        [self alertMsg:@"确定要删除此情景吗？" cancelAction:^(UIAlertAction * _Nonnull action) {
            
        } successAction:^(UIAlertAction * _Nonnull action) {
            NSDictionary *params = @{@"scene_id":[dic objectForKey:@"id"]};
            [[APIManager sharedManager]deviceDeleteSceneWithParameters:params success:^(id data) {
                NSDictionary *dataDic = data;
                if ([[dataDic objectForKey:@"code"] integerValue] == 200) {
                    [MBProgressHUD showErrorMessage:[dataDic objectForKey:@"msg"]];
                    [self loadData];
                }else{
                    [MBProgressHUD showErrorMessage:[dataDic objectForKey:@"msg"]];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showErrorMessage:@"服务器错误"];
            }];
        }];
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"长按手势改变，发生长按拖拽动作执行该方法");
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"长按手势结束");
    }
}

- (void)createLongPressGesture{
    //创建长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(cellLongPressed:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [self.collectionView addGestureRecognizer:longPress];
}

-(NSString*)getStr:(NSArray*)arr{
    NSString *str = @"";
    if (arr == nil) {
        return str;
    }
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = [arr objectAtIndex:i];
        CGFloat type = [[dic objectForKey:@"type"] integerValue];
        NSString *strTemp = @"";
        if (type == 33111) {
            NSArray *value = [dic objectForKey:@"value"];
            NSDictionary *startTime = [value objectAtIndex:0];
            NSDictionary *endTime = [value objectAtIndex:1];
            strTemp = [NSString stringWithFormat:@"开始:%@:%@ 结束:%@:%@",[startTime objectForKey:@"h"],[startTime objectForKey:@"mi"],[endTime objectForKey:@"h"],[endTime objectForKey:@"mi"]];
            str = [str stringByAppendingString:strTemp];
        }
    }
    return str;
}

-(void)swtClick:(UISwitch*)swt{
    CGFloat tag = swt.tag;
    NSMutableDictionary *dic = [self.dataSouce objectAtIndex:tag];
    NSString *enable = @"";
    if (swt.on == YES) {
        enable = @"2";
        [swt setOn:NO animated:YES];
    }else{
        enable = @"1";
        [swt setOn:YES animated:YES];
    }
    NSDictionary *params = @{
                             @"scene_id":[dic objectForKey:@"id"],
                             @"name" : [dic objectForKey:@"name"],
                             @"icon" : [dic objectForKey:@"icon"],
                             @"condition" : [dic objectForKey:@"condition"],
                             @"action" : [dic objectForKey:@"action"],
                             @"message" : [dic objectForKey:@"message"],
                             @"is_push" : [dic objectForKey:@"is_push"],
                             @"enable" : enable
                             };
    [[APIManager sharedManager]deviceEditSceneWithParameters:params success:^(id data) {
        if ([[data objectForKey:@"code"] integerValue] == 200) {
            [MBProgressHUD showSuccessMessage:[data objectForKey:@"msg"]];
        }else{
            [MBProgressHUD showErrorMessage:[data objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"服务器异常"];
    }];
//    DLog(@"params:%@",params);
//    [dic removeObjectForKey:@"enable"];
//    DLog(@"dic:%@",dic);
//    [dic setObject:enable forKey:@"enable"];
//    DLog(@"dic:%@",dic);
//    [dic setObject:enable forKey:@"enable"];
//    DLog(@"dic:%@",dic);
}
-(void)naviBtnClick:(UIButton*)btn{
    CGFloat tag = btn.tag;
    if (tag == 1000) {
        AddSceneViewController *vc = [[AddSceneViewController alloc]init];
        [self pushViewController:vc];
    }
    
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
