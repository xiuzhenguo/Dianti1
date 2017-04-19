//
//  EvevatorModel.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvevatorModel : NSObject
/**
 *  电梯编号
 */
@property (nonatomic, copy) NSString *evevatorID;
/**
 *  电梯显示编号
 */
@property (nonatomic, copy) NSString *innerid;
/**
 *  电梯位置
 */
@property (nonatomic, copy) NSString *location;
/**
 *  电梯状态
 */
@property (nonatomic, copy) NSString *evevatorState;
/**
 *  电梯时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  告警id
 */
@property (nonatomic, copy) NSString *alarmId;

@end
