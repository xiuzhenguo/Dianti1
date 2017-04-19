//
//  AlarmModel.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EvevatorModel.h"
#import "ReporterModel.h"


@interface AlarmModel : NSObject
/**
 *  电梯
 */
@property (nonatomic, strong) EvevatorModel *evevator;
/**
 *  报告人
 */
@property (nonatomic, strong) ReporterModel *reporter;
/**
 *  维保公司名字
 */
@property (nonatomic, copy) NSString *company;
/**
 *  维保公司名字
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  添加时间
 */
@property (nonatomic, copy) NSString *addtime;
/**
 *  故障详情
 */
@property (nonatomic, copy) NSString *details;
/**
 *  故障类型
 */
@property (nonatomic, copy) NSString *type;


@end


