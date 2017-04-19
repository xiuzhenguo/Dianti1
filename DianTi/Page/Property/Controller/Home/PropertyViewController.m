//
//  PropertyViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/29.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyViewController.h"
#import "PersonInformation.h"
#import "PropertyManager.h"
@interface PropertyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"主页";
    [self loadData];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [PropertyManager getInfoWithWYID:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSDictionary *dic = responseObject;
        weakSelf.topLabel.text = [NSString stringWithFormat:@"物业名称:%@",dic[@"wyname"]];
        weakSelf.centerLabel.text = [NSString stringWithFormat:@"物业电话:%@",dic[@"phone"]];
        weakSelf.bottomLabel.text = [NSString stringWithFormat:@"物业地址:%@",dic[@"address"]];
        
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
