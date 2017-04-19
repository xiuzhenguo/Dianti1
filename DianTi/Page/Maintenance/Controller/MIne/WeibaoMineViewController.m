//
//  WeibaoMineViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/12.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WeibaoMineViewController.h"
#import "LXFileManager.h"

#import "UITableView+Refresh.h"
#import "UIImage+Color.h"

#import "WBWeixiuCell.h"
#import "WBBaoyangCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"

#import "PersonInformation.h"
#import "RecordModel.h"

#import "UITabBar+Badge.h"

#import "WBMineContentViewController.h"

#import "ShezhiView.h"

@interface WeibaoMineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *itemArray;
    ShezhiView *shezhi;
}

@property (nonatomic, strong) WBMineContentViewController *showVC;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic) BOOL isBaoyang;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCon;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *byBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WeibaoMineViewController

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
    UIImage *issueImage = [UIImage imageNamed:@"shezhi"];
    
    UIButton *issueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    issueButton.frame = CGRectMake(0, 0, 100, 30);
    [issueButton setImage:issueImage forState:UIControlStateNormal];
    [issueButton setTitle:@"设置" forState:UIControlStateNormal];
    issueButton.titleLabel.font = [UIFont systemFontOfSize:16];
    issueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    issueButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [issueButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到导航条
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:issueButton];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;
    
}

-(void) doClickBackAction:(UIButton *)btn {
    shezhi = [[ShezhiView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    [self.view addSubview:shezhi];
    
    for (int i = 0; i < shezhi.btnArray.count; i++) {
        
        [shezhi.btnArray[i] addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) click:(UIButton *)sender {
    if (sender.tag == 1000) {
        [self logout];
    }
    [shezhi removeFromSuperview];
}

- (void)setupSubview
{
    self.navigationItem.title = @"我的";
    if (KWindowWidth == 375) {
        _rightCon.constant = -16;
    }
    if (KWindowWidth == 320) {
        _rightCon.constant = -16;
    }
    
    [self.wxBtn setImage:[UIImage imageNamed:@"wb_mine_wx_select"] forState:UIControlStateSelected];
    [self.byBtn setImage:[UIImage imageNamed:@"wb_mine_by_select"] forState:UIControlStateSelected];
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    
    [_tableView addRefreshHeaderBlock:^{
        weakSelf.pageNum  = 1;
        [weakSelf loadData];
    }];
    [_tableView addRefreshFooterBlock:^{
        weakSelf.pageNum++;
        [weakSelf loadData];
    }];
    
//    self.tableView.allowsSelection = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)loadData
{
    [self.view showHudWithActivity:@"正在加载"];
    if (_isBaoyang) {
        [self loadBYData];
        self.byBtn.selected = YES;
        self.wxBtn.selected = NO;
    }
    else
    {
        [self loadWXData];
        self.byBtn.selected = NO;
        self.wxBtn.selected = YES;
    }
}

- (void)loadWXData
{
     __weak typeof(self) weakSelf = self;
    [MaintenanceManager getMyRepairRecordWithWBid:[PersonInformation sharedPersonInformation].userID  pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:[NSString stringWithFormat:@"%d",kGetNumberOfData] success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [itemArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf chooseBlessingMeg];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf loadWXData];
            }];
        }
    }];
}

- (void)loadBYData
{
    __weak typeof(self) weakSelf = self;
    [MaintenanceManager getMyMaintainRecordWithWBid:[PersonInformation sharedPersonInformation].userID  pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:[NSString stringWithFormat:@"%d",kGetNumberOfData] success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [itemArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf chooseBlessingMeg];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                [weakSelf loadWXData];
            }];
        }
    }];
}

-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordModel *model = itemArray[indexPath.row];
    if (_isBaoyang) {
        WBBaoyangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BYcell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
      
        
        //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = model;
        
        return cell;
    }
    else
    {
        WBWeixiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WXcell" forIndexPath:indexPath];
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
        
        
        //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordModel *model = itemArray[indexPath.row];
    float width1 = KWindowWidth - 25 - 73;
    NSInteger hRow = [NSString stringWithFormat:@"%@",model.content].length * 14 / width1;
    
    NSInteger hRow2 = [NSString stringWithFormat:@"%@",model.editContent].length * 14 / width1;

    
    if (_isBaoyang) {
       
        return 215 + hRow * 14;
    }
    else
    {
        if (hRow2 > 1) {
            return 215 + 14 + hRow * 14;
        }
        else
        {
            return 215 + hRow * 14;
        }
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordModel *model = itemArray[indexPath.row];
    _showVC.rId = model.rID;
    _showVC.content = model.editContent;
}
#pragma mark - button click
- (IBAction)wxClick:(id)sender {
    
    self.wxBtn.selected = YES;
    self.byBtn.selected = NO;
    _isBaoyang = NO;
    [self.tableView.mj_header beginRefreshing];
}
- (IBAction)byClick:(id)sender {
    
    self.wxBtn.selected = NO;
    self.byBtn.selected = YES;
    _isBaoyang = YES;
    [self.tableView.mj_header beginRefreshing];

}

- (void)logout
{
    [LXFileManager saveUserData:@"" forKey:kCurrentUserInfo];
    [PersonInformation sharedPersonInformation].user_type = 0;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    _showVC = [segue destinationViewController];
}


@end
