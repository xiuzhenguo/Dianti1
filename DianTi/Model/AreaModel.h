//
//  AreaModel.h
//  DianTi
//
//  Created by 佘坦烨 on 16/11/30.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
/**
 *  小区id
 */
@property (nonatomic, copy) NSString *areaID;
/**
 *  小区名称
 */
@property (nonatomic, copy) NSString *areaName;
/**
 *  小区位置 区域+详细地址
 */
@property (nonatomic, copy) NSString *location;
/**
 *  小区区域
 */
@property (nonatomic, copy) NSString *area;
/**
 *  小区详细地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  小区状态
 */
@property (nonatomic, copy) NSString *state;//0普通，1选中

@end
