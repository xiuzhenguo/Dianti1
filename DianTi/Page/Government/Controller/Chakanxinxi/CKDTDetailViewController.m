//
//  CKDTDetailViewController.m
//  DianTi
//
//  Created by 云彩 on 2017/4/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKDTDetailViewController.h"
#import "GoveCkManager.h"
#import "CKDTDetailTableViewCell.h"
#import "DividingLine.h"

@interface CKDTDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *leftArray;

@end

@implementation CKDTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.title = @"电梯详情";
    
    self.leftArray = @[@[@"电梯编号：",@"电梯位置：",@"设备类型："],@[@"电梯状态：",@"注册代码：",@"下次保养日期："],@[@"额定载重(Kg)：",@"额定速度(m/s)：",@"层/站/门: ",@"控制方式："],@[@"产品型号：",@"产品编号："],@[@"制造单位：",@"制造日期："],@[@"安装单位：",@"安装日期："],@[@"物业单位名称：",@"物业单位电话："],@[@"维保单位名称：",@"维保单位电话："]];
    
    [self setUpTableView];
    
    [self loadAlarmDatailData];
}

-(void) loadAlarmDatailData {
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [GoveCkManager getAlarmDatailWithLID:self.strLid pageindex:@"1" pagesize:@"10" success:^(id responseObject) {
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSDictionary *model = responseObject[@"model"];
        NSDictionary *wbcompany = model[@"wbcompany"];
        NSDictionary *wycompany = model[@"wycompany"];
        NSArray *arr0 = @[model[@"innerid"],model[@"buildno"],model[@"type"]];
        NSString *str = [NSString stringWithFormat:@"%@",model[@"state"]];
        NSLog(@"%@",model[@"state"]);
        NSArray *arr1 = @[str,model[@"regcode"],model[@"nextcaredate"]];
        NSArray *arr2 = @[model[@"ratedweight"],model[@"ratedspeed"],model[@"floorstationdoor"],model[@"controlfunc"]];
        NSArray *arr3 = @[model[@"productmodel"],model[@"productid"]];
        NSArray *arr4 = @[model[@"madeby"],model[@"madedate"]];
        NSArray *arr5 = @[model[@"installby"],model[@"installdate"]];
        NSArray *arr6 = @[wycompany[@"wyname"],wycompany[@"phone"]];
        NSArray *arr7 = @[wbcompany[@"wbname"],wbcompany[@"phone"]];
        
        self.dataArray = [NSMutableArray arrayWithObjects:arr0,arr1,arr2,arr3,arr4,arr5,arr6,arr7, nil];
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadAlarmDatailData];
            }];
        }
    }];
}

-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}



#pragma mark - 创建tableView
-(void) setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[CKDTDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 10)];
    backView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 9, KWindowWidth, 1)];
    [backView addSubview:line];
    
    return backView;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CKDTDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftArr = self.leftArray;
    cell.sction = indexPath.section;
    cell.row = indexPath.row;
    cell.rightArr = self.dataArray;

    
    return cell;
}

@end
