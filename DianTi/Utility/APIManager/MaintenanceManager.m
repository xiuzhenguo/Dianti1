//
//  Maintenance.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/1.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "MaintenanceManager.h"
#import "ApiManager.h"
#import "AreaModel.h"
#import "EvevatorModel.h"
#import "ReporterModel.h"
#import "AlarmModel.h"
#import "RecordModel.h"
#import "NoticeModel.h"
@implementation MaintenanceManager

/**
 *  电梯管理 维修正常电梯
 *
 *  @param lid         电梯id
 *  @param wbid        维保id
 *  @param staffid     操作人id
 *  @param repairstate 维修后电梯状态
 */
+ (NSURLSessionDataTask *)getWBLiftRepairDetailAbNormalWithLid:(NSString *)lid wbid:(NSString *)wbid staffid:(NSString *)staffid repairstate:(NSString *)repairstate success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"lid":lid,@"wbid":wbid,@"staffid":staffid,@"repairstate":repairstate};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KMaintenanceRepairNormal parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
/**
 *  获取维保信息
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getInfoWithWBID:(NSString *)wbid staffid:(NSString *)staffid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,@"staffid":staffid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KMaintenanceInfo parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
/**
 *  获取物业所负责小区
 *
 *  @param wyid     物业公司id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getAreaWithWBID:(NSString *)wbid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KMaintenanceArea parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
/**
 *  获取小区电梯列表
 *
 *  @param vid       小区id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getElevatorListWithVid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"vid":vid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceEvevatorList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    model.evevatorState = [NSString stringWithFormat:@"%@",tempDic[@"state"]];
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
 *  获取电梯管理详情
 *
 *  @param lid      电梯id
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getEvevatorDetailWithLID:(NSString *)lid  pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"lid":lid,
                                 @"pageIndex":pageIndex,
                                 @"pageSize":pageSize};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] GET:KMaintenanceEvevatorDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  获取电梯报修保养列表
 *
 *  @param vid       物业id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param operatype 操作类型
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getRepairMaintainListWithVid:(NSString *)vid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize operatype:(NSString *)operatype success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"vid":vid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize,
                                 @"operatype":operatype};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceRepairMaintain parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                
                    
                    if (operatype.integerValue == 1) {
                        model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"lid"]];
                        model.time = [MaintenanceManager getTimeWithString:tempDic[@"addtime"]];
                        model.innerid = tempDic[@"linnerid"];
                        model.location = tempDic[@"lbuildno"];
                        model.evevatorState = tempDic[@"lstate"];
                    }
                    else
                    {
                        model.evevatorID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                        model.time = [MaintenanceManager getTimeWithString:[NSString stringWithFormat:@"下次保养 %@",tempDic[@"nextcaredate"]]];
                        model.innerid = tempDic[@"innerid"];
                        model.location = tempDic[@"buildno"];
                        model.evevatorState = tempDic[@"state"];
                    }
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
 *  获取电梯报修保养列表
 *
 *  @param wbid      维保id
 *  @param pageIndex 页码
 *  @param pageSize  页容量
 *  @param where     搜索员工姓名的搜索值
 *  @param success   成功
 *  @param failures  失败
 */
+ (NSURLSessionDataTask *)getStaffListWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize where:(NSString *)where staffid:(NSString *)staffid power:(NSString *)power success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize,
                                 @"where":where,
                                 @"staffid":staffid,
                                 @"power":power};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceStaffList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    ReporterModel *model = [ReporterModel new];
                    model.reporterID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.jobID = tempDic[@"jobNo"];
                    model.reporterName = tempDic[@"name"];
                    model.reporterPhone = tempDic[@"phone"];
                    model.state = @"0";
                   
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
+ (NSURLSessionDataTask *)insertLeftRepairWithAid:(NSString *)aid wbid:(NSString *)wbid staffid:(NSString *)staffid repairstate:(NSString *)repairstate orgstate:(NSString *)orgstate success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"aid"] = aid;
    parameters[@"wbid"] = wbid;
    parameters[@"staffid"] = staffid;
    parameters[@"repairstate"] = repairstate;
    parameters[@"orgstate"] = orgstate;
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:KMaintenanceLiftRepairDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

