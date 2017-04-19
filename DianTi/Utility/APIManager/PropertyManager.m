

//
//  PropertyManager.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyManager.h"
#import "ApiManager.h"
#import "AreaModel.h"
#import "EvevatorModel.h"
#import "AlarmModel.h"
#import "ReporterModel.h"
#import "FaultModel.h"

@implementation PropertyManager
/**
 *  获取物业信息
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getInfoWithWYID:(NSString *)wyid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wyid":wyid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KPropertyInfo parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject[@"model"];
            
            if(success){
                success(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
    return task;
}

+ (NSURLSessionDataTask *)getAreaWithWYID:(NSString *)wyid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *parameters = @{@"wyid":wyid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KPropertyArea parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)getElevatorListWithVid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"vid":vid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KPropertyEvevatorList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)getFaultListSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KPropertyFaultList parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *tempArray = dic[@"list"];
            NSMutableArray *faultArray = [NSMutableArray array];
            for (NSDictionary *dic in tempArray) {
                FaultModel *model = [FaultModel new];
                model.state = @"0";
                model.faultI = [NSString stringWithFormat:@"%@",dic[@"id"]];
                model.details = dic[@"details"];
                [faultArray addObject:model];
            }
            if(success){
                success(faultArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];
    return task;
}

+ (NSURLSessionDataTask *)insertAlarmWithLid:(NSString *)lid alarmType:(NSString *)alarmType alarmDetils:(NSString *)alarmDetails reporterId:(NSString *)reportID reportType:(NSString *)reportType success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"lid"] = lid;
    parameters[@"alarmtype"] = alarmType;
    parameters[@"alarmdetails"] = alarmDetails;
    parameters[@"reporterid"] = reportID;
    parameters[@"reporttype"] = reportType;

    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:KPropertyAlarm parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        //如果有error 证明有错误，执行failure
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
        NSLog(@"%@", error.localizedDescription);
        if(failure){
            failure(error);
        }
        
    }];
    return task;
}

+ (NSURLSessionDataTask *)getAlarmListWithWYID:(NSString *)wyid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wyid":wyid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KPropertyAlarmList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *tempArray = dic[@"list"];
            NSMutableArray *alarmArray = [NSMutableArray array];
            for (NSDictionary *tempDic in tempArray) {
                AlarmModel *alarm = [AlarmModel new];
                EvevatorModel *evevator = [EvevatorModel new];
                evevator.evevatorID = tempDic[@"lid"];
                evevator.location = tempDic[@"lbuildno"];
                evevator.evevatorState = tempDic[@"lstate"];
                evevator.innerid = tempDic[@"linnerid"];
                alarm.evevator = evevator;
                alarm.addtime = [PropertyManager getTimeWithString:tempDic[@"addtime"]];
                [alarmArray addObject:alarm];
            }
            if(success){
                success(alarmArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

+ (NSURLSessionDataTask *)getAlarmDetailsWithLid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"lid":lid};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KPropertyAlarmDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSDictionary *modelDic = dic[@"model"];
            AlarmModel *model = [AlarmModel new];
            
            EvevatorModel *evevatorModel = [EvevatorModel new];
            evevatorModel.evevatorID = modelDic[@"lid"];
            evevatorModel.location = modelDic[@"lbuildno"];
            evevatorModel.evevatorState = [NSString stringWithFormat:@"%@",modelDic[@"lstate"]];
            evevatorModel.innerid = modelDic[@"linnerid"];
            model.evevator = evevatorModel;
            
            ReporterModel *reporter = [ReporterModel new];
            reporter.reporterID = [NSString stringWithFormat:@"%@",modelDic[@"lstate"]];
            reporter.reporterName = modelDic[@"reportname"];
            reporter.reporterPhone = modelDic[@"reportphone"];
            reporter.reporterType = modelDic[@"reporttype"];
            model.reporter = reporter;
            
            model.addtime = [PropertyManager getTimeWithString:modelDic[@"addtime"]];
            model.details = modelDic[@"alarmdetails"];
            model.type = modelDic[@"alarmtype"];
            
            model.company = modelDic[@"wbname"];
            model.phone = modelDic[@"wbphone"];
            
            NSString *renshu = [NSString stringWithFormat:@"%@",modelDic[@"reportercount"]];
            NSString *renming = [NSString stringWithFormat:@"%@",modelDic[@"ownerappend"]];
            NSString *wuyeming = [NSString stringWithFormat:@"%@",modelDic[@"wyappend"]];
            NSString *alarmId = [NSString stringWithFormat:@"%@",modelDic[@"id"]];
            
            NSArray *array = @[@[evevatorModel.innerid,evevatorModel.location,evevatorModel.evevatorState,model.type,model.details],@[reporter.reporterName,reporter.reporterPhone],@[model.company,model.phone,model.addtime],@[renshu,renming,wuyeming],alarmId];
            
            if(success){
                success(array);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

+ (NSURLSessionDataTask *)getMyBaoxiuListWithWYID:(NSString *)wyid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wyid":wyid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KPropertyAlarmList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSArray *tempArray = dic[@"list"];
            NSMutableArray *evevatorArray = [NSMutableArray array];
            for (NSDictionary *tempDic in tempArray) {
                EvevatorModel *evevator = [EvevatorModel new];
                evevator.alarmId = tempDic[@"id"];
                evevator.evevatorID = tempDic[@"lid"];
                evevator.location = tempDic[@"lbuildno"];
                evevator.evevatorState = tempDic[@"lstate"];
                evevator.time = [PropertyManager getTimeWithString:tempDic[@"addtime"]];
                evevator.innerid = tempDic[@"linnerid"];
                [evevatorArray addObject:evevator];
            }
            if(success){
                success(evevatorArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
    }];
    return task;
}

+ (NSURLSessionDataTask *)alarmDeleteWithAid:(NSString *)aid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"aid":aid
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KPropertyCancelAlarm parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)insertAlarmAgainWithAid:(NSString *)aid alarmType:(NSString *)alarmType reporterId:(NSString *)reportID reportType:(NSString *)reportType success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"aid"] = aid;
    parameters[@"alarmtype"] = alarmType;
    parameters[@"reporterid"] = reportID;
    parameters[@"reporttype"] = reportType;
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:KPropertyZhuijia parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        //如果有error 证明有错误，执行failure
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
        NSLog(@"%@", error.localizedDescription);
        if(failure){
            failure(error);
        }
        
    }];
    return task;
}


+ (NSString *)getTimeWithString:(NSString *)time
{
    return [time substringToIndex:time.length - 3];
}


@end
