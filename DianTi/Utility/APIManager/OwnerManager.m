//
//  OwnerManager.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/19.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerManager.h"
#import "ApiManager.h"
#import "AreaModel.h"
#import "EvevatorModel.h"
#import "PersonInformation.h"
@implementation OwnerManager

/**
 *  获取物业所负责小区
 *
 *  @param oid      业主id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaWithOID:(NSString *)oid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSDictionary *parameters = @{@"oid":oid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:kOwnerAreaList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"list"];
            NSMutableArray *areaArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    AreaModel *model = [AreaModel new];
                    model.areaID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.areaName = tempDic[@"vname"];
                    model.location = tempDic[@"address"];
                    [areaArray addObject:model];
                }
            }
            if(success){
                success(areaArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
    return task;
}
/**
 *  获取关注电梯列表
 *
 *  @param oid       业主id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getElevatorListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerLiftConcernList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"list"];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    EvevatorModel *model = [EvevatorModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.location = tempDic[@"buildno"];
                    model.innerid = tempDic[@"innerid"];
                    model.evevatorState = @"1";
                    [tempArray addObject:model];
                }
            }
            
            if(success){
                success(tempArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  获取关注电梯列表
 *
 *  @param oid       业主id
 *  @param vid       小区id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getElevatorListWithOID:(NSString *)oid vid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"vid":vid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerLiftNotConcernList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"list"];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    EvevatorModel *model = [EvevatorModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.location = tempDic[@"buildno"];
                    model.innerid = tempDic[@"innerid"];
                    model.evevatorState = @"2";
                    [tempArray addObject:model];
                }
            }
            
            if(success){
                success(tempArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  关注
 *
 *  @param oid     业主id
 *  @param lid     电梯id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)concernWithOID:(NSString *)oid lid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"lid":lid};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerLiftConcern parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            
            
            if(success){
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  取消关注
 *
 *  @param oid     业主id
 *  @param lid     电梯id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)concernNotWithOID:(NSString *)oid lid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"lid":lid};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerLiftNotConcern parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            
            
            if(success){
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  根据oid获得可报修电梯列表
 *
 *  @param oid      业主id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getRepairElevatorListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerLiftRepairList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"list"];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    EvevatorModel *model = [EvevatorModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.location = tempDic[@"buildno"];
                    model.innerid = tempDic[@"innerid"];
                    [tempArray addObject:model];
                }
            }
            
            if(success){
                success(tempArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}


/**
 *  根据oid 获得告警列表页
 *
 *  @param oid      业主id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAlarmListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerAlarmList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"list"];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    EvevatorModel *model = [EvevatorModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"lid"]];
                    model.location = tempDic[@"lbuildno"];
                    model.innerid = tempDic[@"linnerid"];
                    model.time = tempDic[@"addtime"];
                    model.evevatorState = [NSString stringWithFormat:@"%@",tempDic[@"lstate"]];
                    [tempArray addObject:model];
                }
            }
            
            if(success){
                success(tempArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  根据oid 获得业主信息
 *
 *  @param oid      业主id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getOwnerInfoWithOID:(NSString *)oid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerOwnerInfo parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSDictionary *model = dic[@"model"];
            PersonInformation *owner = [PersonInformation sharedPersonInformation];
            owner.user_name = model[@"oname"];
            owner.user_phone = model[@"phone"];
            
            if(success){
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  根据oid 修改业主密码
 *
 *  @param oid      业主id
 *  @param oldpwd   原始密码
 *  @param newpwd   新密码
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getOwnerInfoWithOID:(NSString *)oid oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"oldpwd":oldpwd,
                                 @"newpwd":newpwd};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerOwnerPwd parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            
            
            if(success){
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

/**
 *  根据oid获得我的报修记录
 *
 *  @param oid       业主id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getMyRepairListWithOID:(NSString *)oid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    {
        NSDictionary *parameters = @{@"oid":oid,
                                     @"pageindex":pageIndex,
                                     @"pagesize":pageSize};
        
        NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerOwnerMyReport parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
            NSError *error = [ApiManager analysisData:responseObject];
            if(error){
                if(failure){
                    failure(error);
                }
            }else{
                NSDictionary *dic = responseObject;
                NSArray *array = dic[@"list"];
                NSMutableArray *tempArray = [NSMutableArray array];
                if (array.count > 0) {
                    for (NSDictionary *tempDic in array) {
                        EvevatorModel *model = [EvevatorModel new];
                        model.alarmId = tempDic[@"id"];
                        model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"lid"]];
                        model.location = tempDic[@"lbuildno"];
                        model.innerid = tempDic[@"linnerid"];
                        model.evevatorState = tempDic[@"lstate"];
                        model.time = tempDic[@"addtime"];
                        [tempArray addObject:model];
                    }
                }
                
                if(success){
                    success(tempArray);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if(failure){
                failure(error);
            }
        }];
        return task;
    }
}

/**
 *  根据oid 重新绑定业主小区
 *
 *  @param oid      业主id
 *  @param vstr     小区id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getOwnerInfoWithOID:(NSString *)oid vstr:(NSString *)vstr success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"oid":oid,
                                 @"vstr":vstr};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kOwnerOwnerVillage parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            
            
            if(success){
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}


@end
