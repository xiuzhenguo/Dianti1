//
//  ApiManager.m
//  GoftApp
//
//  Created by admin on 15/9/6.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#import "ApiManager.h"

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL YES
/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certificate @"213980399400267"

#pragma mark APIError
@interface APIError : NSError
{
    NSString *_msg;
}
- (instancetype)initErrorMsg:(NSString *)msg code:(NSInteger)code;
@end
@implementation APIError
- (instancetype)initErrorMsg:(NSString *)msg code:(NSInteger)code
{
    self = [super initWithDomain:kErrorDomain code:code userInfo:@{@"Msg":msg}];
    return self;
}
- (NSString *)localizedDescription
{
    return self.userInfo[@"Msg"];
}

@end

#pragma mark ApiManager
@implementation ApiManager

+ (instancetype)sharedInstance
{
    static ApiManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *baseUrl = [NSString stringWithFormat:@"http://%@/", API_SERVERIP];
        sharedManager = [[ApiManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        sharedManager.requestSerializer.timeoutInterval = 30.0f;
        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"213980399400267.pem" ofType:nil];
//        NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
//        NSSet *set = [[NSSet alloc] initWithObjects:cerData, nil];
//        
//        sharedManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:set]; // 关键语句1
//        sharedManager.securityPolicy.allowInvalidCertificates = YES; // 关键语句2
        
    });
    return sharedManager;
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates =[[NSSet alloc] initWithObjects:certData, nil];
;
    
    return securityPolicy;
}



//验证服务器返回的数据
+ (NSError *)analysisData:(id)data
{
    //如果不是字典 证明服务器返回数据的格式错误
    if(![data isKindOfClass:[NSDictionary class]]){
        APIError *error = [[APIError alloc]initErrorMsg:@"返回数据格式错误" code:10000];
        return error;
    }
    //如果Result 不等于 1 证明请求失败 有错误码
    if([data[@"result"] integerValue] != 1){
        APIError *error = [[APIError alloc] initErrorMsg:data[@"msg"] code:[data[@"result"] integerValue]];
        return error;
    }
    return nil;
}



@end
