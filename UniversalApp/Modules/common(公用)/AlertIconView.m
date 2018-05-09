//
//  AlertIcoView.m
//  UniversalApp
//
//  Created by wjy on 2018/5/5.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "AlertIconView.h"
@interface AlertIconView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UILabel     *lblStatus;
@property (nonatomic, strong) NSArray     *actionItems;
@property (nonatomic, strong) UIButton    *btnClose;
@end
static NSString *identifier = @"cellID";
@implementation AlertIconView

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeCustom;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat height = 250;
            make.size.mas_equalTo(CGSizeMake(280, height));
        }];
        
        self.withKeyboard = YES;
        
        self.backView = [UIView new];
        [self addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.backView.layer.cornerRadius = 5.0f;
        self.backView.clipsToBounds = YES;
        self.backView.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [UIView new];
        [self.backView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.height.equalTo(@50);
        }];
        view.backgroundColor = RGBA(58, 190, 217, 1.0);
        
        self.btnClose = [UIButton mm_buttonWithTarget:self action:@selector(actionClose)];
        [self.backView addSubview:self.btnClose];
        [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(5, 0, 0, 5));
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.btnClose setTitle:@"关闭" forState:UIControlStateNormal];
        [self.btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnClose.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.lblStatus = [UILabel new];
        [self.backView addSubview:self.lblStatus];
        [self.lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(0, 19, 0, 19));
            make.height.equalTo(@50);
        }];
        self.lblStatus.textColor = MMHexColor(0x333333FF);
        self.lblStatus.font = [UIFont boldSystemFontOfSize:17];
        self.lblStatus.text = title;
        self.lblStatus.textAlignment = NSTextAlignmentCenter;
        
        //注册cell
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(52, 0, 0, 0));
        }];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    self.actionItems = items;
    [self.collectionView reloadData];
    return self;
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.actionItems.count;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *dic = [self.actionItems objectAtIndex:indexPath.row];
    NSString *imageName = [[Picture sharedPicture]geticonTostr:[dic objectForKey:@"icon"]];
    NSString *nameStr = [[Picture sharedPicture]getDeviceNameForType:[dic objectForKey:@"icon"]];

    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:imageName]];
    imageView.image.accessibilityIdentifier = imageName;
    imageView.frame = CGRectMake(0, 15, 50, 50);
    imageView.centerX = cell.contentView.centerX;
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, KScreenWidth/4, 30)];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = nameStr;
    name.centerX = cell.contentView.centerX;
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:name];
    return cell;

}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self hide];
    if ([_delegate respondsToSelector:@selector(iconDidSelect:)]) {
        [_delegate iconDidSelect:[self.actionItems objectAtIndex:indexPath.row]];
    }
//    DLog(@"click");
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int itemW = (self.frame.size.width - (4 + 1)*10) / 4;
    return CGSizeMake(itemW, 100);
}

-(NSArray*)actionItems{
    if (_actionItems == nil) {
        _actionItems = [NSArray new];
    }
    return _actionItems;
}

- (void)actionClose{
    [self hide];
}
-(UICollectionView*)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
        
        _collectionView.dataSource = self;
        
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
