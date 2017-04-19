//
//  Maintenance.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/1.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetNumberOfData    10

@interface MaintenanceManager : NSObject

/**
 *  电梯管理 维修正常电梯
 *
 *  @param lid         电梯id
 *  @param wbid        维保id
 *  @param staffid     操作人id
 *  @param repairstate 维修后电梯状态
 */
+ (NSURLSessionDataTask *)getWBLiftRepairDetailAbNormalWithLid:(NSString *)lid wbid:(NSString *)wbid staffid:(NSString *)staffid repairstate:(NSString *)repairstate success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  获取维保信息
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getInfoWithWBID:(NSString *)wbid staffid:(NSString *)staffid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  获取维保所负责小区
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaWithWBID:(NSString *)wbid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取小区电梯列表
 *
 *  @param vid       小区id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getElevatorListWithVid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取电梯管理详情
 *
 *  @param lid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getEvevatorDetailWithLID:(NSString *)lid  pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取电梯报修保养列表
 *
 *  @param vid       物业id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param operatype 操作类型
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getRepairMaintainListWithVid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize operatype:(NSString *)operatype success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取电梯报修保养列表
 *
 *  @param wbid      维保id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param where     搜索员工姓名的搜索值
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getStaffListWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize where:(NSString *)where staffid:(NSString *)staffid power:(NSString *)power success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  插入维修记录并修改电梯状态
 *
 *  @param aid         告警id
 *  @param wbid        维保id
 *  @param staffid     维保员工id 请从员工列表中提取员工id 格式："1,2,3"
 *  @param repairstate 更改电梯的状态码 可传状态:2未处理/3已受理/4正在维修
 *  @param orgstate    电梯原始状态码
 *  @param success     成功
 *  @param failure     失败
 *
 */
+ (NSURLSessionDataTask *)insertLeftRepairWithAid:(NSString *)aid wbid:(NSString *)wbid staffid:(NSString *)staffid repairstate:(NSString *)repairstate orgstate:(NSString *)orgstate success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  获得保养列表
 *
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getLiftMaintainListSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;



/**
 *  插入保养记录并修改电梯状态
 *
 *  @param aid           告警id
 *  @param wbid          维保id
 *  @param staffid       维保员工id 请从员工列表中提取员工id 格式："1,2,3"
 *  @param nextcaredate  下次保养时间 格式:"2016-12-12"
 *  @param maintaintype  维保内容id 请从维保内容列表中提取维保id 格式："1,2,3"
 *  @param maintainstate 更改电梯的状态码 可传状态:1正常/5正在保养
 *  @param orgstate      电梯原始状态码
 *  @param success       成功
 *  @param failure       失败
 *
 */
+ (NSURLSessionDataTask *)insertLiftMaintainWithLid:(NSString *)lid wbid:(NSString *)wbid staffid:(NSString *)staffid nextcaredate:(NSString *)nextcaredate maintaintype:(NSString *)maintaintype maintainstate:(NSString *)maintainstate orgstate:(NSString *)orgstate success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据wbid获得我的维修记录
 *
 *  @param wbid      维保公司id
 *  @param pageIndex 页码
 *  @param pageSize  也容量
 *  @param success   成功
 *  @param failure   失败
 *
 */
+ (NSURLSessionDataTask *)getMyRepairRecordWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据rid 添加或更新维修内容
 *
 *  @param rid     维修id
 *  @param wbid    维保id
 *  @param staffid 维保员工id
 *  @param content 维修文本内容
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)postMyRepairContentWithRid:(NSString *)rid wbid:(NSString *)wbid staffid:(NSString *)staffid content:(NSString *)content success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据wbid获得我的保养记录
 *
 *  @param wbid      维保公司id
 *  @param pageIndex 页码
 *  @param pageSize  也容量
 *  @param success   成功
 *  @param failure   失败
 *
 */
+ (NSURLSessionDataTask *)getMyMaintainRecordWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据通知数量
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiCountWithWbid:(NSString *)wb success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据wbid通知列表
 *
 *  @param wbid      维保公司id
 *  @param pageIndex 页码
 *  @param pageSize  也容量
 *  @param success   成功
 *  @param failure   失败
 *
 */
+ (NSURLSessionDataTask *)getNoticeListWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据nid获得某条通知详情
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiDetailWithNid:(NSString *)nid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  阅读通知
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiReadWithNid:(NSString *)nid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  删除通知
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiDeleteWithNid:(NSString *)nid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获得告警详情
 *
 *  @param lid      电梯ID
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getWeixiuDetailsWithLid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
