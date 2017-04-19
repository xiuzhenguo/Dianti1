
//
//  OwnerMineCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/23.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerMineCell.h"
#import "DividingLine.h"
@implementation OwnerMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 44.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
