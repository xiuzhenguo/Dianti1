//
//  CKBJDetailViewController.m
//  DianTi
//
//  Created by 云彩 on 2017/4/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKBJDetailViewController.h"
#import "DividingLine.h"
#import "GoveCkManager.h"
#import "GJAlarmDetailModel.h"
#import "GJAlaDetailTableViewCell.h"

@interface CKBJDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UILabel *inneridLab;
@property (nonatomic, strong) UILabel *lbuildnoLab;
@property (nonatomic, strong) UILabel *lstateLab;
@property (nonatomic, strong) UILabel *wbnameLab;
@property (nonatomic, strong) UILabel *wbphoneLab;
@property (nonatomic, strong) UILabel *wyname;
@property (nonatomic, strong) UILabel *wyphone;

@end

@implementation CKBJDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.title = @"报修详情";
    
    [self setUpUItableViewUI];
    
    [self loadDataList];
}

-(void) loadDataList {
    __weak typeof(self) weakSelf = self;
    [GoveCkManager getEvevatorListWithLID:self.strLid pageindex:@"1" pagesize:@"100" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0){
            [self.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        _itemArray = [NSMutableArray arrayWithArray:tempArray];
        if(tempArray.count < 100){
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        GJAlarmDetailModel *model = _itemArray.firstObject;
        self.wbnameLab.text = model.wbname;
        self.wbphoneLab.text = model.wbphone;
        self.wyname.text = model.wyname;
        self.wyphone.text = model.wyphone;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                //                [weakSelf loadData];
            }];
        }
    }];
    
}
-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

-(void) setUpUItableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[GJAlaDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 470)];
    self.tableView.tableHeaderView = self.headerView;
    
    [self setUpTableHeaderViewUI];
}

#pragma mark - 创建头视图
-(void) setUpTableHeaderViewUI {
    NSArray *titleArr = @[@"电梯",@"维保",@"物业",@"告警"];
    for (int i = 0; i < 4; i++) {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.textColor = UIColorFromRGB(0x666666);
        titleLab.text = titleArr[i];
        
        DividingLine *line1 = [[DividingLine alloc] init];
        [self.headerView addSubview:line1];
        
        if (i == 0) {
            titleLab.frame = CGRectMake(15, 0, KWindowWidth - 30, 29.5);
            line1.frame = CGRectMake(0, 29.5, KWindowWidth, 0.5);
        }else{
            titleLab.frame = CGRectMake(15, 180+(i-1)*130, KWindowWidth - 30, 29.5);
            line1.frame = CGRectMake(0, 210+(i-1)*129.5, KWindowWidth, 0.5);
        }
        [self.headerView addSubview:titleLab];
    }
    NSArray *arr = @[@"电梯编号：",@"电梯位置：",@"电梯状态：",@"维保公司名称：",@"维保公司电话：",@"物业公司名称：",@"物业公司电话："];
    UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, KWindowWidth, 150)];
    oneView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:oneView];
    UIView *twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, KWindowWidth, 100)];
    twoView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:twoView];
    UIView *thrView = [[UIView alloc] initWithFrame:CGRectMake(0, 340, KWindowWidth, 100)];
    thrView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:thrView];
    for (int i = 0; i < 7; i++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = UIColorFromRGB(0x666666);
        lab.text = arr[i];
        CGRect with = Adaptive_Width(lab.text, lab.font)
        
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.font = [UIFont systemFontOfSize:14];
        nameLab.textColor = kTextColor;
        
        DividingLine *line = [[DividingLine alloc] init];
        
        if (i<3) {
            [oneView addSubview:lab];
            lab.frame = CGRectMake(15, 50*i, with.size.width, 49.5);
            [oneView addSubview:nameLab];
            nameLab.frame = CGRectMake(CGRectGetMaxX(lab.frame), 50*i, KWindowWidth - CGRectGetMaxX(lab.frame) - 15, 49.5);
            [oneView addSubview:line];
            line.frame = CGRectMake(0, 49.5*(i+1), KWindowWidth, 0.5);
        }else if (i>2 && i<5){
            [twoView addSubview:lab];
            lab.frame = CGRectMake(15, 50*(i - 3), with.size.width, 49.5);
            [twoView addSubview:nameLab];
            nameLab.frame = CGRectMake(CGRectGetMaxX(lab.frame), 50*(i - 3), KWindowWidth - CGRectGetMaxX(lab.frame) - 15, 49.5);
            [twoView addSubview:line];
            line.frame = CGRectMake(0, 49.5*(i-2), KWindowWidth, 0.5);
        }else{
            [thrView addSubview:lab];
            lab.frame = CGRectMake(15, 50*(i - 5), with.size.width, 49.5);
            [thrView addSubview:nameLab];
            nameLab.frame = CGRectMake(CGRectGetMaxX(lab.frame), 50*(i - 5), KWindowWidth - CGRectGetMaxX(lab.frame) - 15, 49.5);
            [thrView addSubview:line];
            line.frame = CGRectMake(0, 49.5*(i-4), KWindowWidth, 0.5);
        }
        switch (i) {
            case 0:
                self.inneridLab = nameLab;
                self.inneridLab.text = self.inneridStr;
                break;
            case 1:
                self.lbuildnoLab = nameLab;
                self.lbuildnoLab.text = self.lbuildnoStr;
                break;
            case 2:
                self.lstateLab = nameLab;
                [self textColor];
                break;
            case 3:
                self.wbnameLab = nameLab;
                break;
            case 4:
                self.wbphoneLab = nameLab;
                break;
            case 5:
                self.wyname = nameLab;
                break;
            case 6:
                self.wyphone = nameLab;
                break;
            default:
                break;
        }
    }
}

