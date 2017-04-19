//
//  WBXiaoquCollectionViewCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/31.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
#import "EvevatorModel.h"
@interface WBXiaoquCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) AreaModel *model;
@property (nonatomic, strong) EvevatorModel *evevator;
@property (nonatomic, strong) UIImageView *photoImageV;
@property (nonatomic, strong) UILabel *titleLabel;

@end
