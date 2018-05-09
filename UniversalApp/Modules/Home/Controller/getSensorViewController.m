//
//  getSensorViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/5.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "getSensorViewController.h"
#import <MMAlertView.h>
static NSString *identifier = @"cellID";
@interface getSensorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation getSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    self.title = @"选择情景";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTabBarHeight);
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

#pragma dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.contentView removeAllSubviews];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(20, 5, 40, 40);
    imageView.image = [UIImage imageNamed:[[Picture sharedPicture]geticonTostr:[dic objectForKey:@"icon"]]];
    
    UILabel *textLabel = [UILabel new];
    textLabel.frame = CGRectMake(imageView.right + 10, cell.contentView.top + 5, KScreenWidth - imageView.right - 10, 12);
    textLabel.font = SYSTEMFONT(12);
    textLabel.text = [dic objectForKey:@"name"];
    
    UILabel *centerLabel = [UILabel new];
    centerLabel.frame = CGRectMake(imageView.right + 10, textLabel.bottom + 3, KScreenWidth - imageView.right - 10, 8);
    centerLabel.font = SYSTEMFONT(8);
    centerLabel.text = [dic objectForKey:@"name"];
    
    UILabel *lastLabel = [UILabel new];
    lastLabel.frame = CGRectMake(imageView.right + 10, centerLabel.bottom + 3, KScreenWidth - imageView.right - 10, 8);
    lastLabel.font = SYSTEMFONT(8);
    lastLabel.text = [dic objectForKey:@"name"];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:textLabel];
    [cell.contentView addSubview:centerLabel];
    [cell.contentView addSubview:lastLabel];
    return cell;
}

#pragma dalegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataSource[indexPath.row];
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"scene_id":[dic objectForKey:@"id"],
                             @"order":@"0"
                             };
    [[APIManager sharedManager]deviceAddSceneShortcutWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        if ([[datadic objectForKey:@"code"] intValue] == 200) {
            [MBProgressHUD showSuccessMessage:[datadic objectForKey:@"msg"]];
            [self backBtnClicked];
        }else{
            [MBProgressHUD showErrorMessage:[datadic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"服务器错误"];
    }];
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
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
