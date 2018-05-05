//
//  Picture.m
//  UniversalApp
//
//  Created by wjy on 2018/5/3.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "Picture.h"

@implementation Picture

+ (Picture *)sharedPicture
{
    static Picture *_Picture = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _Picture = [[self alloc] init];
    });
    
    return _Picture;
}
-(NSString*)geticonTostr:(NSString *)type1 {
    NSString *DeviceIcon;
    NSString *type = [NSString stringWithFormat:@"%@",type1];
    if([type isEqualToString:@"101"]){
        DeviceIcon = @"in_select_switch_one";
    }else if ([type isEqualToString:@"102"]) {
        DeviceIcon = @"in_select_switch_two";
    } else if ([type isEqualToString:@"103"]) {
        DeviceIcon = @"in_select_switch_three";
    } else if ([type isEqualToString:@"104"]) {
        DeviceIcon = @"in_select_switch_four";
    } else if ([type isEqualToString:@"105"]) {
        DeviceIcon = @"ic_launcher";
    } else if ([type isEqualToString:@"106"]) {
        DeviceIcon = @"ic_launcher";
    } else if ([type isEqualToString:@"107"]) {
        DeviceIcon = @"ic_launcher";
    } else if ([type isEqualToString:@"108"]) {
        DeviceIcon = @"ic_launcher";
    } else if ([type isEqualToString:@"109"]) {
        DeviceIcon = @"ic_launcher";
    } else if ([type isEqualToString:@"2001"]) {// 摄像头
        DeviceIcon = @"in_camera_select_nightvision";
    } else if ([type isEqualToString:@"2002"]) {// 摄像头
        DeviceIcon = @"in_camera_equipment_outdoor";
    } else if ([type isEqualToString:@"2003"]) {// 摄像头
        DeviceIcon = @"in_camera_equipment_indoor";
    } else if ([type isEqualToString:@"2004"]) {// 摄像头
        DeviceIcon = @"in_camera_equipment_nightvision";
    } else if ([type isEqualToString:@"2005"]) {// 摄像头
        DeviceIcon = @"in_camera_select_indoor";
    } else if ([type isEqualToString:@"2006"]) {// 摄像头
        DeviceIcon = @"in_camera_select_outdoor";
    } else if ([type isEqualToString:@"1001"]) {// 灯类 默认
        DeviceIcon = @"lamp10";
    } else if ([type isEqualToString:@"106"]) {// 灯类 壁灯
        DeviceIcon = @"lamp2";
    } else if ([type isEqualToString:@"1004"]) {// 灯类 吸顶灯1
        DeviceIcon = @"lamp3";
    } else if ([type isEqualToString:@"1009"]) {// 灯类 节能灯
        DeviceIcon = @"lamp4";
    } else if ([type isEqualToString:@"1011"]) {// 灯类 射灯
        DeviceIcon = @"lamp5";
    } else if ([type isEqualToString:@"1010"]) {// 灯类 LED
        DeviceIcon = @"lamp6";
    } else if ([type isEqualToString:@"1007"]) {// 灯类 床头灯
        DeviceIcon = @"lamp7";
    } else if ([type isEqualToString:@"1012"]) {// 灯类 浴灯
        DeviceIcon = @"lamp8";
    } else if ([type isEqualToString:@"1002"]) {// 灯类 吊灯1
        DeviceIcon = @"lamp1";
    } else if ([type isEqualToString:@"1008"]) {// 灯类 白炽灯
        DeviceIcon = @"lamp11";
    } else if ([type isEqualToString:@"3001"]) {// 情景图标
        DeviceIcon = @"sceneicon";
    } else if ([type isEqualToString:@"3002"]) {// 情景图标
        DeviceIcon = @"in_scene_select_hand";
    } else if ([type isEqualToString:@"3003"]) {// 情景图标
        DeviceIcon = @"in_scene_select_default";
    } else if ([type isEqualToString:@"3004"]) {// 情景图标
        DeviceIcon = @"in_scene_select_leavehome";
    } else if ([type isEqualToString:@"3005"]) {// 情景图标
        DeviceIcon = @"in_scene_select_gohome";
    } else if ([type isEqualToString:@"3006"]) {// 情景图标
        DeviceIcon = @"in_scene_select_safety";
    } else if ([type isEqualToString:@"3007"]) {// 情景图标
        DeviceIcon = @"in_scene_select_startsafety";
    } else if ([type isEqualToString:@"3008"]) {// 情景图标
        DeviceIcon = @"in_scene_select_closesafety";
    } else if ([type isEqualToString:@"3009"]) {// 情景图标
        DeviceIcon = @"in_scene_select_getup";
    } else if ([type isEqualToString:@"3010"]) {// 情景图标
        DeviceIcon = @"in_scene_select_sleep";
    } else if ([type isEqualToString:@"3011"]) {// 情景图标
        DeviceIcon = @"in_scene_select_orther";
    } else if ([type isEqualToString:@"12411"]) {// 有线电视机顶盒 红外设备（家电）图标
        DeviceIcon = @"ic_in_cabletv";
    } else if ([type isEqualToString:@"12311"]) {// 电视
        DeviceIcon = @"ic_in_tv";
    } else if ([type isEqualToString:@"12511"]) {// DVD播放机
        DeviceIcon = @"ic_in_dvd";
    } else if ([type isEqualToString:@"12611"]) {// 投影仪
        DeviceIcon = @"ic_in_projector";
    } else if ([type isEqualToString:@"12711"]) {// 风扇
        DeviceIcon = @"ic_in_iptv";// 错误图标
    } else if ([type isEqualToString:@"12211"]) {// 空调
        DeviceIcon = @"ic_in_air";
    } else if ([type isEqualToString:@"12911"]) {// 射频RF类 默认图标
        DeviceIcon = @"in_select_switch_one";
    } else if ([type isEqualToString:@"12921"]) {// 射频RF类 车库门图标
        DeviceIcon = @"lamp2";
    } else if ([type isEqualToString:@"12931"]) {// 射频RF类 灯图标
        DeviceIcon = @"lamp10";
    } else if ([type isEqualToString:@"12941"]) {// 射频RF类 窗帘图标
        DeviceIcon = @"in_equipment_curtain_default";
    } else if ([type isEqualToString:@"12951"]) {// 射频RF类 智能衣架图标
        DeviceIcon = @"lamp11";
    } else if ([type isEqualToString:@"12961"]) {// 射频RF类 其他
        DeviceIcon = @"lamp4";
    } else if ([type isEqualToString:@"6001"]) {// 默认传感器
        DeviceIcon = @"in_equipment_sensor_default";
    } else if ([type isEqualToString:@"6002"]) {// 其他传感器
        DeviceIcon = @"in_equipment_sensor_pushwindow";
    } else if ([type isEqualToString:@"20211-on"]) {// 调光开关的 开/关图标
        DeviceIcon = @"in_light1";
    }else if ([type isEqualToString:@"20211-open"]) {// 卷帘开关的 开图标
        DeviceIcon = @"in_curtain_up1";
    } else if ([type isEqualToString:@"20211-close"]) {// 卷帘开关的 关图标
        DeviceIcon = @"in_curtain_down1";
    } else {
        DeviceIcon = @"";
    }
    
    return DeviceIcon;
    
}

