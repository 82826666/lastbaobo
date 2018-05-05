//
//  getSensorViewController.m
//  UniversalApp
//
//  Created by wjy on 2018/5/5.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "getSensorViewController.h"
static NSString *identifier = @"cellID";
@interface getSensorViewController ()

@end

@implementation getSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择情景";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self.view addSubview:self.collectionView];
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
