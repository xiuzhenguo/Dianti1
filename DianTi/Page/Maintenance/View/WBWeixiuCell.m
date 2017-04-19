//
//  WBWeixiuCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/15.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBWeixiuCell.h"
#import "DividingLine.h"
#import "UIView+baseAdditon.h"
@implementation WBWeixiuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _line1 = [[DividingLine alloc] init];
    [self.contentView addSubview:_line1];
}

- (void)setModel:(RecordModel *)model
{
    float width1 = KWindowWidth - 25 - 73;
    NSInteger hRow = [NSString stringWithFormat:@"%@",model.content].length * 14 / width1;
    _Contentwidth.constant = width1;
    _contentLabel.height = 14 + hRow * 14;
    
    NSInteger hRow2 = [NSString stringWithFormat:@"%@",model.editContent].length * 14 / width1;
    _editContent.text = model.editContent;
    _editContentWidth.constant = width1;
    if (hRow2 > 1) {
        _editContent.height = 14 + 14;
        _line1.frame = CGRectMake(0, hRow * 14 + 228.5, self.contentView.frame.size.width, 0.5);
    }
    else
    {
        _editContent.height = 14;
        _line1.frame = CGRectMake(0, hRow * 14 + 214.5, self.contentView.frame.size.width, 0.5);
    }
    
    
    
    
    _idLbael.text = [NSString stringWithFormat:@"%@",model.leftID];
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.time];
    _locationLabel.text = [NSString stringWithFormat:@"%@",model.location];
    _contentLabel.text = [NSString stringWithFormat:@"%@",model.content];
    if (model.content.length == 0) {
        _contentLabel.text = @"   ";
    }
    _peopleLabel.text = [NSString stringWithFormat:@"%@",model.people];
    
    switch ([model.oldstate integerValue]) {
        case 1:
        {
            _oldLabel.text = @"正常";
            
        }
            break;
        case 2:
        {
            _oldLabel.text = @"未处理";
        }
            break;
        case 3:
        {
            _oldLabel.text = @"已处理";
        }
            break;
        case 4:
        {
            _oldLabel.text = @"正在维修";
        }
            break;
        case 5:
        {
            _oldLabel.text = @"正在保养";
        }
            break;
            
        default:
            break;
    }
    
    switch ([model.newstate integerValue]) {
        case 1:
        {
            _newstateLabel.text = @"正常";
            
        }
            break;
        case 2:
        {
            _newstateLabel.text = @"未处理";
        }
            break;
        case 3:
        {
            _newstateLabel.text = @"已处理";
        }
            break;
        case 4:
        {
            _newstateLabel.text = @"正在维修";
        }
            break;
        case 5:
        {
            _newstateLabel.text = @"正在保养";
        }
            break;
            
        default:
            break;
    }
    
}

- (void)setJiluModel:(RecordModel *)jiluModel
{
    
    float width1 = KWindowWidth - 25 - 80;
    _editContentWidth.constant = width1;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    CGRect frame = [jiluModel.editContent boundingRectWithSize:CGSizeMake(width1, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    _editContent.height = frame.size.height;
    
    _line1.frame = CGRectMake(0, self.contentView.frame.size.height - 0.5, self.contentView.frame.size.width, 0.5);
    
    _editContent.text = jiluModel.editContent;
    _timeLabel.text = [NSString stringWithFormat:@"%@",jiluModel.time];
    _peopleLabel.text = [NSString stringWithFormat:@"%@",jiluModel.people];
    switch ([jiluModel.oldstate integerValue]) {
        case 1:
        {
            _oldLabel.text = @"正常";
            
        }
            break;
        case 2:
        {
            _oldLabel.text = @"未处理";
        }
            break;
        case 3:
        {
            _oldLabel.text = @"已处理";
        }
            break;
        case 4:
        {
            _oldLabel.text = @"正在维修";
        }
            break;
        case 5:
        {
            _oldLabel.text = @"正在保养";
        }
            break;
            
        default:
            break;
    }
    
    switch ([jiluModel.newstate integerValue]) {
        case 1:
        {
            _newstateLabel.text = @"正常";
            
        }
            break;
        case 2:
        {
            _newstateLabel.text = @"未处理";
        }
            break;
        case 3:
        {
            _newstateLabel.text = @"已处理";
        }
            break;
        case 4:
        {
            _newstateLabel.text = @"正在维修";
        }
            break;
        case 5:
        {
            _newstateLabel.text = @"正在保养";
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
