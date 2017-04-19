//
//  GJAlarmDetailModel.h
//  DianTi
//
//  Created by 云彩 on 2017/4/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJAlarmDetailModel : NSObject
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
 *  类型
 */
@property (nonatomic, copy) NSString *alarmtype;

@property (nonatomic, copy) NSString *alarmdetails;
/**
 *  告警id
 */
@property (nonatomic, copy) NSString *reporttype;

@property (nonatomic, copy) NSString *reportname;

@property (nonatomic, copy) NSString *reportphone;

@property (nonatomic, copy) NSString *wyname;

@property (nonatomic, copy) NSString *wyphone;

@property (nonatomic, copy) NSString *wbname;

@property (nonatomic, copy) NSString *wbphone;

@property (nonatomic, copy) NSString *addtime;

@property (nonatomic, assign) BOOL isOpen;




@end
