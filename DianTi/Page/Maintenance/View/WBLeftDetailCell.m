//
//  WBLeftDetailCell.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WBLeftDetailCell.h"

@implementation WBLeftDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _historyButton.layer.cornerRadius = 5;
    _historyButton.layer.masksToBounds = YES;
    _historyButton.layer.borderWidth = 1;
    _historyButton.layer.borderColor = kMainColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
