//
//  PropertyFaultCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/8.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyFaultCell.h"
#import "DividingLine.h"
@implementation PropertyFaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(FaultModel *)model
{
    if ([model.state integerValue] == 1) {
        self.stateImageView.image = [UIImage imageNamed:@"regist_duoxuan_selected"];
    }
    else
    {
        self.stateImageView.image = [UIImage imageNamed:@"regist_duoxuan_normal"];
    }
    self.faultLabel.text = [NSString stringWithFormat:@"%@",model.details];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
