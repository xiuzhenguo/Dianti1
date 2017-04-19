//
//  OwnerAlarmViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/20.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerAlarmViewController.h"
#import "OwnerManager.h"
#import "PersonInformation.h"
#import "UITableView+Refresh.h"
#import "PropertyAlermCell.h"
#import "PropertyAlarmDetailsViewController.h"
#import "DividingLine.h"
@interface OwnerAlarmViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *alermArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic, strong) PropertyAlarmDetailsViewController *detailVC;

@end

@implementation OwnerAlarmViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"告警";
    [self setupTableview];
}

- (void)setupTableview
{
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
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [OwnerManager getAlarmListWithOID:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:[NSString stringWithFormat:@"%d",kGetNumberOfData] success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            alermArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [alermArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf chooseBlessingMeg];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf loadData];
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
    return  alermArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyAlermCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
    
    EvevatorModel *model = alermArray[indexPath.row];
    cell.evevator = model;
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EvevatorModel *evevator = alermArray[indexPath.row];
    _detailVC.lid = evevator.evevatorID;
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
    _detailVC = [segue destinationViewController];
}


@end
