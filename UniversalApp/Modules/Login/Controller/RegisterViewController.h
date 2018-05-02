//
//  RegisterViewController.h
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "RootViewController.h"
typedef NS_ENUM(NSUInteger, setType) {
    Forget,
    Register,
};
@interface RegisterViewController : RootViewController
@property (nonatomic) setType setType;
@end
