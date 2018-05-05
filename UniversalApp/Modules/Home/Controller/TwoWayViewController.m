//
//  TwoWayViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "TwoWayViewController.h"
#import "KeyViewController.h"
static NSString *identifier = @"cellID";
@interface TwoWayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
}
@property(nonatomic, strong) NSMutableArray      *dataSource;

@end

@implementation TwoWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"智能搜索";
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

#pragma mark ————— 初始化页面 —————
-(void)setupUI{
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
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
    [imageView setImage:[UIImage imageNamed:[dic objectForKey:@"img"]]];
    imageView.frame = CGRectMake(0, 15, 50, 50);
    imageView.centerX = cell.contentView.centerX;
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, KScreenWidth/4, 30)];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = [dic objectForKey:@"title"];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:name];
    
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    CGFloat type = [[dic objectForKey:@"type"]integerValue];
    if (type == 20141) {
        KeyViewController *controller = [[KeyViewController alloc]init];
        controller.mac = [dic objectForKey:@"mac"];
        controller.setNum = 4;
        controller.title = [dic objectForKey:@"title"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int itemW = (self.view.frame.size.width - 5*10) / 4;
    return CGSizeMake(itemW, itemW / 0.68);
}

#pragma mark ————— 懒加载 —————
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark ————— 方法 —————
-(void)loadData{
    [[APIManager sharedManager]deviceGetMasterDevicesWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID),@"type":@"0"} success:^(id data) {
        NSDictionary *dic = data;
        if([[dic objectForKey:@"code"] integerValue] == 0){
            [MBProgressHUD showErrorMessage:[dic objectForKey:@"msg"]];
        }else{
            NSMutableArray *arr = [dic objectForKey:@"data"];
            for (int i=0; i < arr.count; i++) {
                NSMutableDictionary *one = [arr objectAtIndex:i];
                CGFloat type = [[one objectForKey:@"type"] integerValue];
                if(type < 65535){
                    NSString *type = [one objectForKey:@"type"];
                    NSDictionary *oneTemp = @{
                                              @"img":[[Picture sharedPicture]getDeviceIconForType:type],
                                              @"title":[[Picture sharedPicture]getDeviceNameForType:type],
                                              @"type":type,
                                              @"mac":[one objectForKey:@"mac"]
                                              };
                    [self.dataSource addObject:oneTemp];
                }
            }
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"服务器异常"];
    }];
}

@end
