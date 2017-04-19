//
//  RegistAreaListViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/2.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "RegistAreaListViewController.h"
#import "AreaTableViewCell.h"
#import "AreaModel.h"
#import "DividingLine.h"
@interface RegistAreaListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_areaArray;
}
@property (weak, nonatomic) IBOutlet UITableView *areaTableview;

@end

@implementation RegistAreaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.areaTableview setBackgroundColor:self.view.backgroundColor];
    [self.areaTableview setTableFooterView:[[UITableView alloc] init]];
    [self loadData];
}
- (IBAction)closeClick:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    if (self.chooseFinish) {
        self.chooseFinish(nil);
    }
}
- (IBAction)sureClick:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    NSMutableArray *tempArray = [NSMutableArray array];
    if (_areaArray.count > 0) {
        for (AreaModel *model in _areaArray) {
            if ([model.state integerValue] == 1) {
                [tempArray addObject:model.areaID];
            }
        }
    }
    if (self.chooseFinish) {
        self.chooseFinish(tempArray);
    }
}

- (void)loadData
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 1; i < 5; i++) {
        AreaModel *model = [AreaModel new];
        model.areaName = @"小区名称：幸福小区";
        model.areaID = @"101010101";
        model.location = @"大连市沙河口区万岁街99号";
        model.state = @"0";
        [tempArray addObject:model];
    }
    _areaArray = tempArray;
    [self.areaTableview reloadData];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AreaModel *model = _areaArray[indexPath.row];
    if ([model.state integerValue] == 1) {
        model.state = @"0";
    }
    else
    {
        model.state = @"1";
    }
    AreaTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.model = model;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
