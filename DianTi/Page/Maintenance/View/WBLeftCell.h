//
//  WBLeftCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/15.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvevatorModel.h"
@interface WBLeftCell : UITableViewCell

@property (nonatomic, strong) EvevatorModel *model;
@property (weak, nonatomic) IBOutlet UILabel *idLable;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageV;


@end
