//
//  CKBaoJingTableViewCell.m
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKBaoJingTableViewCell.h"

@implementation CKBaoJingTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GaoJingModel *)model{
    self.linnerLab.text = [NSString stringWithFormat:@"电梯编号：%@",model.linnerid];
    self.numLab.text = [NSString stringWithFormat:@"告警记录：%@",model.datacount];
    self.buildLab.text = model.lbuildno;
    switch ([model.lstate integerValue]) {
        case 1:
        {
            self.stateLab.text = @"正常";
            self.stateLab.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            self.stateLab.text = @"未处理";
            self.stateLab.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            self.stateLab.text = @"已处理";
            self.stateLab.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            self.stateLab.text = @"正在维修";
            self.stateLab.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            self.stateLab.text = @"正在保养";
            self.stateLab.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
