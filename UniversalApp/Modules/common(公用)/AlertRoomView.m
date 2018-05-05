//
//  AlertRoomView.m
//  UniversalApp
//
//  Created by wjy on 2018/5/5.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "AlertRoomView.h"
#import <MMAlertView.h>
@interface AlertRoomView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UILabel     *lblStatus;
@property (nonatomic, strong) NSMutableArray     *actionItems;
@property (nonatomic, strong) UIButton    *btnClose;
@end

@implementation AlertRoomView

- (instancetype)init
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
        [self.btnClose setTitle:@"添加" forState:UIControlStateNormal];
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
        self.lblStatus.text = @"房间选择";
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
    [self loadData];
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
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cell.bottom, KScreenWidth, 0.5)];
//    line.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(20, 0, 100, 40);
    NSDictionary *dic = self.actionItems[indexPath.row];
    label.text = [dic objectForKey:@"name"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(240, 10, 10, 20)];
    imageView.image = [UIImage imageNamed:@"in_arrow_right"];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:label];
//    [cell.contentView addSubview:line];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(roomDidSelect:)]) {
        [_delegate roomDidSelect:[self.actionItems objectAtIndex:indexPath.row]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSMutableArray*)actionItems{
    if (_actionItems == nil) {
        _actionItems = [NSMutableArray new];
    }
    return _actionItems;
}

- (void)actionClose
{
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
//        NSLog(@"animation complete");
    };
    MMAlertView *alertView = [[MMAlertView alloc] initWithInputTitle:@"区域名称" detail:@"" placeholder:@"请输入区域名称" handler:^(NSString *text) {
//        DLog(@"test:%@",text);
        if ([text isEqualToString:@""]) {
            
        }else{
            NSDictionary *params = @{
                                     @"master_id":GET_USERDEFAULT(MASTER_ID),
                                     @"name":text,
                                     @"order":@"1"
                                     };
//            DLog(@"params:%@",params);
            [[APIManager sharedManager]deviceAddMasterRoomWithParameters:params success:^(id data) {
//                DLog(@"data:%@",data);
                if ([[data objectForKey:@"code"] integerValue] == 200) {
                    [MBProgressHUD showTopTipMessage:[data objectForKey:@"msg"] isWindow:YES];
                    [self loadData];
                }else{
//                    DLog(@"msg:%@",[data objectForKey:@"msg"]);
                    [MBProgressHUD showTopTipMessage:[data objectForKey:@"msg"] isWindow:YES];
//                    [MBProgressHUD showErrorMessage:[data objectForKey:@"msg"]];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showErrorMessage:@"服务器异常"];
            }];
        }
    }];
//    alertView.attachedView = self;
//    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleExtraLight;
    [alertView showWithBlock:completeBlock];
    
    
}

-(void)loadData{
    [[APIManager sharedManager]deviceGetMasterRoomWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"]integerValue] == 200) {
            self.actionItems = [dic objectForKey:@"data"];
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
