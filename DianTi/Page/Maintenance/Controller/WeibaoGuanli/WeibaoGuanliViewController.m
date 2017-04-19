//
//  WeibaoGuanliViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/12.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WeibaoGuanliViewController.h"
#import "WBLeftWeixiuViewController.h"
#import "WBLeftBaoyangViewController.h"
#import "PropertyFaultListViewController.h"

#import "PersonInformation.h"
#import "MaintenanceManager.h"
#import "WBGuanliCell.h"
#import "DividingLine.h"
#import "EvevatorModel.h"
#import "AreaModel.h"
#import "FaultModel.h"

#import "UITableView+Refresh.h"
#import "UITabBar+Badge.h"

@interface WeibaoGuanliViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *itemArray;
    NSArray *typeArray;
    NSArray *areaArray;
    BOOL isBaoyang;
}
@property (nonatomic) NSInteger pageNum;
@property (nonatomic, strong) AreaModel *currentArea;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;

@end

@implementation WeibaoGuanliViewController

- (void)getTongzhiCount
{
    __weak typeof(self) weakSelf = self;
    [MaintenanceManager getTongzhiCountWithWbid:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        NSInteger count = [responseObject[@"count"] integerValue];
        if (count > 0) {
            [weakSelf.tabBarController.tabBar showBadgeOnItemIndex:3 badge:count];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    [self getTongzhiCount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTongzhiCount) name:ENotificationEnterForeground object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
}

- (void)setupSubview
{
    self.navigationItem.title = @"维保管理";
    
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 44.5, KWindowWidth, 0.5)];
    DividingLine *line3 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 44.5, KWindowWidth, 0.5)];
    [self.typeView addSubview:line1];
    [self.typeView addSubview:line2];
    [self.areaView addSubview:line3];
    
    self.typeButton.layer.borderWidth = 1;
    self.typeButton.layer.borderColor = kMainColor.CGColor;
    self.typeButton.layer.cornerRadius = 4;
    self.typeButton.layer.masksToBounds = YES;
    
    self.areaButton.layer.borderWidth = 1;
    self.areaButton.layer.borderColor = kMainColor.CGColor;
    self.areaButton.layer.cornerRadius = 4;
    self.areaButton.layer.masksToBounds = YES;
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    
    [_tableView addRefreshHeaderBlock:^{
        weakSelf.pageNum  = 1;
        if (weakSelf.currentArea == nil || [weakSelf.typeLabel.text isEqualToString:@"请选择类型"]) {
            [weakSelf loadData];
        }
        else
        {
            if (isBaoyang)
            {
                [weakSelf loadBaoyangDataWithArea:self.currentArea.areaID];
            }
            else
            {
                [weakSelf loadWeixiuDataWithArea:self.currentArea.areaID];
                
            }
        }
        
    }];
    [_tableView addRefreshFooterBlock:^{
        weakSelf.pageNum++;
        if (isBaoyang)
        {
            [weakSelf loadBaoyangDataWithArea:self.currentArea.areaID];
        }
        else
        {
            [weakSelf loadWeixiuDataWithArea:self.currentArea.areaID];

        }
    }];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

-(void)chooseBlessingMeg{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    itemArray = [NSMutableArray array];
    [MaintenanceManager getAreaWithWBID:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        
        areaArray = responseObject;
        if (areaArray.count > 0) {
            AreaModel *model = areaArray[0];
            weakSelf.currentArea = model;
            weakSelf.areaLabel.text = [NSString stringWithFormat:@"%@",model.areaName];
            if (isBaoyang)
            {
                [weakSelf loadBaoyangDataWithArea:model.areaID];
                weakSelf.typeLabel.text = @"电梯保养";
            }
            else
            {
                [weakSelf loadWeixiuDataWithArea:model.areaID];
                weakSelf.typeLabel.text = @"电梯维修";
            }
        }
        else
        {
            [weakSelf chooseBlessingMeg];
            [weakSelf.view hidFailedView];
            [weakSelf.view hideHubWithActivity];
            weakSelf.areaLabel.text = @"无小区";
        }
        
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadData];
            }];
        }
    }];
    
}

