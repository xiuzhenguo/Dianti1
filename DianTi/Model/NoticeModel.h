//
//  NoticeModel.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/16.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeModel : NSObject
/**
 *  通知id
 */
@property (nonatomic, copy) NSString *noticeID;
/**
 *  通知内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  通知状态
 */
@property (nonatomic, copy) NSString *isRead;
/**
 *  通知类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  通知时间
 */
@property (nonatomic, copy) NSString *addtime;


@end
