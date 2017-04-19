//
//  ReporterModel.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReporterModel : NSObject
/**
 *  报告人ID
 */
@property (nonatomic, copy) NSString *reporterID;
/**
 *  工号
 */
@property (nonatomic, copy) NSString *jobID;
/**
 *  报告人名字
 */
@property (nonatomic, copy) NSString *reporterName;
/**
 *  报告人电话
 */
@property (nonatomic, copy) NSString *reporterPhone;
/**
 *  报告人类型
 */
@property (nonatomic, copy) NSString *reporterType;
/**
 *  状态
 */
@property (nonatomic, copy) NSString *state;

@end
