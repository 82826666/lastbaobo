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
#pragma 字符串转字典
- (NSArray *)stringToJSON:(NSString *)jsonStr;
#pragma 格式化数据为json数据
-(NSString*)formatToJson:(id)datas;
#pragma 获取imageView
-(UIImageView *)getImageView:(CGRect)rect imageName:(NSString*)imageName;
#pragma 获取label
-(UILabel*)getLabel:(CGRect)rect text:(NSString*)text;
#pragma 获取btn
-(UIButton*)getBtn:(CGRect)rect;
@end