/**
 * 根据设备类型 获取该类型的图标
 *
 * @param type1
 *            设备类型
 * @return 设备类型图标
 */
-(NSString *)getDeviceIconForType:(NSString *)type1 {
    NSString *DeviceIcon = @"ic_launcher";
    NSString *type = [NSString stringWithFormat:@"%@",type1];
    if ([type isEqualToString:@"20111"]) {
        DeviceIcon = @"in_select_switch_one";
    } else if ([type isEqualToString:@"20121"]) {
        DeviceIcon = @"in_select_switch_two";
    } else if ([type isEqualToString:@"20131"]) {
        DeviceIcon = @"in_select_switch_three";
    } else if ([type isEqualToString:@"20141"]) {
        DeviceIcon = @"in_select_switch_four";
    } else if ([type isEqualToString:@"20311"]) {// 窗帘
        DeviceIcon = @"in_equipment_curtain_default";
    } else if ([type isEqualToString:@"25111"]) {// 门磁
        DeviceIcon = @"in_equipment_sensor_induction";
    } else if ([type isEqualToString:@"25211"]) {//
        DeviceIcon = @"in_equipment_sensor_infrared";
    } else if ([type isEqualToString:@"25311"]) {//
        DeviceIcon = @"in_equipment_sensor_co";
    } else if ([type isEqualToString:@"25411"]) {//
        DeviceIcon = @"in_equipment_sensor_smoke";
    } else if ([type isEqualToString:@"25511"]) {//
        DeviceIcon = @"in_equipment_sensor_immersion";
    } else if ([type isEqualToString:@"25611"]) {//
        DeviceIcon = @"in_equipment_sensor_gas";
    } else if ([type isEqualToString:@"25711"]) {//
        DeviceIcon = @"in_equipment_sensor_temperature";
    } else if ([type isEqualToString:@"25811"]) {//
        DeviceIcon = @"in_equipment_sensor_induction";
    } else if ([type isEqualToString:@"25911"]) {// 门锁
        DeviceIcon = @"in_device_list_lock";
    } else if ([type isEqualToString:@"22111"]) {// 红外、射频转发
        DeviceIcon = @"pic5";//没有
    } else if ([type isEqualToString:@"27111"]) {// 摄像头
        DeviceIcon = @"in_camera_select_nightvision";
    } else if ([type isEqualToString:@"20811"]) {// 智能插座
        DeviceIcon = @"in_select_socket_default";
    } else if ([type isEqualToString:@"20821"]) {// 86插座
        DeviceIcon = @"in_equipment_socket_default";
    } else if ([type isEqualToString:@"20211"]) {// 1路调光开关
        DeviceIcon = @"in_device_list_aiming";
    } else if ([type isEqualToString:@"20411"]) {// 卷帘开关
        DeviceIcon = @"in_equipment_curtain_sunshade";
    }else if ([type isEqualToString:@"20511"]) {// 推窗器
        DeviceIcon = @"in_curtain_control_default";
    }else if ([type isEqualToString:@"20611"]) {// 百叶帘
        DeviceIcon = @"in_equipment_curtain_blind";
    }else if ([type isEqualToString:@"20711"]) {// 调色灯带
        DeviceIcon = @"pic1";//没有
    }else if ([type isEqualToString:@"20911"]) {// 机械手
        DeviceIcon = @"in_equipment_sensor_pushwindow";
    }
    
    return DeviceIcon;
    
}

