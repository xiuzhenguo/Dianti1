//
//  CKWBComView.h
//  DianTi
//
//  Created by 云彩 on 2017/4/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKWBComView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *leftArray;
@property (nonatomic, strong) NSMutableArray *villageArray;
@property (nonatomic, strong) NSMutableArray *wysArray;
@property (nonatomic, strong) UILabel *wyLab;
@property (nonatomic, strong) NSString *wyStrId;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *comLab;
@property (nonatomic, strong) UILabel *addLab;
@property (nonatomic, strong) UILabel *phoLab;
@property (nonatomic, strong) UILabel *regNo;
@property (nonatomic, strong) UILabel *legalLab;
@property (nonatomic, strong) UILabel *reportNoLab;

@end
