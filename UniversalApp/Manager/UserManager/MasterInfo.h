//
//  MasterInfo.h
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MasterInfo : NSObject
@property(nonatomic,assign) long long master_id;//
@property(nonatomic,assign) NSString* master_name;//
@property(nonatomic,assign) long long onenet_id;//
@property (nonatomic,assign) NSString*  mac;//
@property (nonatomic,assign) NSInteger online;
@property (nonatomic,assign) NSString* remark;
@property (nonatomic,assign) NSInteger present;
@property (nonatomic,assign) NSString* add_time;
@property(nonatomic,assign) long long access;//

@end
