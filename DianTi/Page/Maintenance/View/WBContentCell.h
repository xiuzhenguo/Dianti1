//
//  WBContentCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/15.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
@interface WBContentCell : UICollectionViewCell


@property (strong, nonatomic) AreaModel *model;
@property (strong, nonatomic) UILabel *contentlabel;


@end
