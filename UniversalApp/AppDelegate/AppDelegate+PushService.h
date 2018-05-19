//
//  AppDelegate+PushService.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/25.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
/**
 推送相关在这里处理
 */
@interface AppDelegate (PushService)<JPUSHRegisterDelegate>
//初始化极光推送
-(void)initPush:(NSDictionary *)launchOptions;
@end
