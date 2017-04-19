//
//  PropertyAlermCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/5.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmModel.h"
#import "EvevatorModel.h"
@interface PropertyAlermCell : UITableViewCell

@property (nonatomic, strong) EvevatorModel *evevator;
@property (nonatomic, strong) AlarmModel *model;
@property (weak, nonatomic) IBOutlet UILabel *AlermID;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *location;


@end
