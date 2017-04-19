//
//  PropertyFaultListViewController.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/8.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "BaseViewController.h"

@interface PropertyFaultListViewController : BaseViewController

@property (nonatomic, copy) NSString *sender;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) void(^chooseFinish)(NSArray *array);

@end
