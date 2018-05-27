//
//  BrandDevicesModel.h
//  UniversalApp
//
//  Created by wjy on 2018/5/27.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandDevicesModel : NSObject
@property (nonatomic, copy) NSString *rid;

@property (nonatomic, assign) float v;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) float t;

@property (nonatomic, copy) NSString *be_rmodel;

@property (nonatomic, copy) NSString *rmodel;

@property (nonatomic, copy) NSString *rdesc;

@property (nonatomic, assign) float order_no;

@property (nonatomic, assign) float zip;

@property (nonatomic, copy) NSDictionary *rc_command;
@end
