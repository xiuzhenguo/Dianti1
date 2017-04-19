//
//  PropertyBaoxiuViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/3.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyBaoxiuViewController.h"
#import "PropertyBaoxiuDetailViewController.h"

#import "UITableView+Refresh.h"
#import "UIImage+Color.h"

#import "PropertyManager.h"

#import "DividingLine.h"
#import "PropertyBaoxiuCell.h"

#import "PersonInformation.h"
#import "AreaModel.h"
#import "EvevatorModel.h"

@interface PropertyBaoxiuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *leftArray;
    NSMutableArray *areaArray;
    CAShapeLayer *yuan;
    CAShapeLayer *fang;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger pageNum;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (nonnull, strong) UILabel *areaLabelcopy;
@property (nonatomic, strong) UIView *dropView;
@property (weak, nonatomic) IBOutlet UIButton *xialaBtn;
@property (nonatomic, strong) PropertyBaoxiuDetailViewController *showVC;

@end

@implementation PropertyBaoxiuViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[self.areaLabel bounds] byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    yuan = [CAShapeLayer layer];
    yuan.path = path.CGPath;
    yuan.strokeColor = [UIColor lightGrayColor].CGColor;
    yuan.lineWidth = 0.5;
    yuan.fillColor = [UIColor whiteColor].CGColor;
    [self.areaLabel.layer addSublayer:yuan];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:[self.areaLabel bounds] byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    fang = [CAShapeLayer layer];
    fang.path = path1.CGPath;
    fang.strokeColor = [UIColor lightGrayColor].CGColor;
    fang.lineWidth = 0.5;
    fang.fillColor = [UIColor whiteColor].CGColor;
    
    self.areaLabelcopy.frame = CGRectMake(self.areaLabel.left, self.areaLabel.top, self.areaLabel.width - 41, self.areaLabel.height);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"电梯报修列表页";
    [self setupSubview];
}

- (void)setupSubview
{
    self.dropView = [UIView new];
    [_xialaBtn setImage:[UIImage imageNamed:@"property_baoxiu_shang"] forState:UIControlStateSelected];
    self.areaLabelcopy = [UILabel new];
    self.areaLabelcopy.font = self.areaLabel.font;
    self.areaLabelcopy.backgroundColor = [UIColor clearColor];
    self.areaLabelcopy.textColor = self.areaLabelcopy.textColor;
    self.areaLabelcopy.textAlignment = 1;
    [self.view addSubview:self.areaLabelcopy];
    
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
    [PropertyManager getAreaWithWYID:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        [weakSelf.view hidFailedView];
         areaArray = responseObject;
        if (areaArray.count > 0) {
            AreaModel *model = areaArray[0];
            weakSelf.areaLabelcopy.text = [NSString stringWithFormat:@"%@",model.areaName];
            [weakSelf loadDataWith:model.areaID];
        }
       else
       {
           weakSelf.areaLabelcopy.text = @"无小区";
           [weakSelf chooseBlessingMeg];
           [weakSelf.view hideHubWithActivity];
       }
        
        
        
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

- (void)loadDataWith:(NSString *)areaID
{
    __weak typeof(self) weakSelf = self;
    [PropertyManager getElevatorListWithVid:areaID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"10" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            leftArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [leftArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
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


-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (IBAction)dropdownClick:(id)sender {
    
    
    UIButton *button = sender;
    button.selected = !button.selected;
    
    if (button.selected) {
        [yuan removeFromSuperlayer];
        [self.areaLabel.layer addSublayer:fang];
        
        self.dropView.frame = CGRectMake(self.areaLabel.left, self.areaLabel.bottom, self.areaLabel.width - 41, self.areaLabel.height * areaArray.count);
        self.dropView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.dropView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.dropView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer = [CAShapeLayer layer];
        maskLayer.path = maskPath.CGPath;
        maskLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        maskLayer.lineWidth = 1.5;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.dropView.layer addSublayer:maskLayer];
        self.dropView.layer.masksToBounds = YES;
        
        
        for (int i=0; i<areaArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            AreaModel *model = areaArray[i];
            button.frame = CGRectMake(0, 0 + i * self.areaLabel.height, self.dropView.width, self.areaLabel.height);
            button.titleLabel.font = TEXTFONT(14);
            [button setTitle:model.areaName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:kMainColor] forState:UIControlStateHighlighted];
            button.tag = 150 + i;
            [button addTarget:self action:@selector(areaSelect:) forControlEvents:UIControlEventTouchUpInside];
            [self.dropView addSubview:button];
            if (i < areaArray.count - 1) {
                DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, button.height - 1, button.width, 1)];
                [button addSubview:line];
                
            }
            
        }
    }
    else
    {
        [fang removeFromSuperlayer];
        [self.areaLabel.layer addSublayer:yuan];
        [self.dropView removeFromSuperview];
    }

}

- (void)areaSelect:(UIButton *)button
{
    [fang removeFromSuperlayer];
    [self.areaLabel.layer addSublayer:yuan];
    [self.dropView removeFromSuperview];
    AreaModel *model = areaArray[button.tag - 150];
    self.areaLabelcopy.text = [NSString stringWithFormat:@"%@",model.areaName];
    _xialaBtn.selected = !_xialaBtn.selected;
    [self loadDataWith:model.areaID];
    
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  leftArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyBaoxiuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
    EvevatorModel *model = leftArray[indexPath.row];
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
    EvevatorModel *model = leftArray[indexPath.row];
    _showVC.model = model;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    _showVC = [segue destinationViewController];
    
}


@end
