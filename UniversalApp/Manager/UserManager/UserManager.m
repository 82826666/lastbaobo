//
//  UserManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/22.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "UserManager.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager);

-(instancetype)init{
    self = [super init];
    if (self) {
        //被踢下线
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKick)
                                                     name:KNotificationOnKick
                                                   object:nil];
    }
    return self;
}

#pragma mark ————— 三方登录 —————
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark ————— 带参数登录 —————
-(void)login:(UserLoginType )loginType params:(NSDictionary *)params completion:(loginBlock)completion{
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == kUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    }else if (loginType == kUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    }else{
        platFormType = UMSocialPlatformType_UnKnown;
    }
    //第三方登录
    if (loginType != kUserLoginTypePwd) {
        [MBProgressHUD showActivityMessageInView:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                
                UMSocialUserInfoResponse *resp = result;
//                
//                // 授权信息
//                NSLog(@"QQ uid: %@", resp.uid);
//                NSLog(@"QQ openid: %@", resp.openid);
//                NSLog(@"QQ accessToken: %@", resp.accessToken);
//                NSLog(@"QQ expiration: %@", resp.expiration);
//                
//                // 用户信息
//                NSLog(@"QQ name: %@", resp.name);
//                NSLog(@"QQ iconurl: %@", resp.iconurl);
//                NSLog(@"QQ gender: %@", resp.unionGender);
//                
//                // 第三方平台SDK源数据
//                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                
                //登录参数
                NSDictionary *params = @{@"openid":resp.openid, @"nickname":resp.name, @"photo":resp.iconurl, @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2, @"cityname":resp.originalResponse[@"city"], @"fr":@(loginType)};
                
                self.loginType = loginType;
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    }else{
        [[APIManager sharedManager] loginWithParameters:params success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
            BOOL isSuccess = NO;
            NSString *msg;
            if ([[datadic objectForKey:@"code"] intValue] != 200) {
                //请求失败
                msg = [datadic objectForKey:@"msg"];
            }else{
                NSMutableArray *mas = [[datadic objectForKey:@"data"] objectForKey:@"master"];
//                DLog(@"master:%@",mas);
                NSString* master_id = @"";
                NSDictionary* master = [NSDictionary new];
                if (ValidArray(mas)) {
                    for (int i=0; i < mas.count; i++) {
                        master = [mas objectAtIndex:i];
                        if ([[master objectForKey:@"present"] integerValue] == 1) {
                            master_id = [master objectForKey:@"master_id"];
                            break;
                        }
                    }
                }else{
                    master_id = @"0";
                }
                NSDictionary* user_info = [[datadic objectForKey:@"data"] objectForKey:@"user"];
                //本地存储用户名以及相关数据
                NSString* user_id = [user_info objectForKey:@"userid"];
                NSString* user_token = [user_info objectForKey:@"token"];
                SET_USERDEFAULT(USER_ID, user_id);
                SET_USERDEFAULT(USER_TOKEN, user_token);
                SET_USERDEFAULT(USER_INFO, user_info);
                SET_USERDEFAULT(MASTER_ID, master_id);
                SET_USERDEFAULT(MASTER, mas);
                USERDEFAULT_SYN();
                [self initJupsh];
                isSuccess = YES;
                msg = [datadic objectForKey:@"msg"];
                self.curUserInfo = [UserInfo modelWithDictionary:data];
                [self saveUserInfo];
                self.isLogined = YES;
            }
            if (completion) {
                completion(isSuccess, msg);
            }
        } failure:^(NSError *error) {
            if (completion) {
                completion(NO, @"服务器异常");
            }
        }];
    }
}

#pragma mark ————— 手动登录到服务器 —————
-(void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
    [MBProgressHUD showActivityMessageInView:@"登录中..."];
    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_login) parameters:params success:^(id responseObject) {
        [self LoginSuccess:responseObject completion:completion];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if (completion) {
            completion(NO,error.localizedDescription);
        }
    }];
}

#pragma mark ————— 自动登录到服务器 —————
-(void)autoLoginToServer:(loginBlock)completion{
//    [PPNetworkHelper POST:NSStringFormat(@"/user/index/sendCode",URL_main) parameters:nil success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 登录成功处理 —————
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
    if (ValidDict(responseObject)) {
        if (ValidDict(responseObject[@"data"])) {
            NSDictionary *data = responseObject[@"data"];
            if (ValidStr(data[@"imId"]) && ValidStr(data[@"imPass"])) {
                //登录IM
                [[IMManager sharedIMManager] IMLogin:data[@"imId"] IMPwd:data[@"imPass"] completion:^(BOOL success, NSString *des) {
                    [MBProgressHUD hideHUD];
                    if (success) {
                        self.curUserInfo = [UserInfo modelWithDictionary:data];
                        [self saveUserInfo];
                        self.isLogined = YES;
                        if (completion) {
                            completion(YES,nil);
                        }
                        KPostNotification(KNotificationLoginStateChange, @YES);
                    }else{
                        if (completion) {
                            completion(NO,@"IM登录失败");
                        }
                        KPostNotification(KNotificationLoginStateChange, @NO);
                    }
                }];
            }else{
                if (completion) {
                    completion(NO,@"登录返回数据异常");
                }
                KPostNotification(KNotificationLoginStateChange, @NO);
            }
            
        }
    }else{
        if (completion) {
            completion(NO,@"登录返回数据异常");
        }
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
    
}
#pragma mark ————— 储存用户信息 —————
-(void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
    
}
#pragma mark ————— 加载缓存的用户信息 —————
-(BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    NSDictionary * userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    return NO;
}

#pragma mark ————— 被踢下线 —————
-(void)onKick{
    [self logout:nil];
}
#pragma mark ————— 退出登录 —————
- (void)logout:(void (^)(BOOL, NSString *))completion{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLogout object:nil];//被踢下线通知用户退出直播间
    
    [[IMManager sharedIMManager] IMLogout];
    
    self.curUserInfo = nil;
    self.isLogined = NO;

//    //移除缓存
    YYCache *cache = [[YYCache alloc]initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    [self clearAllUserDefaultsData];
    KPostNotification(KNotificationLoginStateChange, @NO);
}

/*清除所有的存储本地的数据*/
-(void)clearAllUserDefaultsData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}
/*设置极光推送别名*/
-(void)initJupsh{
    [JPUSHService setAlias:[NSString stringWithFormat:@"%@",GET_USERDEFAULT(USER_ID)] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"code:%ld content:%@ seq:%ld",iResCode,iAlias,seq);
    } seq:0];
}
@end
