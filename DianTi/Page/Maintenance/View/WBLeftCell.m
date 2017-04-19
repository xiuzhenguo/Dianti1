//
//  WBLeftCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/15.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBLeftCell.h"
#import "DividingLine.h"
@implementation WBLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 125.5, self.contentView.frame.size.width, 0.5)];

    
    [self.contentView addSubview:line1];

}

- (void)setModel:(EvevatorModel *)model
{
    _idLable.text = [NSString stringWithFormat:@"编号：%@",model.innerid];

    switch ([model.evevatorState integerValue]) {
        case 1:
        {
            _stateLabel.text = @"正常";
            _stateImageV.image = [UIImage imageNamed:@"left_zhengchagn"];
            
        }
            break;
        case 2:
        {
            _stateLabel.text = @"未处理";
            _stateImageV.image = [UIImage imageNamed:@"left_weishouli"];
        }
            break;
        case 3:
        {
            _stateLabel.text = @"已处理";
            _stateImageV.image = [UIImage imageNamed:@"left_yishouli"];
        }
            break;
        case 4:
        {
            _stateLabel.text = @"正在维修";
            _stateImageV.image = [UIImage imageNamed:@"left_zhengzaiweixiu"];
        }
            break;
        case 5:
        {
            _stateLabel.text = @"正在保养";
            _stateImageV.image = [UIImage imageNamed:@"left_zhengzaiweixiu"];
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
