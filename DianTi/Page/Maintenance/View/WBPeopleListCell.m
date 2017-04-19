//
//  WBPeopleListCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/14.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBPeopleListCell.h"
#import "DividingLine.h"
@implementation WBPeopleListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 79.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line];
}

- (void)setModel:(ReporterModel *)model
{
    if ([model.state integerValue] == 1) {
        self.stateIV.image = [UIImage imageNamed:@"regist_duoxuan_selected"];
    }
    else
    {
        self.stateIV.image = [UIImage imageNamed:@"regist_duoxuan_normal"];
    }
    self.peopleIdLabel.text = [NSString stringWithFormat:@"工号：%@",model.jobID];
    self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",model.reporterName];
    self.telLabel.text = [NSString stringWithFormat:@"电话：%@",model.reporterPhone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
