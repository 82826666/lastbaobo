//
//  function.h
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface function : NSObject
+ (function *)sharedManager;
#pragma md5加密
- (NSString *) md5:(NSString *) input;
#pragma 手机号验证
- (BOOL)validateMobile:(NSString *)mobileNum;
@end
