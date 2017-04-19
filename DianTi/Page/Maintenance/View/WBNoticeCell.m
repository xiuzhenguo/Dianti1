//
//  WBNoticeCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/16.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBNoticeCell.h"
#import "DividingLine.h"
@implementation WBNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 0.5, self.contentView.frame.size.width, 0.5)];
    
    
    [self.contentView addSubview:line1];
}

- (void)setModel:(NoticeModel *)model
{
    if ([model.isRead integerValue] == 1) {
        self.stateImage.image = [UIImage imageNamed:@"wb_notice_read"];
    }
    else
    {
        self.stateImage.image = [UIImage imageNamed:@"wb_notice"];
    }
    
    if ([model.type integerValue] == 1) {
        self.typeLabel.text = @"电梯困人";
    }
    else
    {
        self.typeLabel.text = @"保养日期将至";
    }
    
    
    self.timeLabel.text = [model.addtime substringToIndex:model.addtime.length - 8];
    self.detailLabel.text = [NSString stringWithFormat:@"%@",model.content];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
