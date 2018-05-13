//
//  MyViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/13.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation MyViewController

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
    self.title = @"我的";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kNavBarHeight - kTabBarHeight);
    self.tableView.estimatedSectionHeaderHeight = 20;
    [self.view addSubview:self.tableView];
}

#pragma mark - dataSource
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    [cell removeAllSubviews];
    //如果队列中没有该类型cell，则会返回nil，这个时候就需要自己创建一个cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    NSArray *arr = [self.dataSource objectAtIndex:indexPath.section];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    if (indexPath.section != 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
        cell.textLabel.text = [dic objectForKey:@"name"];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone; //不显示最右边的箭头
        cell.textLabel.text = [dic objectForKey:@"name"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.contentView.backgroundColor = KWhiteColor;
    UIView *line1 = [self getLine:CGRectMake(0, cell.contentView.top, KScreenWidth, 0.5)];
    UIView *line2 = [self getLine:CGRectMake(0, cell.contentView.bottom - 0.5, KScreenWidth, 0.5)];
    [cell.contentView addSubview:line1];
    [cell.contentView addSubview:line2];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 2;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

#pragma mark - dalegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        [self AlertWithTitle:nil message:@"确定要退出吗？" andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
            NSLog(@"%ld",index);
            if (index == 1) {
                [userManager logout:nil];
            }
        }];
    }
}

#pragma mark - dalegate
-(NSMutableArray*)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
        [_dataSource addObject:@[@{@"icon":@"in_setup_personal",@"name":@"个人中心"},@{@"icon":@"in_setup_member",@"name":@"成员管理"},@{@"icon":@"in_setup_host",@"name":@"主机管理"},@{@"icon":@"in_setup_region",@"name":@"区域管理"}]];
        [_dataSource addObject:@[@{@"icon":@"in_setup_help",@"name":@"使用帮助"},@{@"icon":@"in_setup_more",@"name":@"更多设备"}]];
        [_dataSource addObject:@[@{@"icon":@"in_setup_about",@"name":@"关于我们"}]];
        [_dataSource addObject:@[@{@"icon":@"",@"name":@"退出登录"}]];
    }
    return _dataSource;
}
@end
