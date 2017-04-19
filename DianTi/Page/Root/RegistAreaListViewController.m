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
#import "LoginManager.h"
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
    NSMutableArray *tempArray1 = [NSMutableArray array];
    if (_areaArray.count > 0) {
        for (AreaModel *model in _areaArray) {
            if ([model.state integerValue] == 1) {
                [tempArray1 addObject:model];
            }
        }
    }
    if (self.owenrChooseFinish) {
        self.owenrChooseFinish(tempArray1);
    }
}

- (void)loadData
{
    
    [self.view showHudWithActivity:@"正在加载"];
    __weak typeof(self) weakself = self;
    
    [LoginManager getAreaListWithPageindex:@"1" pagesize:[NSString stringWithFormat:@"%d",kGetNumberOfData] where:@"-xyz" success:^(id responseObject) {
        
        [weakself.view hideHubWithActivity];
        [weakself.view hidFailedView];
        _areaArray = responseObject;
        if (self.array == nil || self.array.count == 0) {
            
        }
        else{
            NSLog(@"%@",_areaArray);
            NSLog(@"%@",weakself.array);
            for (AreaModel *model in _areaArray) {
                for (AreaModel *model1 in weakself.array) {
                    if (model.areaID == model1.areaID) {
                        model.state = @"1";
                    }
                }
            }
        }
        
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
