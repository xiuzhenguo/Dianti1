//
//  WBDianTiLiShiJiLuViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WBDianTiLiShiJiLuViewController.h"

#import "UITableView+Refresh.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"
#import "PersonInformation.h"
#import "WBWeixiuCell.h"
#import "WBBaoyangCell.h"
#import "RecordModel.h"
@interface WBDianTiLiShiJiLuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *itemArray;
}
@property (nonatomic) NSInteger pageNum;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation WBDianTiLiShiJiLuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
}

- (void)setupSubview
{
    self.navigationItem.title = @"我的";
    
    
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
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getEvevatorDetailWithLID:_lid pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"10" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        
        NSDictionary *model = responseObject[@"model"];
        if ([_sender isEqualToString:@"weixiu"]) {
            NSArray *repairlist = model[@"repairlist"];
            if (repairlist.count > 0) {
                if(repairlist.count == 0 && weakSelf.pageNum == 1){
                    [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
                }
                if(weakSelf.pageNum == 1){
                    itemArray = [NSMutableArray arrayWithArray:repairlist];
                    if(repairlist.count<kGetNumberOfData){
                        
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }else{
                    if(repairlist.count<kGetNumberOfData){
                        
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    [itemArray addObjectsFromArray:repairlist];
                }

            }

        }
        else
        {
            NSArray *maintainlist = model[@"maintainlist"];
            if (maintainlist.count > 0) {
                if(maintainlist.count == 0 && weakSelf.pageNum == 1){
                    [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
                }
                if(weakSelf.pageNum == 1){
                    itemArray = [NSMutableArray arrayWithArray:maintainlist];
                    if(maintainlist.count<kGetNumberOfData){
                        
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }else{
                    if(maintainlist.count<kGetNumberOfData){
                        
                        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    [itemArray addObjectsFromArray:maintainlist];
                }
                
            }

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
    return  itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordModel *model = [RecordModel new];
    NSDictionary *dic = itemArray[indexPath.row];
    if ([_sender isEqualToString:@"baoyang"]) {
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

        model.time = dic[@"addtime"];
        model.oldstate = dic[@"orgstate"];
        model.newstate = dic[@"maintainstate"];
        model.people = dic[@"sname"];
        model.nextTime = dic[@"nextcaredate"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.jiluModel = model;
        
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
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        model.time = dic[@"addtime"];
        model.oldstate = dic[@"orgstate"];
        model.newstate = dic[@"repairstate"];
        model.people = dic[@"sname"];
        model.editContent = dic[@"content"];
        cell.jiluModel = model;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    float width1 = KWindowWidth - 25 - 80;
    NSDictionary *dic1 = itemArray[indexPath.row];
    
    
    if ([_sender isEqualToString:@"baoyang"]) {
        
        return 160;
    }
    else
    {
        NSString *content = dic1[@"content"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
        CGRect frame = [content boundingRectWithSize:CGSizeMake(width1, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        return 146 + frame.size.height;
        
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
