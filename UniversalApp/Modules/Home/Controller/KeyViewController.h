//
//  KeyViewController.h
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "RootViewController.h"
typedef NS_ENUM(NSUInteger, setNum) {
    setNumOne=1,
    setNumTwo = 2,
    setNumThree = 3,
    setNumFour = 4
};
@interface KeyViewController : RootViewController
@property (nonatomic) setNum setNum;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSString *mac;
@property (nonatomic,strong) NSString *title;
@end
