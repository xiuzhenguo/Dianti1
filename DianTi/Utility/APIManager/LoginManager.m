
//
//  LoginManager.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/28.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "LoginManager.h"
#import "ApiManager.h"
#import "LXFileManager.h"
#import "PersonInformation.h"
#import "AreaModel.h"
@implementation LoginManager

+ (NSURLSessionDataTask *)lookPwdWithPhone:(NSString *)tel code:(NSString *)code pwd:(NSString *)pwd success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"phone":tel,
                                 @"code":code,
                                 @"pwd":pwd};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:kLookForgotPwd parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)sendForgotCodewithPhone:(NSString *)tel sucess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"phone":tel};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kSendCodeForgot parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)checkVersonWithType:(NSString *)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"type":type};
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kCheckVersion parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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


+ (NSURLSessionDataTask *)loginWithUsername:(NSString *)username userpwd:(NSString *)userpwd type:(NSString *)type sucess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if(username.length)
        parameters[@"loginid"] = username;
    if(userpwd.length)
        parameters[@"pwd"] = userpwd;
    if(userpwd.length)
        parameters[@"type"] = type;

    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:kLogin parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        //如果有error 证明有错误，执行failure
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *dic = responseObject;
            NSMutableDictionary *personDic = [NSMutableDictionary dictionary];
            personDic[@"userid"] = [NSString stringWithFormat:@"%@",dic[@"userid"]];
            personDic[@"power"] = [NSString stringWithFormat:@"%@",dic[@"power"]];
            personDic[@"staffid"] = [NSString stringWithFormat:@"%@",dic[@"staffid"]];
            personDic[@"usertype"] = type;
            [LXFileManager saveUserData:personDic forKey:kCurrentUserInfo];
            
            [PersonInformation sharedPersonInformation].userID = [NSString stringWithFormat:@"%@",personDic[@"userid"]];
            [PersonInformation sharedPersonInformation].user_type = [NSString stringWithFormat:@"%@",personDic[@"usertype"]];
            [PersonInformation sharedPersonInformation].power = [NSString stringWithFormat:@"%@",personDic[@"power"]];
            [PersonInformation sharedPersonInformation].staffid = [NSString stringWithFormat:@"%@",personDic[@"staffid"]];
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


+ (NSURLSessionDataTask *)sendCodewithPhone:(NSString *)tel sucess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"phone":tel};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kSendCode parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

+ (NSURLSessionDataTask *)getAreaListWithPageindex:(NSString *)pageindex pagesize:(NSString *)pagesize where:(NSString *)where success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"pageindex":pageindex,
                                 @"pagesize":pagesize,
                                 @"where":where};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance]GET:kGetAreaList parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSError *error = [ApiManager analysisData:responseObject];
        if(error){
            if(failure){
                failure(error);
            }
        }else{
            NSDictionary *tempdic = responseObject;
            NSArray *array = tempdic[@"list"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                AreaModel *model = [AreaModel new];
                model.areaName = dic[@"vname"];
                model.areaID = dic[@"id"];
                model.location = [NSString stringWithFormat:@"%@%@",dic[@"area"],dic[@"address"]];
                model.state = @"0";
                [tempArray addObject:model];
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

+ (NSURLSessionDataTask *)registWithPhone:(NSString *)tel code:(NSString *)code oname:(NSString *)oname village:(NSString *)village pwd:(NSString *)pwd success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameters = @{@"phone":tel,
                                 @"code":code,
                                 @"oname":oname,
                                 @"village":village,
                                 @"pwd":pwd};
    
    NSURLSessionDataTask *task = [[ApiManager sharedInstance] POST:kRegist parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

@end
