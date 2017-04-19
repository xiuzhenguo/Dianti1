//
//  WBGuanliCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/12.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBGuanliCell.h"
#import "DividingLine.h"
@implementation WBGuanliCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 125.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line1];
}
- (void)setModel:(EvevatorModel *)model
{
    _idLbale.text = [NSString stringWithFormat:@"编号：%@",model.innerid];
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.time];
    switch ([model.evevatorState integerValue]) {
        case 1:
        {
            _stateLabel.text = @"正常";
            _stateLabel.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            _stateLabel.text = @"未处理";
            _stateLabel.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            _stateLabel.text = @"已处理";
            _stateLabel.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            _stateLabel.text = @"正在维修";
            _stateLabel.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            _stateLabel.text = @"正在保养";
            _stateLabel.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
    _locationLabel.text = [NSString stringWithFormat:@"%@",model.location];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
