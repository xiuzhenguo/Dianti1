//
//  AreaTableViewCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/2.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
@interface AreaTableViewCell : UITableViewCell

@property (nonatomic, strong) AreaModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;


@end
