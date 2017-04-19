//
//  GoveCkManager.h
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetNumberOfData    10

@interface GoveCkManager : NSObject

/**
 *  电梯 省
 *
 
 */
+ (NSURLSessionDataTask *)getGovAreaOptionListSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  电梯 市
 *
 *  @param pid 省id
 *
 */
+ (NSURLSessionDataTask *)getCityAreaOptionListWithPid:(NSString *)pid
    success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取区名称
 *  @param cid 市id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaAreaOptionListWithCid:(NSString *)cid type:(NSString *)type success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  获取小区名称
 *  @param area 区id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getVillageAreaOptionListWithArea:(NSString *)area type:(NSString *)type kind:(NSString *)kind success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  电梯告警信息
 *
 *  @param vid         小区id
 
 */
+ (NSURLSessionDataTask *)getEvevatorListWithVID:(NSString *)vid  pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  电梯告警信息详情
 *
 *  @param lid         电梯id
 
 */
+ (NSURLSessionDataTask *)getEvevatorListWithLID:(NSString *)lid  pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  小区电梯列表
 *
 *  @param vid         小区id
 *
 *
 */
+ (NSURLSessionDataTask *)getAlarmListWithVID:(NSString *)vid  pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  小区电梯详情
 *
 *  @param lid         小区id
 *
 *
 */
+ (NSURLSessionDataTask *)getAlarmDatailWithLID:(NSString *)lid  pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取物业公司列表
 *
 *  @param success         成功
 *
 *
 */
+ (NSURLSessionDataTask *)getWYOptionListWithSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *  物业公司详情
 *
 *  @param wyid         物业公司id
 *
 *
 */
+ (NSURLSessionDataTask *)getWYCompanyDetailWithWyID:(NSString *)wyid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取维保公司列表
 *
 *  @param success         成功
 *
 *
 */
+ (NSURLSessionDataTask *)getWBOptionListWithSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  维保公司详情
 *
 *  @param wbid         维保公司id
 *  @param type         
 *  @param pageindex
 *  @param pagesize
 *
 */
+ (NSURLSessionDataTask *)getWBCompanyDetailWithWbID:(NSString *)wbid type:(NSString *)type pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (NSURLSessionDataTask *)getWBCompanyTypeDetailWithWbID:(NSString *)wbid type:(NSString *)type pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (NSURLSessionDataTask *)getWXCompanyTypeDetailWithWbID:(NSString *)wbid type:(NSString *)type pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
