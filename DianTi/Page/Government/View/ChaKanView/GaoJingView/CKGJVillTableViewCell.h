//
//  CKGJVillTableViewCell.h
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DividingLine.h"
#import "SelectAreaModel.h"

@protocol SelectedCellDelegate <NSObject>

- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath;

@end

@interface CKGJVillTableViewCell : UITableViewCell

@property (nonatomic, strong) SelectAreaModel *viewModel;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) DividingLine *line;

@property (nonatomic, weak) id<SelectedCellDelegate> xlDelegate;

@property (nonatomic, strong) UIButton *selectedButton;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;

@end
