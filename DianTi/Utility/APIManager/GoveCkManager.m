//
//  GoveCkManager.m
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "GoveCkManager.h"
#import "ApiManager.h"
#import "GaoJingModel.h"
#import "SelectAreaModel.h"
#import "GJAlarmDetailModel.h"
#import "WBTypeModel.h"

@implementation GoveCkManager

/**
 *  获取省名称
 *  @param success  成功
 *  @param failures 失败
 */

+ (NSURLSessionDataTask *)getGovAreaOptionListSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSDictionary *parameters =[[NSDictionary alloc] init];
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovAreaList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    SelectAreaModel *model = [SelectAreaModel new];
                    model.strID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.name = tempDic[@"pname"];
                    
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
 *  获取市名称
 *  @param pid 省id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getCityAreaOptionListWithPid:(NSString *)pid success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *parameters = @{@"pid":pid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovAreaList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    SelectAreaModel *model = [SelectAreaModel new];
                    model.strID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.name = tempDic[@"cname"];
                    
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
 *  获取区名称
 *  @param cid 市id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaAreaOptionListWithCid:(NSString *)cid type:(NSString *)type success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *parameters = @{@"cid":cid,@"type":type};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovAreaList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    SelectAreaModel *model = [SelectAreaModel new];
                    model.strID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.name = tempDic[@"rname"];
                    
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
 *  获取小区名称
 *  @param area 区id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getVillageAreaOptionListWithArea:(NSString *)area type:(NSString *)type kind:(NSString *)kind success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary *parameters = @{@"area":area,@"type":type,@"kind":kind};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovAreaList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    SelectAreaModel *model = [SelectAreaModel new];
                    model.strID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.name = tempDic[@"vname"];
                    
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
 *  获取告警电梯列表
 *
 *  @param lid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getEvevatorListWithVID:(NSString *)vid pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *parameters = @{@"vid":vid,
                                 @"pageindex":pageindex,
                                 @"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KGoveChaKanGaoJingList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    GaoJingModel *model = [GaoJingModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.lbuildno = tempDic[@"lbuildno"];
                    model.linnerid = tempDic[@"linnerid"];
                    model.lstate = [NSString stringWithFormat:@"%@",tempDic[@"lstate"]];
                    model.lid = tempDic[@"lid"];
                    model.datacount = [NSString stringWithFormat:@"%@",tempDic[@"datacount"]];
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
 *  获取告警电梯详情
 *
 *  @param lid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getEvevatorListWithLID:(NSString *)lid pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *parameters = @{@"Lid":lid,
                                 @"pageindex":pageindex,
                                 @"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovAlarmDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    GJAlarmDetailModel *model = [GJAlarmDetailModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.lbuildno = tempDic[@"lbuildno"];
                    model.linnerid = tempDic[@"linnerid"];
                    model.lstate = [NSString stringWithFormat:@"%@",tempDic[@"lstate"]];
                    model.alarmtype = tempDic[@"alarmtype"];
                    model.reporttype = tempDic[@"reporttype"];
                    model.reportname = tempDic[@"reportname"];
                    model.reportphone = tempDic[@"reportphone"];
                    model.wyname = tempDic[@"wyname"];
                    model.wyphone = tempDic[@"wyphone"];
                    model.wbname = tempDic[@"wbname"];
                    model.wbphone = tempDic[@"wbphone"];
                    model.addtime = tempDic[@"addtime"];
                    model.alarmdetails = tempDic[@"alarmdetails"];
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
 *  获取小区电梯列表
 *
 *  @param vid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAlarmListWithVID:(NSString *)vid pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *parameters = @{@"vid":vid,
                                 @"pageindex":pageindex,
                                 @"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:WBLiftManage parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    GaoJingModel *model = [GaoJingModel new];
                    model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.lbuildno = tempDic[@"buildno"];
                    model.linnerid = tempDic[@"innerid"];
                    model.lstate = [NSString stringWithFormat:@"%@",tempDic[@"state"]];
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
 *  获取小区电梯详情
 *
 *  @param lid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAlarmDatailWithLID:(NSString *)lid  pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"lid":lid,
                                 @"pageindex":pageindex,
                                 @"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:WBLiftManageDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  获取物业公司列表
 *  @param success  成功
 *  @param failures 失败
 */

+ (NSURLSessionDataTask *)getWYOptionListWithSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSDictionary *parameters =[[NSDictionary alloc] init];
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovWYOption parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    SelectAreaModel *model = [SelectAreaModel new];
                    model.strID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.name = tempDic[@"wyname"];
                    
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
 *  获取物业公司详情
 *
 *  @param lid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getWYCompanyDetailWithWyID:(NSString *)wyid  success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wyid":wyid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovWYDetails parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  获取维保公司列表
 *  @param success  成功
 *  @param failures 失败
 */

+ (NSURLSessionDataTask *)getWBOptionListWithSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSDictionary *parameters =[[NSDictionary alloc] init];
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovWBOption parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    SelectAreaModel *model = [SelectAreaModel new];
                    model.strID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.name = tempDic[@"wbname"];
                    
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
 *  获取维保公司详情
 *
 *
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getWBCompanyDetailWithWbID:(NSString *)wbid type:(NSString *)type pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,@"type":type,@"pageindex":pageindex,@"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovWBDetails parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)getWBCompanyTypeDetailWithWbID:(NSString *)wbid type:(NSString *)type pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,@"type":type,@"pageindex":pageindex,@"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovWBDetails parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"repairlist"];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    WBTypeModel *model = [WBTypeModel new];
                    model.linnerid = tempDic[@"linnerid"];;
                    model.lbuildno = tempDic[@"lbuildno"];
                    model.addtime = tempDic[@"addtime"];;
                    model.alarmtype = tempDic[@"alarmtype"];
                    model.orgstate = tempDic[@"orgstate"];;
                    model.repairstate = tempDic[@"repairstate"];
                    model.sname = tempDic[@"sname"];;
                    model.content = tempDic[@"content"];
                    
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

+ (NSURLSessionDataTask *)getWXCompanyTypeDetailWithWbID:(NSString *)wbid type:(NSString *)type pageindex:(NSString *)pageindex pagesize:(NSString *)pagesize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,@"type":type,@"pageindex":pageindex,@"pagesize":pagesize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:GovWBDetails parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *array = dic[@"maintainlist"];
            NSMutableArray *tempArray = [NSMutableArray array];
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    WBTypeModel *model = [WBTypeModel new];
                    model.linnerid = tempDic[@"linnerid"];;
                    model.lbuildno = tempDic[@"lbuildno"];
                    model.addtime = tempDic[@"addtime"];;
                    model.alarmtype = tempDic[@"nextcaredate"];
                    model.orgstate = tempDic[@"orgstate"];;
                    model.repairstate = tempDic[@"maintainstate"];
                    model.sname = tempDic[@"sname"];;
                    model.content = tempDic[@"maintaintype"];
                    
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


@end
