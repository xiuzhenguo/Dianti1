
//
//  WBNoticeDetailViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/16.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBNoticeDetailViewController.h"
#import "MaintenanceManager.h"
@interface WBNoticeDetailViewController ()

@end

@implementation WBNoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)loadData
{
    __weak typeof(self) weakself = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getTongzhiReadWithNid:self.model.noticeID success:^(id responseObject) {

        [weakself setupSubView];
        [weakself.view hideHubWithActivity];
    } failure:^(NSError *error) {
        [weakself.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakself.view showHudMessage:error.localizedDescription];
        }else{
            [weakself.view showHudMessage:@"网络异常"];
        }
    }];
}

- (void)setupSubView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, KWindowWidth - 40, 20)];
    label1.text = [NSString stringWithFormat:@"告警时间：%@",self.model.addtime];
    label1.font = TEXTFONT(14);
    [self.view addSubview:label1];
    
    NSString *str = [NSMutableString stringWithFormat:@"%@",self.model.content];
    str = [str stringByReplacingOccurrencesOfString:@"--" withString:@"\n"];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, label1.bottom + 20, KWindowWidth - 40, 200)];
    textView.font = TEXTFONT(14);
    textView.text = str;
    textView.editable = NO;
    [self.view addSubview:textView];
    
    
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
