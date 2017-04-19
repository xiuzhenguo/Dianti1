//
//  PropertyManager.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetNumberOfData    10

@interface PropertyManager : NSObject


/**
 *  获取物业信息
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getInfoWithWYID:(NSString *)wyid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  获取物业所负责小区
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaWithWYID:(NSString *)wyid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

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
 *  获取所有报修故障列表
 *
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getFaultListSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  插入告警记录
 *
 *  @param lid          电梯ID
 *  @param alarmType    故障类别
 *  @param alarmDetails 故障详情
 *  @param reportID     报告人ID
 *  @param reportType   报告人类别
 *  @param success      成功
 *  @param failures     失败
 */
+ (NSURLSessionDataTask *)insertAlarmWithLid:(NSString *)lid alarmType:(NSString *)alarmType alarmDetils:(NSString *)alarmDetails reporterId:(NSString *)reportID reportType:(NSString *)reportType success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获得告警列表
 *
 *  @param wyid      物业id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getAlarmListWithWYID:(NSString *)wyid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获得告警详情
 *
 *  @param lid      电梯ID
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAlarmDetailsWithLid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获得告警列表
 *
 *  @param wyid      物业id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getMyBaoxiuListWithWYID:(NSString *)wyid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  删除告警
 *
 *  @param aid     告警id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)alarmDeleteWithAid:(NSString *)Aid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  插入告警记录
 *
 *  @param lid          电梯ID
 *  @param alarmType    故障类别
 *  @param alarmDetails 故障详情
 *  @param reportID     报告人ID
 *  @param reportType   报告人类别
 *  @param success      成功
 *  @param failures     失败
 */
+ (NSURLSessionDataTask *)insertAlarmAgainWithAid:(NSString *)aid alarmType:(NSString *)alarmType reporterId:(NSString *)reportID reportType:(NSString *)reportType success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
