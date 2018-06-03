//
//  DeviceTypeViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/22.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "DeviceTypeViewController.h"
#import "SearchViewController.h"

@interface DeviceTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *dataSouce;
@end

@implementation DeviceTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    self.title = @"设备类型";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

//每组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSouce.count;
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"contactCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //2.如果没有找到，自己创建单元格对象
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSDictionary *data = _dataSouce[indexPath.row];
    //设置图像
    [cell.imageView setImage:[UIImage imageNamed:[data objectForKey:@"img"]]];
    //设置主标题
    cell.textLabel.text = [data objectForKey:@"name"];

    DLog(@"title:%@",[data objectForKey:@"title"]);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    return cell;
}

-(void)initData{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray new];
        [_dataSouce addObject:@{@"img":@"ic_in_air_rain",@"name":@"空调",@"t":@"7",@"type":@"12211",@"devid":[_dic objectForKey:@"id"]}];
        [_dataSouce addObject:@{@"img":@"ic_in_air_rain",@"name":@"电视",@"t":@"2",@"type":@"12311",@"devid":[_dic objectForKey:@"id"]}];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row = [_dataSouce objectAtIndex:indexPath.row];
    SearchViewController *search = [SearchViewController new];
    search.dic = row;
    [self pushViewController:search];
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
