//
//  CKBaoJingView.m
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKBaoJingView.h"
#import "SelectAreaModel.h"
#import "CKGJVillTableViewCell.h"
#import "MBProgressHUD.h"

@interface CKBaoJingView()<UITableViewDelegate, UITableViewDataSource,SelectedCellDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation CKBaoJingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setUpHeadViewUI];
    }
    return self;
}

- (void) setUpHeadViewUI{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:backView];
    backView.alpha = 0.5;
    backView.userInteractionEnabled = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:view];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake((KWindowWidth - 20)/2.0 - 40, 0, 80, 50)];
    self.titleLab.textColor = kTextColor;
    self.titleLab.font = [UIFont systemFontOfSize:16];
    
    [view addSubview:self.titleLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth-85, 0, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"regist_close"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [view addSubview:btn];
    [btn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768 - 130)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[CKGJVillTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.tableView.frame)+15, KWindowWidth - 30, 50)];
    sureBtn.backgroundColor = kMainColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:sureBtn];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 5;
    [sureBtn addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickSureButton {
    if (self.selectedIndexPath == 0) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.label.text = @"请选择";
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:1];
        [self addSubview:HUD];
        return;
    }
    [self removeFromSuperview];
    SelectAreaModel *model = self.dataArray[_selectedIndexPath.row];
    if ([self.type isEqualToString:@"type"]) {
        self.strId = [NSString stringWithFormat:@"%ld",(long)_selectedIndexPath.row];
        self.nameStr = self.dataArray[_selectedIndexPath.row];
        
    }else{
        
        self.strId = model.strID;
        self.nameStr = model.name;
    }
    self.finishButtonTitleStr(self.nameStr);
    self.finishButtonTitleID(self.strId);
    NSLog(@"%ld",(long)_selectedIndexPath.row);
}

-(void) clickButton {
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CKGJVillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.xlDelegate = self;
    cell.selectedIndexPath = indexPath;
    if ([self.type isEqualToString:@"type"]) {
        cell.nameLab.text = self.dataArray[indexPath.row];
    }else{
        
        SelectAreaModel *model = self.dataArray[indexPath.row];
        cell.nameLab.text = model.name;
    }
    [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"regist_duoxuan_normal"] forState:UIControlStateNormal];
    
    //当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打勾的
    if (_selectedIndexPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //[cell.selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    //之前选中的，取消选择
    CKGJVillTableViewCell *celled = [tableView cellForRowAtIndexPath:_selectedIndexPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    [celled.selectedButton setBackgroundImage:[UIImage imageNamed:@"regist_duoxuan_normal"] forState:UIControlStateNormal];
    celled.xlDelegate = self;
    celled.selectedIndexPath = indexPath;
    //记录当前选中的位置索引
    _selectedIndexPath = indexPath;
    //当前选择的打勾
    CKGJVillTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"regist_duoxuan_selected"] forState:UIControlStateNormal];
    
}

- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    CKGJVillTableViewCell *celled = [_tableView cellForRowAtIndexPath:_selectedIndexPath];
    celled.accessoryType = UITableViewCellAccessoryNone;
    [celled.selectedButton setBackgroundImage:[UIImage imageNamed:@"regist_duoxuan_normal"] forState:UIControlStateNormal];
    celled.xlDelegate = self;
    //记录当前选中的位置索引
    _selectedIndexPath = selectedIndexPath;
    //当前选择的打勾
    CKGJVillTableViewCell *cell = [_tableView cellForRowAtIndexPath:selectedIndexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"regist_duoxuan_selected"] forState:UIControlStateNormal];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
}

@end
