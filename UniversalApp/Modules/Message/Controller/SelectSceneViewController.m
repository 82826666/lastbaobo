//
//  HouseViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "SelectSceneViewController.h"
#import <MMAlertView.h>
#import "KeyViewController.h"
#import "AddSceneViewController.h"
static NSString *identifier = @"cellID";
@interface SelectSceneViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
}
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation SelectSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    self.title = @"选择情景";
    
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 55);
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:self.collectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:[dic objectForKey:@"icon1"]]];
    imageView.frame = CGRectMake(20, cell.top + 10, 30, 30);
    
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, cell.top + 10, KScreenWidth - imageView.right - 10, 30)];
    name.text = [dic objectForKey:@"name1"];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:name];
    
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AddSceneViewController class]]) {
            AddSceneViewController *con1 = (AddSceneViewController*)controller;
            [con1 setThenDic:dic];
            [self pushViewController:con1];
        }
    }
    //    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KScreenWidth,50);
}

#pragma mark ————— 懒加载 ————-
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据加载
-(void)loadData{
    NSDictionary *params = @{@"master_id":GET_USERDEFAULT(MASTER_ID)};
    [[APIManager sharedManager]deviceGetDevidWithParameters:params success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *one = @{
                                  @"type":@"310110",
                                  @"icon1":@"in_scene_select_hand",
                                  @"name1":@"本情景",
                                  @"status":@"0",
                                  @"devid":[dic objectForKey:@"data"][0]
                                  };
            [self.dataSource addObject:one];
            [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
                NSDictionary *dicd = data;
                if ([[dicd objectForKey:@"code"]integerValue] == 200){
                    NSArray *arr = [dicd objectForKey:@"data"];
                    for (int i = 0; i < arr.count; i ++) {
                        NSDictionary *dicOne = [arr objectAtIndex:i];
                        [self.dataSource addObject:dicOne];
                    }
                }else{
                    [MBProgressHUD showErrorMessage:[dicd objectForKey:@"msg"]];
                }
                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            } failure:^(NSError *error) {
                
            }];
//            [[APIManager sharedManager]deviceGetSceneListsWithParameters:params success:^(id data) {
//                NSDictionary *dicd = data;
//                DLog(@"pag:%@",self.dataSource);
//                if ([[dicd objectForKey:@"code"]integerValue] == 200){
//                    NSArray *arr = [dicd objectForKey:@"data"];
//                    for (int i = 0; i < arr.count; i ++) {
//                        NSDictionary *dicOne = [arr objectAtIndex:i];
//                        [self.dataSource addObject:dicOne];
//                    }
//                }else{
//                    [MBProgressHUD showErrorMessage:[dicd objectForKey:@"msg"]];
//                }
//                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//            } failure:^(NSError *error) {
//                DLog(@"dsfa")
//            }];
        }else{
        }
    } failure:^(NSError *error) {
        
    }];
}

@end



