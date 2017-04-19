//
//  PropertyMineCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/9.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvevatorModel.h"
@interface PropertyMineCell : UITableViewCell

@property (nonatomic) NSInteger Indexrow;
@property (nonatomic, strong) EvevatorModel *model;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *vvv;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (copy, nonatomic) void(^choosefinish)(NSInteger row);

@end
