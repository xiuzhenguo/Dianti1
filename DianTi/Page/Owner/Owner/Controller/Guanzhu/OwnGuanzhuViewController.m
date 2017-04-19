//
//  OwnGuanzhuViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/20.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnGuanzhuViewController.h"
#import "OwnerAddGZViewController.h"
#import "OwnerManager.h"
#import "PersonInformation.h"
#import "UITableView+Refresh.h"
#import "OwnerGuanzhuCell.h"
#import "DividingLine.h"
@interface OwnGuanzhuViewController ()
{
    NSMutableArray *alermArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger pageNum;
@end

@implementation OwnGuanzhuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNaviBar];
    [self setupTableview];
}

- (void)setupNaviBar
{
    

    self.navigationItem.title = @"关注";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"owner_addG"] forState:UIControlStateNormal];
    button.size = CGSizeMake(285/3, 132/3);
    [button addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -20;//此处
    self.navigationItem.rightBarButtonItems = @[negativeSeperator, item];
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
    [OwnerManager getElevatorListWithOID:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:[NSString stringWithFormat:@"%d",kGetNumberOfData] success:^(id responseObject) {
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
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count<kGetNumberOfData){
                
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
    OwnerGuanzhuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
        [cell.contentView addSubview:line1];
    }
    else
    {
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
        line2.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:line2];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    EvevatorModel *model = alermArray[indexPath.row];
    cell.model = model;
    
    __weak typeof(self) weakself = self;
    cell.chooseFinish = ^(EvevatorModel *model){
        [weakself.view showHudWithActivity:@"正在加载"];
        [OwnerManager concernNotWithOID:[PersonInformation sharedPersonInformation].userID lid:model.evevatorID success:^(id responseObject) {
            [weakself.view hideHubWithActivity];
            NSIndexPath *index;
            for (int i = 0; i < alermArray.count; i++) {
                EvevatorModel *left = alermArray[i];
                if (left.evevatorID == model.evevatorID) {
                    index = [NSIndexPath indexPathForRow:i inSection:0];
                }
            }
            [alermArray removeObjectAtIndex:index.row];
            [weakself.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index.row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        } failure:^(NSError *error) {
            [weakself.view hideHubWithActivity];
            if([error.domain isEqualToString:kErrorDomain]){
                [weakself.view showHudMessage:error.localizedDescription];
            }else{
                [weakself.view showHudMessage:@"网络异常"];
            }
            
        }];
        
    };
    
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


#pragma mark -  button click
- (void)addClick
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    OwnerAddGZViewController *addGZ = [storyboard instantiateViewControllerWithIdentifier:@"OwnerAddGZ"];
    [self.navigationController pushViewController:addGZ animated:YES];
    
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
