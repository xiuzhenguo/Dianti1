//
//  ApiManager.h
//  GoftApp
//
//  Created by admin on 15/9/6.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>


#define API_SERVERIP            @"123.56.77.226:8903"
//#define API_SERVERIP            @""

//公共
#define kLogin                    @"api/Login"//登录
#define kRegist                   @"api/RegExec"//注册
#define kSendCode                 @"api/RegChk"//发送验证码
#define kGetAreaList              @"api/RegChk"//获取小区列表
#define kCheckVersion             @"api/Version"//检查版本
#define kSendCodeForgot           @"api/RegFindPwdChk"//发送忘记验证码
#define kLookForgotPwd            @"api/RegFindPwdExec"//密码找回

//业主
#define kOwnerAreaList            @"api/OwnerLiftAdd"//获得业主小区列表
#define kOwnerLiftConcernList     @"api/OwnerLift"//获取关注电梯列表
#define kOwnerLiftNotConcernList  @"api/OwnerLiftAdd"//获取未关注电梯列表
#define kOwnerLiftConcern         @"api/OwnerLiftAdd"//关注
#define kOwnerLiftNotConcern      @"api/OwnerLift"//取消关注
#define kOwnerLiftRepairList      @"api/OwnerReport"//可报修电梯列表
#define kOwnerAlarmList           @"api/OwnerAlarm"//获得告警列表
#define kOwnerOwnerInfo           @"api/OwnerInfo"//获得业主信息
#define kOwnerOwnerPwd            @"api/OwnerPwd"//修改业主密码
#define kOwnerOwnerMyReport       @"api/OwnerMyReport"//获得我的报修记录
#define kOwnerOwnerVillage        @"api/OwnerVillage"//重新绑定业主小区
//物业
#define KPropertyInfo             @"api/WYHomePage"//物业信息
#define KPropertyArea             @"api/WYReport"//物业小区
#define KPropertyEvevatorList     @"api/WYReport" // 物业电梯列表
#define KPropertyFaultList        @"api/WYReportDetail"//报修故障
#define KPropertyAlarm            @"api/WYReportDetail"//告警
#define KPropertyAlarmList        @"api/WYAlarm"//告警记录
#define KPropertyAlarmDetail      @"api/WYAlarmDetail"//告警详情
#define KPropertyWYMyReport       @"api/WYMyReport"//我的报修列表
#define KPropertyCancelAlarm      @"api/OwnerMyReport"//撤销
#define KPropertyZhuijia          @"api/WYReportDetailAppend"//追加告警
//维保
#define KMaintenanceRepairNormal              @"api/WBLiftRepairDetailAbNormal"//维保维修正常电梯
#define KMaintenanceInfo               @"api/WBHomePage"//维保信息
#define KMaintenanceArea               @"api/WBLiftManage"//维保小区
#define KMaintenanceEvevatorList       @"api/WBLiftManage" // 维保电梯列表
#define KMaintenanceEvevatorDetail     @"api/WBLiftManageDetail" // 维保电梯详情
#define KMaintenanceRepairMaintain     @"api/WBLiftRepairMaintain" //电梯保养，报修列表
#define KMaintenanceStaffList          @"api/WBStaff" //维保员工列表
#define KMaintenanceLiftRepairDetail   @"api/WBLiftRepairDetail" //插入报修记录
#define KMaintenanceLiftMaintainList   @"api/WBLiftMaintainDetail" //获得所有保养列表
#define KMaintenanceLiftMaintainDetail @"api/WBLiftMaintainDetail" //插入保养记录
#define KMaintenanceMyRepairRecord     @"api/WBMyRepairRecord" //我的报修记录
#define KMaintenanceMyRepairContent     @"api/WBMyRepairContent" //我的报修内容
#define KMaintenanceMyMaintainRecord   @"api/WBMyMaintainRecord" //我的保养记录
#define KMaintenanceTongCount        @"api/WBNotice" //通知列表
#define KMaintenanceTongzhiList        @"api/WBNotice" //通知列表
#define KMaintenanceTongzhiDetail      @"api/WBNoticeDetail" //获得通知详情
#define KMaintenanceTongzhiRead        @"api/WBNotice" //未读通知变已读
#define KMaintenanceTongzhiDelete      @"api/WBNoticeDetail" //删除通知

// 政府
#define KGoveChaKanGaoJingList     @"api/GovAlarm" // 告警信息电梯列表
#define GovAreaList    @"api/GovAreaOption" // 告警信息电梯列表
#define GovAlarmDetail    @"api/GovAlarmDetail" // 告警信息电梯详情
#define WBLiftManage    @"api/WBLiftManage" // 获取小区电梯列表
#define WBLiftManageDetail    @"api/WBLiftManageDetail" // 获取小区电梯详情
#define GovWYOption    @"api/GovWYOption" // 获取物业公司列表
#define GovWYDetails    @"api/GovWYDetails" // 获取物业公司详情
#define GovWBOption    @"api/GovWBOption" // 获取维保公司列表
#define GovWBDetails    @"api/GovWBDetails" // 获取维保公司详情


@interface ApiManager : AFHTTPSessionManager
{
    
}
+ (instancetype)sharedInstance;

//验证服务器返回的数据
+ (NSError *)analysisData:(id)data;


@end
