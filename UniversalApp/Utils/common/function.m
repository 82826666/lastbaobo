//
//  function.m
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "function.h"

@implementation function
+ (function *)sharedManager
{
    static function *_function = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _function = [[self alloc] init];
    });
    
    return _function;
}

#pragma md5加密
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
#pragma 手机号验证
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma 字符串转字典
- (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

#pragma 格式化数据为json数据
-(NSString*)formatToJson:(id)datas{
    //    return [[[datas componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return jsonResult;
    //    NSData *data=[NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //    return jsonStr;
}
#pragma 获取imageView
-(UIImageView *)getImageView:(CGRect)rect imageName:(NSString*)imageName{
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.frame = rect;
    return imageView;
}
#pragma 获取label
-(UILabel*)getLabel:(CGRect)rect text:(NSString*)text{
    UILabel *label = [UILabel new];
    label.text = text;
    label.frame = rect;
    return label;
}
#pragma 获取btn
-(UIButton*)getBtn:(CGRect)rect{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    return button;
}
-(UIButton*)getBtn:(CGRect)rect imageName:(NSString*)imageName title:(NSString*)title{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = rect;
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button1 setTitle:title forState:UIControlStateNormal];
    return button1;
}
//获取rf client
-(NSString*)getRfClient:(NSString*)t v:(NSString*)v f:(NSString*)f bid:(NSString*)bid{
    NSString *time = [self getNowTimeTimestamp2];
    NSString *str = [NSString stringWithFormat:@"none%@%@%@%@%@",bid,t,v,f,time];
    NSString *md5 = [self md5:str];
    NSString *curr_code = @"";
    for (int i=0; i < 5; i++) {
        CGFloat _pow = 2<<i;
        NSString *string = md5;
        string = [string substringToIndex:_pow];
        string = [string substringFromIndex:_pow - 1];//截取掉下标2之前的字符串
        curr_code = [NSString stringWithFormat:@"%@%@",curr_code,string];
    }
    return [NSString stringWithFormat:@"%@_%@",time,curr_code];
}
-(NSString *)getNowTimeTimestamp2{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}
@end
