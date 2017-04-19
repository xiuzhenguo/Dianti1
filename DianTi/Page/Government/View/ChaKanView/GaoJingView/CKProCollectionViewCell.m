//
//  CKProCollectionViewCell.m
//  DianTi
//
//  Created by 云彩 on 2017/4/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKProCollectionViewCell.h"

@implementation CKProCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.btn = [[UIButton alloc] init];
        self.btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.btn];
        self.btn.backgroundColor = [UIColor whiteColor];
        [self.btn setTitleColor:kTextColor forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.btn.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 1, self.contentView.frame.size.height - 1);
    
    
}

@end
