//
//  AreaTableViewCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/2.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "AreaTableViewCell.h"
#import "DividingLine.h"
@implementation AreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, 80, 1)];
    [self.contentView addSubview:line1];
    [self.contentView addSubview:line2];
    
}

- (void)setModel:(AreaModel *)model
{
    if ([model.state integerValue] == 1) {
        self.stateImageview.image = [UIImage imageNamed:@"regist_duoxuan_selected"];
    }
    else
    {
        self.stateImageview.image = [UIImage imageNamed:@"regist_duoxuan_normal"];
    }
    self.nameLabel.text = [NSString stringWithFormat:@"小区名称：%@",model.areaName];
    self.numberLabel.text = [NSString stringWithFormat:@"小区编号：%@",model.areaID];
    self.locationLabel.text = [NSString stringWithFormat:@"小区位置：%@",model.location];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
