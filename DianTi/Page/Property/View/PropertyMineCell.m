
//
//  PropertyMineCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/9.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyMineCell.h"
#import "DividingLine.h"
#import "UIImage+Color.h"
@implementation PropertyMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 88.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line2];
    
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.cancelBtn setBackgroundImage:[UIImage createImageWithColor:kMainColor] forState:UIControlStateHighlighted];
    [self.cancelBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    self.cancelBtn.layer.cornerRadius = 4;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.borderColor = kMainColor.CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    
    
}

- (void)setModel:(EvevatorModel *)model
{
    _model = model;
    _idLabel.text = [NSString stringWithFormat:@"电梯编号：%@",model.innerid];
    _locationLabel.text = [NSString stringWithFormat:@"%@",model.location];
    _dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
    
}

- (void)setIndexrow:(NSInteger)Indexrow
{
    _Indexrow = Indexrow;
}

- (void)cancelBtnClick
{
    if (self.choosefinish) {
        self.choosefinish(self.Indexrow);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
