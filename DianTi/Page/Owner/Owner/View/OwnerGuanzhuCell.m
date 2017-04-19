//
//  OwnerGuanzhuCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/21.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerGuanzhuCell.h"
#import "UIImage+Color.h"
#import "DividingLine.h"
@implementation OwnerGuanzhuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 60.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line1];
    _stateButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    
    
}

- (void)setModel:(EvevatorModel *)model
{
    _model = model;
    if ([model.evevatorState integerValue] == 2) {
        _stateButton.layer.cornerRadius = 5;
        _stateButton.layer.masksToBounds = YES;
        _stateButton.layer.borderWidth = 1;
        _stateButton.layer.borderColor = UIColorFromRGB(0xffca60).CGColor;
        [_stateButton setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xffffff)] forState:UIControlStateNormal];
        [_stateButton setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xffca60)] forState:UIControlStateHighlighted];
        [_stateButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateHighlighted];
        [_stateButton setTitleColor:UIColorFromRGB(0xffca60) forState:UIControlStateNormal];
    }
    else
    {
        _stateButton.layer.cornerRadius = 5;
        _stateButton.layer.masksToBounds = YES;
        _stateButton.layer.borderWidth = 1;
        _stateButton.layer.borderColor = UIColorFromRGB(0x5c80d1).CGColor;
        [_stateButton setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xffffff)] forState:UIControlStateNormal];
        [_stateButton setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0x5c80d1)] forState:UIControlStateHighlighted];
        [_stateButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateHighlighted];
        [_stateButton setTitleColor:UIColorFromRGB(0x5c80d1) forState:UIControlStateNormal];
    }
    
    _IdLabel.text = [NSString stringWithFormat:@"%@",model.innerid];
    _locationLabel.text = [NSString stringWithFormat:@"%@",model.location];
}

- (IBAction)guanzhuClick:(id)sender {
    if (self.chooseFinish) {
        self.chooseFinish(self.model);
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