/**
 *  获得保养列表
 *
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getLiftMaintainListSuccess:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceLiftMaintainList parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    model.areaName = tempDic[@"details"];
                    model.state = @"0";
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
+ (NSURLSessionDataTask *)insertLiftMaintainWithLid:(NSString *)lid wbid:(NSString *)wbid staffid:(NSString *)staffid nextcaredate:(NSString *)nextcaredate maintaintype:(NSString *)maintaintype maintainstate:(NSString *)maintainstate orgstate:(NSString *)orgstate success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"lid"] = lid;
    parameters[@"wbid"] = wbid;
    parameters[@"staffid"] = staffid;
    parameters[@"nextcaredate"] = nextcaredate;
    parameters[@"maintaintype"] = maintaintype;
    parameters[@"maintainstate"] = maintainstate;
    parameters[@"orgstate"] = orgstate;
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:KMaintenanceLiftMaintainDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
+ (NSURLSessionDataTask *)getMyRepairRecordWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceMyRepairRecord parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    RecordModel *model = [RecordModel new];
                    model.leftID = [NSString stringWithFormat:@"%@",tempDic[@"linnerid"]];
                    model.location = tempDic[@"lbuildno"];
                    model.content = tempDic[@"alarmtype"];
                    model.oldstate = tempDic[@"orgstate"];
                    model.newstate = tempDic[@"repairstate"];
                    model.people = tempDic[@"sjobno"];
                    model.rID = tempDic[@"id"];
                    model.editContent = tempDic[@"content"];
                    model.time = [MaintenanceManager getTimeWithString:tempDic[@"addtime"]];
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
{

    NSDictionary *parameters = @{@"rid":rid,
                                 @"wbid":wbid,
                                 @"staffid":staffid,
                                 @"content":content
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceMyRepairContent parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  根据wbid获得我的保养记录
 *
 *  @param wbid      维保公司id
 *  @param pageIndex 页码
 *  @param pageSize  也容量
 *  @param success   成功
 *  @param failure   失败
 *
 */
+ (NSURLSessionDataTask *)getMyMaintainRecordWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceMyMaintainRecord parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    RecordModel *model = [RecordModel new];
                    model.leftID = [NSString stringWithFormat:@"%@",tempDic[@"linnerid"]];
                    model.location = tempDic[@"lbuildno"];
                    model.content = tempDic[@"maintaintype"];
                    model.oldstate = tempDic[@"orgstate"];
                    model.newstate = tempDic[@"maintainstate"];
                    model.people = tempDic[@"sjobno"];
                    model.time = [MaintenanceManager getTimeWithString:tempDic[@"addtime"]];
                    NSString *data = tempDic[@"nextcaredate"];
                    model.nextTime = [data substringToIndex:10];
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
 *  根据wbid通知列表
 *
 *  @param wbid      维保公司id
 *  @param pageIndex 页码
 *  @param pageSize  也容量
 *  @param success   成功
 *  @param failure   失败
 *
 */
+ (NSURLSessionDataTask *)getNoticeListWithWBid:(NSString *)wbid pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid,
                                 @"pageindex":pageIndex,
                                 @"pagesize":pageSize
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceTongzhiList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    NoticeModel *model = [NoticeModel new];
                    model.noticeID = [NSString stringWithFormat:@"%@",tempDic[@"id"]];
                    model.content = tempDic[@"content"];
                    model.isRead = tempDic[@"isRead"];
                    model.type = [NSString stringWithFormat:@"%@",tempDic[@"type"]];
                    NSString *date = tempDic[@"addtime"];
                    model.addtime = date;
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
 *  根据通知数量
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiCountWithWbid:(NSString *)wbid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"wbid":wbid
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceTongzhiList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  根据nid获得某条通知详情
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiDetailWithNid:(NSString *)nid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"nid":nid
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceTongzhiDetail parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  阅读通知
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiReadWithNid:(NSString *)nid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"nid":nid,
                                 @"type":@"aa"
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceTongzhiRead parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  删除通知
 *
 *  @param nid     通知id
 *  @param success 成功
 *  @param failure 失败
 *
 */
+ (NSURLSessionDataTask *)getTongzhiDeleteWithNid:(NSString *)nid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"nid":nid,
                                 @"type":@"aa"
                                 };
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:KMaintenanceTongzhiDelete parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 *  获得告警详情
 *
 *  @param lid      电梯ID
 *  @param success  成功
 *  @param failures 失败
 */
+ (NSURLSessionDataTask *)getWeixiuDetailsWithLid:(NSString *)lid success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure
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
            
            model.addtime = [MaintenanceManager getTimeWithString:modelDic[@"addtime"]];
            model.details = modelDic[@"alarmdetails"];
            model.type = modelDic[@"alarmtype"];
            
            model.company = modelDic[@"wbname"];
            model.phone = modelDic[@"wbphone"];
            
            NSString *alarmID = modelDic[@"id"];
            
            NSArray *array = @[@[evevatorModel.innerid,evevatorModel.location,evevatorModel.evevatorState,model.type,model.details],@[reporter.reporterName,reporter.reporterPhone],@[model.company,model.phone,model.addtime],alarmID];
            
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

+ (NSString *)getTimeWithString:(NSString *)time
{
    return [time substringToIndex:time.length - 3];
}



@end
