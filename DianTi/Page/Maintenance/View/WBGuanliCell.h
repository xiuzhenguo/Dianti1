//
//  WBGuanliCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/12.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvevatorModel.h"
@interface WBGuanliCell : UITableViewCell

@property (nonatomic, strong) EvevatorModel *model;
@property (weak, nonatomic) IBOutlet UILabel *idLbale;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