- (void)loadWeixiuDataWithArea:(NSString *)area
{
    isBaoyang = NO;
    __weak typeof(self) weakSelf = self;
    [MaintenanceManager getRepairMaintainListWithVid:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"10" operatype:@"1" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidFailedView];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1)
        {
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1)
        {
            itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 10)
            {
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else
        {
            if(tempArray.count < 10)
            {
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [itemArray addObjectsFromArray:tempArray];
        }
        [weakSelf.view hideHubWithActivity];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadWeixiuDataWithArea:area];
            }];
        }
        
    }];
}

- (void)loadBaoyangDataWithArea:(NSString *)area
{
    isBaoyang = YES;
    __weak typeof(self) weakSelf = self;
    [MaintenanceManager getRepairMaintainListWithVid:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"10" operatype:@"2" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1)
        {
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1)
        {
            itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 10)
            {
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else
        {
            if(tempArray.count < 10)
            {
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [itemArray addObjectsFromArray:tempArray];
        }

        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadWeixiuDataWithArea:area];
            }];
        }
    }];
}
#pragma mark - buttonClick
- (IBAction)typeBtnClick:(id)sender {
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    PropertyFaultListViewController *areaList = [storyboard instantiateViewControllerWithIdentifier:@"FaultAreaList"];
    areaList.view.frame = CGRectMake(10, (KWindowHeight - 270) / 3, KWindowWidth - 20, 270);
    areaList.view.layer.cornerRadius = 10;
    areaList.view.layer.masksToBounds = YES;
    areaList.view.layer.borderWidth = 1;
    areaList.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    areaList.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    areaList.chooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            FaultModel *type = array[0];
            weakSelf.pageNum = 1;
            if ([type.faultI isEqualToString:@"1"]) {
                [weakSelf loadWeixiuDataWithArea:weakSelf.currentArea.areaID];
                weakSelf.typeLabel.text = @"电梯维修";
            }
            else
            {
                [weakSelf loadBaoyangDataWithArea:weakSelf.currentArea.areaID];
                weakSelf.typeLabel.text = @"电梯保养";
            }
        }
        [bgview removeFromSuperview];
    };
    
    areaList.sender = [NSString stringWithFormat:@"typeList"];
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];
}
- (IBAction)areaBtnClick:(id)sender {
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    PropertyFaultListViewController *areaList = [storyboard instantiateViewControllerWithIdentifier:@"FaultAreaList"];
    areaList.view.frame = CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768);
    areaList.view.layer.cornerRadius = 10;
    areaList.view.layer.masksToBounds = YES;
    areaList.view.layer.borderWidth = 1;
    areaList.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    areaList.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    areaList.chooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            FaultModel *model = array[0];
            self.currentArea.areaID = model.faultI;
            self.areaLabel.text = [NSString stringWithFormat:@"%@",model.details];
            weakSelf.pageNum = 1;
            if (isBaoyang) {
                [weakSelf loadBaoyangDataWithArea:model.faultI];
            }
            else
            {
                [weakSelf loadWeixiuDataWithArea:model.faultI];
            }
        }
        [bgview removeFromSuperview];
    };
    if (areaArray != nil || areaArray.count > 0) {
        areaList.array = [NSMutableArray arrayWithArray:areaArray];
    }
    areaList.sender = [NSString stringWithFormat:@"areaList"];
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBGuanliCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    EvevatorModel *model = itemArray[indexPath.row];
    cell.model = model;
    
    if (indexPath.row == 0) {
        DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
        [cell.contentView addSubview:line1];
    }
    else
    {
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
        line1.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:line1];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvevatorModel *model = itemArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    if (isBaoyang) {
        WBLeftBaoyangViewController *baoyangVC = [storyboard instantiateViewControllerWithIdentifier:@"WBLeftBaoyang"];
        baoyangVC.model = model;
        [self.navigationController pushViewController:baoyangVC animated:YES];
    }
    else
    {
        WBLeftWeixiuViewController *weixiuVC = [storyboard instantiateViewControllerWithIdentifier:@"WBLeftWeixiu"];
        weixiuVC.lid = model.evevatorID;
        [self.navigationController pushViewController:weixiuVC animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
