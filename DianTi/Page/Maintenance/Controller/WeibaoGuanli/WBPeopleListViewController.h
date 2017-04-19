//
//  WBPeopleListViewController.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/13.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "BaseViewController.h"

@interface WBPeopleListViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) void(^chooseFinish)(NSArray *array);

@end
