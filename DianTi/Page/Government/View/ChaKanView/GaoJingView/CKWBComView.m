//
//  CKWBComView.m
//  DianTi
//
//  Created by 云彩 on 2017/4/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKWBComView.h"
#import "DividingLine.h"
#import "GJAlarmDetailModel.h"
#import "CKWYComTableViewCell.h"

@interface CKWBComView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CKWBComView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftArray = @[@"",@"单位地址：",@"法人代表：",@"联系电话：",@"维保资质：",@"维保资质有效期："];
        [self setUpHeadViewUI];
    }
    return self;
}

-(void) setUpHeadViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight - 64 - 120)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[CKWYComTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 300)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headView;
    
    [self setUpTableHeaderViewUI];
}

-(void) setUpTableHeaderViewUI {
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 50)];
    back.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.headView addSubview:back];
    
    for (int i = 0; i < 6; i++) {
        DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 50*i, KWindowWidth, 0.5)];
        [self.headView addSubview:line];
        
        UILabel *left = [[UILabel alloc] init];
        left.textColor = UIColorFromRGB(0x666666);
        left.font = [UIFont systemFontOfSize:14];
        left.text = self.leftArray[i];
        CGRect with = Adaptive_Width(left.text, left.font);
        left.frame = CGRectMake(15, 0.5+50*i, with.size.width, 49.5);
        [self.headView addSubview:left];
        
        UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(left.frame), 0.5+50*i, KWindowWidth - CGRectGetMaxX(left.frame)-15, 49.5)];
        rightLab.textColor = kTextColor;
        rightLab.font = [UIFont systemFontOfSize:14];
        [self.headView addSubview:rightLab];
        switch (i) {
            case 0:
                self.comLab = rightLab;
                break;
            case 1:
                self.addLab = rightLab;
                break;
            case 2:
                self.legalLab = rightLab;
                break;
            case 3:
                self.phoLab = rightLab;
                break;
            case 4:
                self.regNo = rightLab;
                break;
            case 5:
                self.reportNoLab = rightLab;
                break;
            default:
                break;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.wysArray[section] isEqualToString:@"1"]) {
        return [self.villageArray[section] count];
    }else{
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CKWYComTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GJAlarmDetailModel *model = self.villageArray[indexPath.section][indexPath.row];
    cell.nameLab.text = model.wyname;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton *headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 49.5)];
    [headView addTarget:self action:@selector(cilckHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    headView.tag = 1000+section;
    NSString *status = self.wysArray[section];
    headView.selected = status.boolValue;
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"负责小区";
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = UIColorFromRGB(0x666666);
    CGRect with = Adaptive_Width(nameLab.text, nameLab.font);
    nameLab.frame = CGRectMake(15, 0.5, with.size.width, 49);
    [headView addSubview:nameLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 40, 5, 40, 40)];
    if (headView.selected) {
        [btn setImage:[UIImage imageNamed:@"gaojing_xiala"] forState:UIControlStateNormal];
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"gaojing_shangla"] forState:UIControlStateNormal];
    }
    [headView addSubview:btn];
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    [headView addSubview:line1];
    
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 49.5, KWindowWidth, 0.5)];
    [headView addSubview:line];
    return headView;
}

-(void) cilckHeaderButton:(UIButton *)sender{
    if (sender.selected) {
        self.wysArray[sender.tag - 1000] = @"0";
    }else{
        
        self.wysArray[sender.tag - 1000] = @"1";
        
    }
    [self.tableView reloadData];
    
}

@end
