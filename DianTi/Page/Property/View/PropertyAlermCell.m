//
//  PropertyAlermCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/5.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyAlermCell.h"
#import "DividingLine.h"
@implementation PropertyAlermCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 125.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line1];
}

- (void)setEvevator:(EvevatorModel *)evevator
{
    _AlermID.text = [NSString stringWithFormat:@"编号：%@",evevator.innerid];
    _date.text = [NSString stringWithFormat:@"%@",evevator.time];
    switch ([evevator.evevatorState integerValue]) {
        case 1:
        {
            _state.text = @"正常";
            _state.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            _state.text = @"未处理";
            _state.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            _state.text = @"已处理";
            _state.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            _state.text = @"正在维修";
            _state.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            _state.text = @"正在保养";
            _state.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
    _location.text = [NSString stringWithFormat:@"%@",evevator.location];
}

- (void)setModel:(AlarmModel *)model
{
    _AlermID.text = [NSString stringWithFormat:@"编号：%@",model.evevator.innerid];
    _date.text = model.addtime;
    switch ([model.evevator.evevatorState integerValue]) {
        case 1:
        {
            _state.text = @"正常";
            _state.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            _state.text = @"未处理";
            _state.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            _state.text = @"已处理";
            _state.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            _state.text = @"正在维修";
            _state.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            _state.text = @"正在保养";
            _state.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
    _location.text = model.evevator.location;
}

- (NSString *)buqiName:(NSString *)name
{
    if (name.length >= 5 || name == nil)
    {
        return name;
    }
    else
    {
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < 5 - name.length; i++) {
            [str appendString:@"0"];
        }
        [str appendString:name];
        return str;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
