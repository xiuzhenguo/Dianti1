//
//  CKWBComViewController.m
//  DianTi
//
//  Created by 云彩 on 2017/4/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKWBComViewController.h"
#import "DividingLine.h"
#import "GoveCkManager.h"
#import "SelectAreaModel.h"
#import "CKBaoJingView.h"
#import "CKWBComView.h"
#import "GJAlarmDetailModel.h"
#import "CKWBTypeView.h"
#import "WBTypeModel.h"
#import "CKWXTypeView.h"

@interface CKWBComViewController ()

@property (nonatomic, strong) UILabel *wbLab;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSString *wbStrId;
@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) CKWBComView *aview;
@property (nonatomic, strong) CKWBTypeView *bView;
@property (nonatomic, strong) CKWXTypeView *cView;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation CKWBComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.title = @"维保公司管理";
    self.pageNum = 1;
    self.typeArray = [NSMutableArray arrayWithObjects:@"维保公司详情",@"维修记录",@"保养记录", nil];
    
    [self setUpWyCompanyView];
    
    self.cView = [[CKWXTypeView alloc] initWithFrame:CGRectMake(0, 120, KWindowWidth, KWindowHeight - 64 - 120)];
    [self.view addSubview:self.cView];
    self.cView.hidden = YES;
    
    self.bView = [[CKWBTypeView alloc] initWithFrame:CGRectMake(0, 120, KWindowWidth, KWindowHeight - 64 - 120)];
    [self.view addSubview:self.bView];
    self.bView.hidden = YES;
    self.aview = [[CKWBComView alloc] initWithFrame:CGRectMake(0, 120, KWindowWidth, KWindowHeight - 64 - 120)];
    [self.view addSubview:self.aview];
    self.aview.hidden = YES;
    
}

#pragma mark - 创建物业公司选择
-(void) setUpWyCompanyView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KWindowWidth, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    for (int i = 0; i< 3; i++) {
        DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 9.5+50*i, KWindowWidth, 0.5)];
        [self.view addSubview:line];
    }
    
    self.wbLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KWindowWidth - 110, 49)];
    _wbLab.text = @"维保公司：请选择维保公司";
    self.wbLab.font = [UIFont systemFontOfSize:14];
    self.wbLab.textColor = kTextColor;
    [backView addSubview:self.wbLab];
    
    UIButton *wyBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 85, 5, 70, 40)];
    wyBtn.layer.borderWidth = 1;
    wyBtn.layer.borderColor = kMainColor.CGColor;
    wyBtn.layer.cornerRadius = 4;
    wyBtn.layer.masksToBounds = YES;
    [wyBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [wyBtn setTitle:@"维保" forState:UIControlStateNormal];
    wyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [wyBtn addTarget:self action:@selector(clickWBButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:wyBtn];
    
    self.typeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, KWindowWidth - 110, 49)];
    _typeLab.text = @"查询条件：请选择";
    self.typeLab.font = [UIFont systemFontOfSize:14];
    self.typeLab.textColor = kTextColor;
    [backView addSubview:self.typeLab];
    
    UIButton *typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 85, 55, 70, 40)];
    typeBtn.layer.borderWidth = 1;
    typeBtn.layer.borderColor = kMainColor.CGColor;
    typeBtn.layer.cornerRadius = 4;
    typeBtn.layer.masksToBounds = YES;
    [typeBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [typeBtn setTitle:@"查询" forState:UIControlStateNormal];
    typeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [typeBtn addTarget:self action:@selector(clickTypeButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:typeBtn];
    
}

- (void) clickWBButton{
    __weak typeof(self) weakSelf = self;
    weakSelf.typeLab.text = @"查询条件：请选择";
    [GoveCkManager getWBOptionListWithSuccess:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
    
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        
        CKBaoJingView *backview = [[CKBaoJingView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        backview.titleStr = @"维保公司";
        backview.dataArray = [NSMutableArray arrayWithArray:tempArray];
        [self.view addSubview:backview];
        
        [backview setFinishButtonTitleStr:^(NSString *name){
            NSString *str = [NSString stringWithFormat:@"维保公司：%@",name];
            self.wbLab.text = str;
        }];
        [backview setFinishButtonTitleID:^(NSString *strID){
            self.wbStrId = strID;
            NSLog(@"%@",self.wbStrId);
        }];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                [weakSelf clickWBButton];
            }];
        }
    }];
}

