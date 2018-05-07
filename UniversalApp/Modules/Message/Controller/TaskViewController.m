//
//  TaskViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/26.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "TaskViewController.h"
#import "AddDelayedViewController.h"
#import "SelectTaskDeviceViewController.h"
#import "SelectSceneViewController.h"
@interface TaskViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property(nonatomic, strong) NSMutableArray* dataSouce;
@property(nonatomic, strong) UIColor *backColor;

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 60) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.backColor;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    [self initDataSouce];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableView datasouce
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
        cell.backgroundColor = self.backColor;
    }
    NSDictionary *data = _dataSouce[indexPath.row];
    //设置图像
    [cell.imageView setImage:[UIImage imageNamed:[data objectForKey:@"img"]]];
    //设置主标题
    cell.textLabel.text = [data objectForKey:@"title"];
    //设置字体颜色
    cell.textLabel.textColor = [UIColor orangeColor];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
    return view;
}

#pragma mark tableView dalegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        AddDelayedViewController *controller = [[AddDelayedViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if (indexPath.row == 1){
        SelectTaskDeviceViewController *controller = [[SelectTaskDeviceViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if (indexPath.row == 2){
        SelectSceneViewController *controller = [[SelectSceneViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 懒加载
- (UIColor*)backColor{
    if(!_backColor){
        _backColor = [UIColor colorWithRed:233/255.0 green:241/255.0 blue:245/255.0 alpha:1];
    }
    return _backColor;
}

#pragma mark 数据源
- (void)initDataSouce{
    if(_dataSouce == nil){
        NSDictionary *one = @{@"img":@"in_scene_select_default",@"title":@"时间延时"};
        NSDictionary *two = @{@"img":@"in_equipment_sensor_default",@"title":@"执行设备"};
        NSDictionary *three = @{@"img":@"in_scene_select_hand",@"title":@"情景启用、禁用"};
        _dataSouce = [[NSMutableArray alloc]initWithObjects:one,two,three,nil];
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
