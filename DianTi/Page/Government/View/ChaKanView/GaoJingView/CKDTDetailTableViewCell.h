//
//  CKDTDetailTableViewCell.h
//  DianTi
//
//  Created by 云彩 on 2017/4/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DividingLine.h"

@interface CKDTDetailTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel *leftLab;

@property(nonatomic, strong) UILabel *rightLab;

@property(nonatomic, strong) DividingLine *line;

@property(nonatomic, strong) NSArray *leftArr;

@property(nonatomic, strong) NSMutableArray *rightArr;

@property (nonatomic, assign) NSInteger sction;

@property (nonatomic, assign) NSInteger row;

@end
