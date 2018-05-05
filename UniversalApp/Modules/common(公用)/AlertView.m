//
//  AlertView.m
//  MMPopupView
//
//  Created by wjy on 2018/5/4.
//  Copyright © 2018年 LJC. All rights reserved.
//

#import "AlertView.h"
#import "MMPopupItem.h"
//#import <Masonry/Masonry.h>
@interface AlertView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UILabel     *lblStatus;
@property (nonatomic, strong) NSArray     *actionItems;
@end
@implementation AlertView

- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items
{
    self = [super init];
    if ( self )
    {
        self.type = MMPopupTypeCustom;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat height = 300;
            if (items.count < 5) {
                height = (items.count + 1) * 50;
            }
            make.size.mas_equalTo(CGSizeMake(280, height));
        }];
        
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
        
        self.lblStatus = [UILabel new];
        [self.backView addSubview:self.lblStatus];
        [self.lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.backView).insets(UIEdgeInsetsMake(0, 19, 0, 19));
            make.height.equalTo(@50);
        }];
        self.lblStatus.textColor = [UIColor whiteColor];
        self.lblStatus.font = [UIFont boldSystemFontOfSize:17];
        self.lblStatus.text = title;
        self.lblStatus.textAlignment = NSTextAlignmentCenter;
        
        self.tableView = [UITableView new];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(52, 0, 0, 0));
        }];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    self.actionItems = items;
    [self.tableView reloadData];
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    //分割线补全
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(20, 0, 100, 40);
    MMPopupItem *item = self.actionItems[indexPath.row];
    label.text = item.title;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(240 - 30, 10, 10, 20)];
    imageView.image = [UIImage imageNamed:@"in_arrow_right"];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self action:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)action:(NSUInteger)index;
{
    MMPopupItem *item = self.actionItems[index];
    [self hide];
    if ( item.handler )
    {
        item.handler(index);
    }
}

-(NSArray*)actionItems{
    if (_actionItems == nil) {
        _actionItems = [NSArray new];
    }
    return _actionItems;
}
@end
