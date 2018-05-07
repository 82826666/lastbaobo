//
//  AddSceneViewController.h
//  UniversalApp
//
//  Created by wjy on 2018/5/7.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "RootViewController.h"

@interface AddSceneViewController : RootViewController
-(void)setIfDic:(NSDictionary *)ifDic row:(CGFloat)row;
-(void)setThenDic:(NSDictionary *)thenDic row:(CGFloat)row;
-(void)setThenDic:(NSDictionary *)thenDic;
@end
