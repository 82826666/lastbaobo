//
//  APIManager.m
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (APIManager *)sharedManager
{
    static APIManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (NSString*)getPathWithInterface:(NSString*)str
{
    NSString *path = [NSString stringWithFormat:@"%@%@",URL_main,str];
    return path;
}

+ (void)initialize {
    //关闭加密模式
    [PPNetworkHelper closeAES];
}
#pragma mark 短信获取
- (void)sendCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/user/index/sendCode"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 用户注册
- (void)registerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/register"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 用户登录
- (void)loginWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/login"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 忘记密码
- (void)forgetpwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/forgetpwd"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加RF主机接口
- (void)deviceRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/register"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改主机名称
- (void)deviceEditMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/edit_master"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取主机IP
- (void)deviceGetIpWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_ip"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取服务器时间
- (void)deviceTimeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/time"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取天气
- (void)deviceWeatherWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/weather"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取房间
- (void)deviceGetMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_master_room"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 查询主机是否在线
- (void)deviceGetMasterStatusWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_master_status"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark onenet发送命令接口
- (void)deviceCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/cmds"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 单项设备添加
- (void)deviceAddOnewayDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/add_oneway_device"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取设备列表
- (void)deviceGetDeviceInfoWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_device_info"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 切换主机
- (void)deviceSwapMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/swap_master"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 注册zigbee主机
- (void)deviceZigbeeRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/zigbee_register"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 绑定zigbee主机用户
- (void)deviceBindZigbeeUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/bind_zigbee_user"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加双向开关设备
- (void)deviceAddTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    //    NSLog(@"params:%@",dic);
    NSString *path = [self getPathWithInterface:@"/device/device/add_twoway_switch"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.9设备添加接口
- (void)deviceDeviceAddWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    //    NSLog(@"params:%@",dic);
    NSString *path = [self getPathWithInterface:@"/device/device/add"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加zigbee设备
- (void)deviceAddZigbeeDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/add_zigbee_device"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 发送zigbee命令
- (void)deviceZigbeeCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/zigbee_cmds"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取分享主机二维码
- (void)deviceGetShareCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_share_code"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 分享主机
- (void)deviceShareMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/share_master"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加传感器接口
- (void)deviceAddSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/add_sensor"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 情景列表接口
- (void)deviceGetSceneListsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/get_scene_lists"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加情景接口
- (void)deviceAddSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/add_scene"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改情景
- (void)deviceEditSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
//    DLog(@"param:%@",dic);
    NSString *path = [self getPathWithInterface:@"/device/scene/edit_scene"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除情景
- (void)deviceDeleteSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/delete_scene"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取设备的唯一devid
- (void)deviceGetDevidWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/get_devid"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取主机的设备列表
- (void)deviceGetMasterDevicesWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/get_master_devices"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 数值类设备数据上报
- (void)deviceReportNumEquipmentWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/report_num_equipment"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 触发器（情景）信息上报
- (void)deviceReportTriggerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/report_trigger"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 手动执行触发器（情景）接口
- (void)deviceTriggerSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/trigger_scene"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取主机设备快捷键列表
- (void)deviceGetDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/get_device_shortcut"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加设备快捷键
- (void)deviceAddDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/add_device_shortcut"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加设备快捷键
- (void)deviceDeleteDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/delete_device_shortcut"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取情景快捷键
- (void)deviceGetSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/get_scene_shortcut"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加情景快捷键
- (void)deviceAddSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/add_scene_shortcut"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除情景快捷键
- (void)deviceDeleteSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/delete_scene_shortcut"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取情景触发列表
- (void)deviceGetTriggerListWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/get_trigger_list"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取数值类上报的记录（传感器上报记录）
- (void)deviceEquipmentReportLogWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/equipment_report_log"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改双向开关
- (void)deviceEditTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/edit_twoway_switch"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 7.0设备修改
- (void)deviceDeviceEditWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/edit"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 7.1删除双向开关
- (void)deviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/delete_twoway_switch"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 设备的删除
- (void)deviceDeviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/delete"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改传感器
- (void)deviceEditSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/edit_sensor"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除传感器
- (void)deviceDeleteSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/delete_sensor"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 7.2添加/修改红外转发器的设备
- (void)deviceDeviceEditRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/edit_rf_device"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 7.2获取红外转发器的设备列表
- (void)deviceDeviceGetRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/get_rf_device"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 7.3获取红外转发器的设备列表
- (void)deviceDeviceDeleteRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/delete_rf_device"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 5.5添加主机房间
- (void)deviceAddMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/add_master_room"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 5.6修改主机房间
- (void)deviceEditMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/edit_master_room"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 5.7删除主机房间
- (void)deviceDeleteMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/delete_master_room"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 5.8获取app更新版本
- (void)userGetAppVersionWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/user/app/get_app_version"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 5.9添加门锁设备
- (void)deviceAddWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/add"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.0删除门锁设备
- (void)deviceDeleteWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/delete"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.1报警设置
- (void)deviceSetWarningWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/set_warning"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.2生成来宾密码
- (void)deviceGetTempPwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/get_temp_pwd"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.3取消来宾密码
- (void)deviceCancelTempPwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/cancel_temp_pwd"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.4门锁进入学习状态
- (void)devicenEterLearnWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/enter_learn"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.5门锁退出学习状态
- (void)devicenOutLearnWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/out_learn"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
//#pragma mark 6.5门锁退出学习状态
//- (void)devicenOutLearnWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
//    NSString *path = [self getPathWithInterface:@"/device/gatelock/out_learn"];
//    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
//}
#pragma mark 6.6切换用户主机权限
- (void)userSwapMasterAuthWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/user/manage/swap_master_auth"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.7通过手机号添加主机用户
- (void)userAddMasterAuthWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/user/manage/add_master_user"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 6.8请求主机创建门锁用户
- (void)deviceCreateUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/gatelock/create_user"];
    [PPNetworkHelper postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 根据品牌获取相应的设备
-(void)getBrandDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = @"https://api.yaokongyun.cn/chip/m.php";
    NSString *client = [[function sharedManager] getRfClient:[dic objectForKey:@"t"] v:[dic objectForKey:@"v"] f:[dic objectForKey:@"f"] bid:[dic objectForKey:@"bid"]];
    [PPNetworkHelper postRequestWithUrl:path client:client params:dic success:success failure:failure];
}
@end