/**
 * 根据设备类型 获取该类型的名称
 *
 * @param type1
 *            设备类型
 * @return 设备名称
 */
-(NSString*)getDeviceNameForType:(NSString *)type1 {
    NSString* DeviceName = @"";
    NSString* type = [NSString stringWithFormat:@"%@",type1];
    if ([type isEqualToString:@"20111"]) {
        DeviceName = @"一键开关";
    } else if ([type isEqualToString:@"20121"]) {
        DeviceName = @"二键开关";
    } else if ([type isEqualToString:@"20131"]) {
        DeviceName = @"三键开关";
    } else if ([type isEqualToString:@"20141"]) {
        DeviceName = @"四键开关";
    } else if ([type isEqualToString:@"20311"]) {
        DeviceName = @"单轨窗帘";
    } else if ([type isEqualToString:@"25111"]) {
        DeviceName = @"门磁";
    } else if ([type isEqualToString:@"25211"]) {
        DeviceName = @"红外感应";
    } else if ([type isEqualToString:@"25311"]) {
        DeviceName = @"一氧化碳";
    } else if ([type isEqualToString:@"25411"]) {
        DeviceName = @"烟雾";
    } else if ([type isEqualToString:@"25511"]) {
        DeviceName = @"水浸";
    } else if ([type isEqualToString:@"25611"]) {
        DeviceName = @"可燃气";
    } else if ([type isEqualToString:@"25711"]) {
        DeviceName = @"温湿度";
    } else if ([type isEqualToString:@"25811"]) {
        DeviceName = @"亮度";
    } else if ([type isEqualToString:@"101"]) {// 设备类
        DeviceName = @"亮度";
    } else if ([type isEqualToString:@"102"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"103"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"104"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"105"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"106"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"107"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"108"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"109"]) {
        DeviceName = @"";
    } else if ([type isEqualToString:@"2001"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"2002"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"2003"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"2004"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"2005"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"2006"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"1001"]) {// 灯类
        DeviceName = @"默认";
    } else if ([type isEqualToString:@"1006"]) {// 灯类
        DeviceName = @"壁灯";
    } else if ([type isEqualToString:@"1004"]) {// 灯类
        DeviceName = @"吸顶灯";
    } else if ([type isEqualToString:@"1009"]) {// 灯类
        DeviceName = @"节能灯";
    } else if ([type isEqualToString:@"1011"]) {// 灯类
        DeviceName = @"射灯";
    } else if ([type isEqualToString:@"1010"]) {// 灯类
        DeviceName = @"LED灯";
    } else if ([type isEqualToString:@"1007"]) {// 灯类
        DeviceName = @"床头灯";
    } else if ([type isEqualToString:@"1012"]) {// 灯类
        DeviceName = @"浴灯";
    } else if ([type isEqualToString:@"1002"]) {// 灯类
        DeviceName = @"吊灯";
    } else if ([type isEqualToString:@"1008"]) {// 灯类
        DeviceName = @"白炽灯";
    } else if ([type isEqualToString:@"3001"]) {// 情景图标
        DeviceName = @"默认";
    } else if ([type isEqualToString:@"3002"]) {// 情景图标
        DeviceName = @"手动";
    } else if ([type isEqualToString:@"3003"]) {// 情景图标
        DeviceName = @"定时";
    } else if ([type isEqualToString:@"3004"]) {// 情景图标
        DeviceName = @"离家";
    } else if ([type isEqualToString:@"3005"]) {// 情景图标
        DeviceName = @"回家";
    } else if ([type isEqualToString:@"3006"]) {// 情景图标
        DeviceName = @"安防";
    } else if ([type isEqualToString:@"3007"]) {// 情景图标
        DeviceName = @"布防";
    } else if ([type isEqualToString:@"3008"]) {// 情景图标
        DeviceName = @"撤防";
    } else if ([type isEqualToString:@"3009"]) {// 情景图标
        DeviceName = @"起床";
    } else if ([type isEqualToString:@"3010"]) {// 情景图标
        DeviceName = @"睡觉";
    } else if ([type isEqualToString:@"3011"]) {// 情景图标
        DeviceName = @"其他";
    } else if ([type isEqualToString:@"401"]) {// 有线电视机顶盒 红外设备（家电）图标
        
    } else if ([type isEqualToString:@"402"]) {// 电视
        
    } else if ([type isEqualToString:@"403"]) {// DVD播放机
        
    } else if ([type isEqualToString:@"405"]) {// 投影仪
        
    } else if ([type isEqualToString:@"406"]) {// 风扇
        
    } else if ([type isEqualToString:@"407"]) {// 空调
        
    }else if ([type isEqualToString:@"12911"]) {// 射频RF类 默认图标
        DeviceName =  @"射频遥控";
    }else if ([type isEqualToString:@"12921"]) {// 射频RF类 车库门图标
        DeviceName =  @"车库门";
    } else if ([type isEqualToString:@"12931"]) {// 射频RF类 灯图标
        DeviceName =  @"遥控灯";
    } else if ([type isEqualToString:@"12941"]) {// 射频RF类 窗帘图标
        DeviceName =  @"遥控窗帘";
    } else if ([type isEqualToString:@"12951"]) {// 射频RF类 智能衣架图标
        DeviceName =  @"智能衣架";
    } else if ([type isEqualToString:@"12961"]) {// 射频RF类 其他
        DeviceName = @"其他遥控";
    }  else if ([type isEqualToString:@"6001"]) {// 默认传感器
        DeviceName = @"默认传感器";
    } else if ([type isEqualToString:@"6002"]) {// 其他传感器
        DeviceName = @"其他传感器";
    } else if ([type isEqualToString:@"25911"]) {// 门锁
        DeviceName = @"门锁";
    } else if ([type isEqualToString:@"22111"]) {// 红外、射频转发
        DeviceName = @"红外/射频转发";
    } else if ([type isEqualToString:@"27111"]) {// 摄像头
        DeviceName = @"摄像头";
    } else if ([type isEqualToString:@"20811"]) {// 智能插座
        DeviceName = @"智能插座";
    } else if ([type isEqualToString:@"20821"]) {// 86插座
        DeviceName = @"86插座";
    } else if ([type isEqualToString:@"20211"]) {// 1路调光开关
        DeviceName = @"调光开关";
    }else if ([type isEqualToString:@"20411"]) {// 卷帘
        DeviceName = @"卷帘";
    }else if ([type isEqualToString:@"20511"]) {// 推窗器
        DeviceName = @"推窗器";
    }else if ([type isEqualToString:@"20611"]) {// 百叶帘
        DeviceName = @"百叶帘";
    }else if ([type isEqualToString:@"20711"]) {// 调色灯带
        DeviceName = @"调色灯";
    }else if ([type isEqualToString:@"20911"]) {// 机械手
        DeviceName = @"机械手";
    }
    
    return DeviceName;
    
}

@end
