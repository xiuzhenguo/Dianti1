//
//  AppUnit.h
//  GoftApp
//
//  Created by admin on 15/8/18.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#import <Foundation/Foundation.h>

//第一次启动
#define kFirstLaunch            @"firsrLaunch"
//用户信息
#define kCurrentUserInfo        @"personInfo"
//通知
#define ENotificationEnterForeground @"willEnterForground"

typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,  // 未知
    NetworkReachabilityStatusNotReachable     = 0,   // 无连接
    NetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
    NetworkReachabilityStatusReachableViaWiFi = 2,   // wifi
};


@interface AppUnit : NSObject

+ (instancetype)sharedInstance;
//程序第一次启动
@property (nonatomic, assign) BOOL firstLanch;

//当前网络连接状况
@property (nonatomic, assign) NetworkReachabilityStatus networkStatus;

//当前是否有用户登录
@property (nonatomic, assign, readonly) BOOL isLogin;
//当前用户信息
@property (nonatomic, strong) NSDictionary *currentUserInfo;
//device Token
@property (nonatomic, strong) NSString *deviceToken;

- (void)saveValue:(id)value key:(NSString *)key;
- (id)getValueForKey:(NSString *)key;

@end
