//
//  PersonInformation.h
//  Ningcheng
//
//  Created by 佘坦烨 on 16/11/2.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInformation : NSObject

IMPLEMENT_SINGLETON_HEADER(PersonInformation)
/**
 *  个人id
 */
@property (nonatomic, copy) NSString *userID;
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *user_name;
/**
 *  权限
 */
@property (nonatomic, copy) NSString *power;
/**
 *  员工id
 */
@property (nonatomic, copy) NSString *staffid;
/**
 *  用户类型
 */
@property (nonatomic, copy) NSString *user_type;
/**
 *  用户电话
 */
@property (nonatomic, copy) NSString *user_phone;
/**
 *  注册日期
 */
@property (nonatomic, copy) NSString *RegDate;


@end
