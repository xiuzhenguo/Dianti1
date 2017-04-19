//
//  OwnerManager.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/19.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetNumberOfData    10

@interface OwnerManager : NSObject

/**
 *  获取物业所负责小区
 *
 *  @param oid      业主id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaWithOID:(NSString *)oid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取关注电梯列表
 *
 *  @param oid       业主id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getElevatorListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取关注电梯列表
 *
 *  @param oid       业主id
 *  @param oid       小区id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getElevatorListWithOID:(NSString *)oid vid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  关注
 *
 *  @param oid     业主id
 *  @param lid     电梯id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)concernWithOID:(NSString *)oid lid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  取消关注
 *
 *  @param oid     业主id
 *  @param lid     电梯id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)concernNotWithOID:(NSString *)oid lid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据oid获得可报修电梯列表
 *
 *  @param oid       业主id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getRepairElevatorListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据oid 获得告警列表页
 *
 *  @param oid       业主id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getAlarmListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据oid 获得业主信息
 *
 *  @param oid      业主id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getOwnerInfoWithOID:(NSString *)oid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据oid 修改业主密码
 *
 *  @param oid      业主id
 *  @param oldpwd   原始密码
 *  @param newpwd   新密码
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getOwnerInfoWithOID:(NSString *)oid oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据oid获得我的报修记录
 *
 *  @param oid       业主id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getMyRepairListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  根据oid 重新绑定业主小区
 *
 *  @param oid      业主id
 *  @param vstr     小区id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getOwnerInfoWithOID:(NSString *)oid vstr:(NSString *)vstr success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
