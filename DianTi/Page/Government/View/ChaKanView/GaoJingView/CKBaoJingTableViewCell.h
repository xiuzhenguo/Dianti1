//
//  CKBaoJingTableViewCell.h
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GaoJingModel.h"

@interface CKBaoJingTableViewCell : UITableViewCell

@property (nonatomic, strong) GaoJingModel *model;

@property (weak, nonatomic) IBOutlet UILabel *linnerLab;

@property (weak, nonatomic) IBOutlet UILabel *numLab;

@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (weak, nonatomic) IBOutlet UILabel *buildLab;

@end
