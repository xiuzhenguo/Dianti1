//
//  OwnerGuanzhuCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/21.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import "EvevatorModel.h"
@interface OwnerGuanzhuCell : MGSwipeTableCell

@property (nonatomic, copy) void(^chooseFinish)(EvevatorModel *model);
@property (nonatomic, strong) EvevatorModel *model;
@property (weak, nonatomic) IBOutlet UILabel *IdLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@end
