//
//  GaoJingModel.h
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GaoJingModel : NSObject

/**
 *  电梯ID
 */
@property (nonatomic, copy) NSString *evevatorID;
/**
 *  电梯显示编号
 */
@property (nonatomic, copy) NSString *linnerid;
/**
 *  电梯位置
 */
@property (nonatomic, copy) NSString *lbuildno;
/**
 *  电梯状态
 */
@property (nonatomic, copy) NSString *lstate;
/**
 *  电梯记录
 */
@property (nonatomic, copy) NSString *datacount;
/**
 *  告警id
 */
@property (nonatomic, copy) NSString *lid;

@end
