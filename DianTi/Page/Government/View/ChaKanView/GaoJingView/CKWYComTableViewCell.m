//
//  CKWYComTableViewCell.m
//  DianTi
//
//  Created by 云彩 on 2017/4/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKWYComTableViewCell.h"

@implementation CKWYComTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont systemFontOfSize:14];
    self.nameLab.textColor = kTextColor;
    [self.contentView addSubview:self.nameLab];
    
    self.line = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(25, 0, KWindowWidth, 49.5);
    self.line.frame = CGRectMake(0, 49.5, KWindowWidth, 0.5);
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
