//
//  humitureViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/12.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "humitureViewController.h"
static NSString *identifier = @"cellID";
@interface humitureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic, strong) MJRefreshNormalHeader *header;
@end

@implementation humitureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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
    self.title = @"温湿度";
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //设置顶部高度
    flow.headerReferenceSize = CGSizeMake(0, 50);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //创建网格对象
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-kNavBarHeight-10);
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
    
    //头部刷新
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    _header.automaticallyChangeAlpha = YES;
    _header.lastUpdatedTimeLabel.hidden = YES;
    self.collectionView.mj_header = _header;
}

-(void)headerRereshing{
//    [self.dataSource removeAllObjects];
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
    DLog(@"dic:%@",dic);
    CGFloat ch = [[dic objectForKey:@"ch"] integerValue];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    UILabel *timeLabel = [[function sharedManager]getLabel:CGRectMake(20, cell.contentView.top + 15, 200, 20) text:@"test"];
    UILabel *detailLabel = [[function sharedManager]getLabel:CGRectMake(timeLabel.right + 20, cell.contentView.top + 15, 100, 20) text:@"test"];
    UIView *line = [self getLine:CGRectMake(0, cell.contentView.bottom, KScreenWidth, 0.5)];
    CGFloat value = [[dic objectForKey:@"value"] doubleValue];
    CGFloat aa = value/ 100;
    if (ch == 1) {
        detailLabel.text = [NSString stringWithFormat:@"%.2f℃",aa];
    }else if (ch == 2){
        NSString *ext = @"%";
        detailLabel.text = [NSString stringWithFormat:@"%.2f%@",aa,ext];
    }
    [cell.contentView addSubview:timeLabel];
    [cell.contentView addSubview:detailLabel];
    [cell.contentView addSubview:line];
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
#pragma mark - 数据加载
-(void)loadData{
    [[APIManager sharedManager]deviceEquipmentReportLogWithParameters:@{@"device_id":[_dic objectForKey:@"id"],@"type":[_dic objectForKey:@"type"],@"num":@"10"} success:^(id data) {
        if ([[data objectForKey:@"code"] integerValue]== 200) {
            self.dataSource = [data objectForKey:@"data"];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        }else{
            [MBProgressHUD showErrorMessage:[data objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
