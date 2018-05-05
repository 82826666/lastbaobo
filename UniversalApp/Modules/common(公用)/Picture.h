//
//  Picture.h
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

+ (Picture *)sharedPicture;

-(NSString*)geticonTostr:(NSString *)type1;

/**
 * 根据设备类型 获取该类型的图标
 *
 * @param type1
 *            设备类型
 * @return 设备类型图标
 */
-(NSString *)getDeviceIconForType:(NSString *)type1;
/**
 * 根据设备类型 获取该类型的名称
 *
 * @param type1
 *            设备类型
 * @return 设备名称
 */
-(NSString*)getDeviceNameForType:(NSString *)type1;
@end