-(void) textColor {
    switch ([self.stateStr integerValue]) {
        case 1:
        {
            self.lstateLab.text = @"正常";
            self.lstateLab.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            self.lstateLab.text = @"未处理";
            self.lstateLab.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            self.lstateLab.text = @"已处理";
            self.lstateLab.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            self.lstateLab.text = @"正在维修";
            self.lstateLab.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            self.lstateLab.text = @"正在保养";
            self.lstateLab.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.itemArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GJAlarmDetailModel *model = self.itemArray[section];
    if (model.isOpen) {
        return 1;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GJAlaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GJAlarmDetailModel *model = self.itemArray[indexPath.section];
    NSLog(@"%@",model.alarmtype);
    cell.viewModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GJAlarmDetailModel *model = self.itemArray[section];
    UIButton *headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 49.5)];
    [headView addTarget:self action:@selector(cilckHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    headView.tag = 1000+section;
    headView.selected = model.isOpen;
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = [NSString stringWithFormat:@"告警时间：%@",model.addtime];
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = UIColorFromRGB(0x666666);
    CGRect with = Adaptive_Width(nameLab.text, nameLab.font);
    nameLab.frame = CGRectMake(25, 0, with.size.width, 49.5);
    [headView addSubview:nameLab];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLab.frame), 0, KWindowWidth - CGRectGetMaxX(nameLab.frame) - 50, 49.5)];
    timeLab.textColor = kTextColor;
    timeLab.font = [UIFont systemFontOfSize:14];
    [headView addSubview:timeLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 50, 5, 40, 40)];
    if (headView.selected) {
        [btn setImage:[UIImage imageNamed:@"gaojing_xiala"] forState:UIControlStateNormal];

    }else{
        
        [btn setImage:[UIImage imageNamed:@"gaojing_shangla"] forState:UIControlStateNormal];
    }
    [headView addSubview:btn];
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 49.5, KWindowWidth, 0.5)];
    [headView addSubview:line];
    return headView;
}

-(void) cilckHeaderButton:(UIButton *)sender{
    GJAlarmDetailModel *model = self.itemArray[sender.tag -1000];
    if (sender.selected) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
    model.isOpen = sender.selected;
    [self.tableView reloadData];

}

@end
