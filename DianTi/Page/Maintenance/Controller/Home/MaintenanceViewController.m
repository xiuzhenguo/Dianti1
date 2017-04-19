//
//  MaintenanceViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/29.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "MaintenanceViewController.h"
#import "MaintenanceManager.h"
#import "PersonInformation.h"
#import "UITabBar+Badge.h"
@interface MaintenanceViewController ()

@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel2;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MaintenanceViewController

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
    [self loadData];
    self.navigationItem.title = @"主页";
}


- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getInfoWithWBID:[PersonInformation sharedPersonInformation].userID staffid:[PersonInformation sharedPersonInformation].staffid success:^(id responseObject) {
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSDictionary *dic = responseObject;
        if ([[PersonInformation sharedPersonInformation].power integerValue] == 3) {
            weakSelf.namelabel.text = [NSString stringWithFormat:@"维保名称:%@",dic[@"wbname"]];
            weakSelf.phoneLable.text = [NSString stringWithFormat:@"维保电话:%@",dic[@"phone"]];
            weakSelf.phoneLabel2.text = [NSString stringWithFormat:@"维保应急电话:%@",dic[@"hotphone"]];
            weakSelf.addressLabel.text = [NSString stringWithFormat:@"维保地址:%@",dic[@"address"]];
        }
        else
        {
            weakSelf.namelabel.text = [NSString stringWithFormat:@"维保名称:%@\n维保电话:%@\n维保应急电话:%@\n维保地址:%@",dic[@"wbname"],dic[@"wbphone"],dic[@"wbhotphone"],dic[@"wbaddress"]];
            weakSelf.phoneLable.text = @"";

            weakSelf.phoneLabel2.text = [NSString stringWithFormat:@"维保员工工号:%@\n维保员工姓名:%@\n维保员工电话:%@\n维保员工权限:%@",dic[@"jobNo"],dic[@"name"],dic[@"phone"],dic[@"power"]];
            weakSelf.addressLabel.text = @"";

        }
    } failure:^(NSError *error) {
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
