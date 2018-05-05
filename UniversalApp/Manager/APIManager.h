//
//  APIManager.h
//  UniversalApp
//
//  Created by wjy on 2018/5/1.
//  Copyright © 2018年 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject
+ (APIManager *)sharedManager;
#pragma mark 短信获取
- (void)sendCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 用户注册
- (void)registerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 用户登录
- (void)loginWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 忘记密码
- (void)forgetpwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加RF主机接口
- (void)deviceRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改主机名称
- (void)deviceEditMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取主机IP
- (void)deviceGetIpWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取服务器时间
- (void)deviceTimeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取天气
- (void)deviceWeatherWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取房间
- (void)deviceGetMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 查询主机是否在线
- (void)deviceGetMasterStatusWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark onenet发送命令接口
- (void)deviceCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 单项设备添加
- (void)deviceAddOnewayDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取设备列表
- (void)deviceGetDeviceInfoWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 切换主机
- (void)deviceSwapMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 注册zigbee主机
- (void)deviceZigbeeRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 绑定zigbee主机用户
- (void)deviceBindZigbeeUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加双向开关设备
- (void)deviceAddTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 设备添加接口
- (void)deviceDeviceAddWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//添加zigbee设备
//- (void)deviceAddZigbeeDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 发送zigbee命令
- (void)deviceZigbeeCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取分享主机二维码
- (void)deviceGetShareCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 分享主机
- (void)deviceShareMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加传感器接口
- (void)deviceAddSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 情景列表接口
- (void)deviceGetSceneListsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加情景接口
- (void)deviceAddSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改情景
- (void)deviceEditSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除情景
- (void)deviceDeleteSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取设备的唯一devid
- (void)deviceGetDevidWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取主机的设备列表
- (void)deviceGetMasterDevicesWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 数值类设备数据上报
- (void)deviceReportNumEquipmentWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 触发器（情景）信息上报
- (void)deviceReportTriggerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 手动执行触发器（情景）接口
- (void)deviceTriggerSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取主机设备快捷键列表
- (void)deviceGetDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加设备快捷键
- (void)deviceAddDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加设备快捷键
- (void)deviceDeleteDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取情景快捷键
- (void)deviceGetSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加情景快捷键
- (void)deviceAddSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除情景快捷键
- (void)deviceDeleteSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取情景触发列表
- (void)deviceGetTriggerListWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取数值类上报的记录（传感器上报记录）
- (void)deviceEquipmentReportLogWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改双向开关
- (void)deviceEditTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 设备修改
- (void)deviceDeviceEditWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除双向开关
- (void)deviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 设备的删除
- (void)deviceDeviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改传感器
- (void)deviceEditSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除传感器
- (void)deviceDeleteSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加/修改红外转发器的设备
- (void)deviceDeviceEditRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取红外转发器的设备列表
- (void)deviceDeviceGetRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取红外转发器的设备列表
- (void)deviceDeviceDeleteRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 5.5添加主机房间
- (void)deviceAddMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 5.6修改主机房间
- (void)deviceEditMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 5.7删除主机房间
- (void)deviceDeleteMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 5.8获取app更新版本
- (void)userGetAppVersionWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 5.9添加门锁设备
- (void)deviceAddWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.0删除门锁设备
- (void)deviceDeleteWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.1报警设置
- (void)deviceSetWarningWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.2生成来宾密码
- (void)deviceGetTempPwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.3取消来宾密码
- (void)deviceCancelTempPwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.4门锁进入学习状态
- (void)devicenEterLearnWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.5门锁退出学习状态
- (void)devicenOutLearnWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.6切换用户主机权限
- (void)userSwapMasterAuthWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.7通过手机号添加主机用户
- (void)userAddMasterAuthWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 6.8请求主机创建门锁用户
- (void)deviceCreateUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
@end
