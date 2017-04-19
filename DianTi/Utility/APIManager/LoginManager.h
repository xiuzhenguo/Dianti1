//
//  LoginManager.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/28.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGetNumberOfData    10

@interface LoginManager : NSObject

+ (NSURLSessionDataTask *)lookPwdWithPhone:(NSString *)tel code:(NSString *)code pwd:(NSString *)pwd success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
/**
 *  发送忘记密码验证码
 *
 *  @param tel     电话号码
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)sendForgotCodewithPhone:(NSString *)tel sucess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  检查版本
 *
 *  @param type    种类
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)checkVersonWithType:(NSString *)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  登录
 *
 *  @param username 用户名
 *  @param userpwd  密码
 *  @param type  用户类型
 *  @param success  成功
 *  @param failure  失败
 */
+ (NSURLSessionDataTask *)loginWithUsername:(NSString *)username userpwd:(NSString *)userpwd type:(NSString *)type sucess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  发送验证码
 *
 *  @param tel     电话号码
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)sendCodewithPhone:(NSString *)tel sucess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  获得小区列表
 *
 *  @param pageindex 页码
 *  @param pagesize  也容量
 *  @param where     搜索内容 -xyz
 *  @param success   成功
 *  @param failure   失败
 */
+ (NSURLSessionDataTask *)getAreaListWithPageindex:(NSString *)pageindex pagesize:(NSString *)pagesize where:(NSString *)where success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  注册
 *
 *  @param tel     电话
 *  @param code    验证码
 *  @param oname   昵称
 *  @param village 小区
 *  @param pwd     密码
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)registWithPhone:(NSString *)tel code:(NSString *)code oname:(NSString *)oname village:(NSString *)village pwd:(NSString *)pwd success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;



@end
