//
//  PropertyBaoxiuCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/6.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvevatorModel.h"
@interface PropertyBaoxiuCell : UITableViewCell

@property (nonatomic, strong) EvevatorModel *model;
@property (weak, nonatomic) IBOutlet UIButton *baoxiuBtn;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
