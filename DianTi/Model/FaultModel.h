//
//  FaultModel.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaultModel : NSObject
/**
 *  故障id
 */
@property (nonatomic, copy) NSString *faultI;
/**
 *  故障详情
 */
@property (nonatomic, copy) NSString *details;
/**
 *  图片状态
 */
@property (nonatomic, copy) NSString *state;


@end
