//
//  PropertyFaultCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/8.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaultModel.h"
@interface PropertyFaultCell : UITableViewCell

@property (nonatomic, strong) FaultModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UILabel *faultLabel;

@end
