//
//  CKGJVillTableViewCell.m
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKGJVillTableViewCell.h"

@implementation CKGJVillTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    self.line = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.textColor = kTextColor;
    self.nameLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLab];
    
    self.selectedButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.selectedButton];
    
    [self.selectedButton addTarget:self action:@selector(cilckButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) cilckButton:(UIButton *)selectedButton {
    [self.xlDelegate handleSelectedButtonActionWithSelectedIndexPath:self.selectedIndexPath];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.line.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 0.5);
    
    self.selectedButton.frame = CGRectMake(15, 5, 30, 30);
    
    self.nameLab.frame = CGRectMake(60, 0, self.contentView.frame.size.width - 70, 40);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
