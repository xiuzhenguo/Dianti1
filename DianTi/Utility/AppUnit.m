//
//  AppUnit.m
//  GoftApp
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#import "AppUnit.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <AFNetworkActivityIndicatorManager.h>
@implementation AppUnit
@synthesize firstLanch = _firstLanch;

+ (instancetype)sharedInstance
{
    static AppUnit *sharedAppUnit = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAppUnit = [[AppUnit alloc]init];
    });
    return sharedAppUnit;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self startReachability];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if([userDefaults objectForKey:kFirstLaunch] == nil){
            [userDefaults setObject:[NSNumber numberWithBool:YES] forKey:kFirstLaunch];
            [userDefaults synchronize];
        }
    }
    return self;
}
//开启网络监测
- (void)startReachability
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //开启网络监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networkStatus = (NetworkReachabilityStatus)status;
    }];
}
- (BOOL)firstLanch
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:kFirstLaunch]boolValue];
}
- (void)setFirstLanch:(BOOL)firstLanch
{
    _firstLanch = firstLanch;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:_firstLanch] forKey:kFirstLaunch];
    [userDefaults synchronize];
}
- (BOOL)isLogin
{
    if([self.currentUserInfo isKindOfClass:[NSDictionary class]]){
        return YES;
    }
    return NO;
}
- (NSDictionary *)currentUserInfo
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserInfo];
}
- (void)saveValue:(id)value key:(NSString *)key
{
    if(value){
        [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
- (id)getValueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