- (void) clickTypeButton {
    if ([self.wbLab.text isEqualToString:@"维保公司：请选择维保公司"]) {
        [self.view showHudMessage:@"请先选择维保公司"];
        return;
    }
    CKBaoJingView *backview = [[CKBaoJingView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    backview.titleStr = @"查询条件";
    backview.type = @"type";
    backview.dataArray = [NSMutableArray arrayWithArray:self.typeArray];
    [self.view addSubview:backview];
    
    [backview setFinishButtonTitleStr:^(NSString *name){
        NSString *str = [NSString stringWithFormat:@"查询条件：%@",name];
        self.typeLab.text = str;
        
    }];
    [backview setFinishButtonTitleID:^(NSString *strID){
        int intString = [strID intValue]+1;
        self.typeStr = [NSString stringWithFormat:@"%d",intString];
        NSLog(@"bbbb%@",self.typeStr);
        [self tableLoad];
        if ([self.typeStr isEqualToString:@"1"]) {
            
            [self loadDataWith:self.wbStrId type:self.typeStr];
        }else if ([self.typeStr isEqualToString:@"2"]){
             [self tableLoad];
            [self loadTypeWithId:self.wbStrId type:self.typeStr];
        }else if ([self.typeStr isEqualToString:@"3"]){
            
            [self loadTypeWith:self.wbStrId type:self.typeStr];
        }
    }];
}

#pragma mark - 按维保公司详情查询
-(void) loadDataWith:(NSString *)wbId type:(NSString *)type {
    NSLog(@"啦啦啦 %@，%@",wbId,type);
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [GoveCkManager getWBCompanyDetailWithWbID:wbId type:@"1" pageindex:@"1" pagesize:@"100" success:^(id responseObject) {
        
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        if ([type isEqualToString:@"1"]) {
            weakSelf.bView.hidden = YES;
            weakSelf.cView.hidden = YES;
            weakSelf.aview.hidden = NO;
            NSDictionary *model = responseObject[@"wbmodel"];
            NSArray *array = responseObject[@"villagelist"];
            NSMutableArray *villArr = [NSMutableArray array];
            weakSelf.aview.comLab.text = model[@"wbname"];
            weakSelf.aview.addLab.text = model[@"address"];
            weakSelf.aview.legalLab.text = model[@"legalname"];
            weakSelf.aview.phoLab.text = model[@"phone"];
            weakSelf.aview.regNo.text = model[@"wbright"];
            weakSelf.aview.reportNoLab.text = model[@"wbrightdate"];
            
            if (array.count > 0) {
                for (NSDictionary *tempDic in array) {
                    
                    GJAlarmDetailModel *model = [GJAlarmDetailModel new];
                    model.wyname = tempDic[@"vname"];
                    
                    [villArr addObject:model];
                }
            }
            
            weakSelf.aview.villageArray = [NSMutableArray arrayWithObjects:villArr, nil];
            
            weakSelf.aview.wysArray = [NSMutableArray array];
            for (int i = 0; i < weakSelf.aview.villageArray.count; i++) {
                
                [weakSelf.aview.wysArray addObject:@"0"];
            }
            [weakSelf.aview.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadDataWith:wbId type:type];
            }];
        }
    }];
}

-(void) loadTypeWithId:(NSString *)wbId type:(NSString *)type{
    __weak typeof(self) weakSelf = self;
    NSLog(@"啦啦啦%@",wbId);
     NSLog(@"啦啦啦11%@",type);
    [self.view showHudWithActivity:@"正在加载"];
    [GoveCkManager getWBCompanyTypeDetailWithWbID:wbId type:type pageindex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pagesize:@"10" success:^(id responseObject) {
        weakSelf.aview.hidden = YES;
        weakSelf.cView.hidden = YES;
        weakSelf.bView.hidden = NO;
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.bView.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            weakSelf.bView.dataArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 10){
                
                [weakSelf.bView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < 10){
                
                [weakSelf.bView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            weakSelf.bView.type = type;
            [weakSelf.bView.dataArray addObjectsFromArray:tempArray];
        }
        [weakSelf.bView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                [weakSelf loadTypeWithId:wbId type:type];
            }];
        }
    }];

}

-(void) loadTypeWith:(NSString *)wbId type:(NSString *)type{
    __weak typeof(self) weakSelf = self;
    NSLog(@"啦啦啦%@",wbId);
    NSLog(@"啦啦啦11%@",type);
    [self.view showHudWithActivity:@"正在加载"];
    [GoveCkManager getWXCompanyTypeDetailWithWbID:wbId type:type pageindex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pagesize:@"10" success:^(id responseObject) {
        weakSelf.aview.hidden = YES;
        weakSelf.bView.hidden = YES;
        weakSelf.cView.hidden = NO;
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.cView.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            weakSelf.cView.dataArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 10){
                
                [weakSelf.cView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < 10){
                
                [weakSelf.cView.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakSelf.cView.dataArray addObjectsFromArray:tempArray];
        }
        [weakSelf.cView.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                [weakSelf loadTypeWith:wbId type:type];
            }];
        }
    }];
    
}


-(void)tableLoad {
        
        __weak typeof(self) weakSelf = self;
    weakSelf.pageNum = 1;
    if ([weakSelf.typeStr isEqualToString:@"2"]) {
        
        [weakSelf.bView.tableView addRefreshHeaderBlock:^{
            
            weakSelf.pageNum  = 1;
            [weakSelf loadTypeWithId:weakSelf.wbStrId type:weakSelf.typeStr];
        }];
        
        [weakSelf.bView.tableView addRefreshFooterBlock:^{
            weakSelf.pageNum++;
            [weakSelf loadTypeWithId:weakSelf.wbStrId type:weakSelf.typeStr];
        }];
    }
    if ([weakSelf.typeStr isEqualToString:@"3"]) {
        
        [weakSelf.cView.tableView addRefreshHeaderBlock:^{
            
            weakSelf.pageNum  = 1;
            [weakSelf loadTypeWith:weakSelf.wbStrId type:weakSelf.typeStr];
        }];
        
        [weakSelf.cView.tableView addRefreshFooterBlock:^{
            weakSelf.pageNum++;
            [weakSelf loadTypeWith:weakSelf.wbStrId type:weakSelf.typeStr];
        }];
    }

}

-(void)chooseBlessingMeg{
    if ([self.typeStr isEqualToString:@"2"]) {
        [self.bView.tableView.mj_header endRefreshing];
        [self.bView.tableView.mj_footer endRefreshing];
        [self.bView.tableView reloadData];
    }
    if ([self.typeStr isEqualToString:@"3"]) {
        [self.cView.tableView.mj_header endRefreshing];
        [self.cView.tableView.mj_footer endRefreshing];
        [self.cView.tableView reloadData];
    }
}


@end
