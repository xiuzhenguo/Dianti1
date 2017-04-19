//
//  OwnerAreaListViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/23.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerAreaListViewController.h"
#import "RegistAreaListViewController.h"
#import "AreaTableViewCell.h"
#import "AreaModel.h"
#import "DividingLine.h"
#import "OwnerManager.h"
#import "PersonInformation.h"
@interface OwnerAreaListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_areaArray;
}
@property (weak, nonatomic) IBOutlet UITableView *areaTableview;

@end

@implementation OwnerAreaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.areaTableview setBackgroundColor:self.view.backgroundColor];
    [self.areaTableview setTableFooterView:[[UITableView alloc] init]];
    [self setupNaviBar];
    [self loadData];
}

- (void)setupNaviBar
{
    self.navigationItem.title = @"修改所在小区";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"owner_tianjia"] style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -25;//此处
    self.navigationItem.rightBarButtonItems = @[negativeSeperator, item];
}



- (void)loadData
{
    
    [self.view showHudWithActivity:@"正在加载"];
    __weak typeof(self) weakself = self;
    [OwnerManager getAreaWithOID:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        [weakself.view hidFailedView];
        [weakself.view hideHubWithActivity];
        _areaArray = [NSMutableArray arrayWithArray:responseObject];
        [weakself.areaTableview reloadData];
    } failure:^(NSError *error) {
        [weakself.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakself.view showHudMessage:error.localizedDescription];
        }else{
            [weakself.view showFailedViewReloadBlock:^{

                [weakself loadData];
            }];
        }
    }];
    
    
    
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _areaArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AreaModel *model = _areaArray[indexPath.row];
    cell.model = model;
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
#pragma mark - button click
- (IBAction)sure:(id)sender {
    
    
    if (_areaArray.count > 0) {
        [self.view showHudWithActivity:@"正在加载"];
        NSMutableString *tempStr = [NSMutableString string];
        for (AreaModel *model in _areaArray) {
            [tempStr appendFormat:@"%@,",model.areaID];
        }
        [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
        __weak typeof(self) weakSelf = self;
        [OwnerManager getOwnerInfoWithOID:[PersonInformation sharedPersonInformation].userID vstr:tempStr success:^(id responseObject) {
            [weakSelf.view hideHubWithActivity];
            [weakSelf.view showHudWithActivity:@"修改成功"];
            [weakSelf performBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } afterDelay:1];
        } failure:^(NSError *error) {
            [weakSelf.view hideHubWithActivity];
            if([error.domain isEqualToString:kErrorDomain]){
                [weakSelf.view showHudMessage:error.localizedDescription];
            }else{
                [weakSelf.view showHudMessage:@"网络异常"];
            }
        }];
    }
    else
    {
        [self.view showHudMessage:@"至少添加一个小区"];
    }
    
}

- (void)addClick
{
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    RegistAreaListViewController *areaList = [storyboard instantiateViewControllerWithIdentifier:@"RegistAreaList"];
    areaList.view.frame = CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768);
    areaList.view.layer.cornerRadius = 10;
    areaList.view.layer.masksToBounds = YES;
    areaList.view.layer.borderWidth = 1;
    areaList.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    areaList.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    areaList.owenrChooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            _areaArray = [NSMutableArray arrayWithArray:array];
            [weakSelf.areaTableview reloadData];
        }
        [bgview removeFromSuperview];
    };
    
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];
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
