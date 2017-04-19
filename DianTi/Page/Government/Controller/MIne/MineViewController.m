//
//  MineViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MineViewController.h"
#import "PersonInformation.h"
#import "DividingLine.h"
#import "LXFileManager.h"

#import "ShezhiView.h"

@interface MineViewController ()

{
    ShezhiView *shezhi;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    UIImage *issueImage = [UIImage imageNamed:@"shezhi"];
    
    UIButton *issueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    issueButton.frame = CGRectMake(0, 0, 100, 30);
    [issueButton setImage:issueImage forState:UIControlStateNormal];
    [issueButton setTitle:@"设置" forState:UIControlStateNormal];
    issueButton.titleLabel.font = [UIFont systemFontOfSize:16];
    issueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    issueButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [issueButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到导航条
    UIBarButtonItem *leftBarButtomItem = [[UIBarButtonItem alloc]initWithCustomView:issueButton];
    self.navigationItem.rightBarButtonItem = leftBarButtomItem;
    
}

-(void) doClickBackAction:(UIButton *)btn {
    shezhi = [[ShezhiView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    [self.view addSubview:shezhi];
    
    for (int i = 0; i < shezhi.btnArray.count; i++) {
        
        [shezhi.btnArray[i] addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) click:(UIButton *)sender {
    if (sender.tag == 1000) {
        [self logout];
    }
    [shezhi removeFromSuperview];
}


- (void)logout
{
    [LXFileManager saveUserData:@"" forKey:kCurrentUserInfo];
    [PersonInformation sharedPersonInformation].user_type = 0;
    [self dismissViewControllerAnimated:YES completion:^{
        
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
