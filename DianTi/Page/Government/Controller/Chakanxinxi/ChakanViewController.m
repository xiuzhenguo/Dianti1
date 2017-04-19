//
//  ChakanViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ChakanViewController.h"
#import "CKBaoJingViewController.h"
#import "CKDianTiViewController.h"
#import "CKWYComViewController.h"
#import "CKWBComViewController.h"

@interface ChakanViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;

@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;


@end

@implementation ChakanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setLabel];
}

- (void)setLabel
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(_topButton.left - 30, _topButton.bottom, _topButton.width + 60, 18)];
    label1.text = @"报修信息";
    label1.font = TEXTFONT(18);
    label1.textColor = UIColorFromRGB(0x1c941c);
    label1.textAlignment = 1;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(_leftButton.left - 30, _leftButton.bottom, _leftButton.width + 60, 18)];
    label2.text = @"物业公司管理";
    label2.font = TEXTFONT(18);
    label2.textColor = UIColorFromRGB(0x188181);
    label2.textAlignment = 1;
    [self.centerView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(_rightButton.left - 30, _rightButton.bottom, _rightButton.width + 60, 18)];
    label3.text = @"维保公司管理";
    label3.font = TEXTFONT(18);
    label3.textColor = UIColorFromRGB(0x1e3e88);
    label3.textAlignment = 1;
    [self.centerView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(_bottomButton.left - 30, _bottomButton.bottom, _bottomButton.width + 60, 18)];
    label4.text = @"电梯信息";
    label4.font = TEXTFONT(18);
    label4.textColor = UIColorFromRGB(0xa6781f);
    label4.textAlignment = 1;
    [self.view addSubview:label4];
}
- (void)setupSubview
{
    self.navigationItem.title = @"查看信息";
    _topDistance.constant = _topDistance.constant * KWindowHeight / 736;
    _bottomDistance.constant = _bottomDistance.constant * KWindowHeight / 736;
    _leftDistance.constant = _leftDistance.constant * KWindowWidth / 414;
    _rightDistance.constant = _rightDistance.constant * KWindowWidth / 414;
    
    [_topButton setImage:[UIImage imageNamed:@"zhengfu_chakanxinxi_gaojing_click"] forState:UIControlStateHighlighted];
    [_leftButton setImage:[UIImage imageNamed:@"zhengfu_chakanxinxi_weixiu_click"] forState:UIControlStateHighlighted];
    [_rightButton setImage:[UIImage imageNamed:@"zhengfu_chakanxinxi_baoyang_click"] forState:UIControlStateHighlighted];
    [_bottomButton setImage:[UIImage imageNamed:@"zhengfu_chakanxinxi_dianti_click"] forState:UIControlStateHighlighted];
}

- (IBAction)gaojingClick:(id)sender {
//    [self.view showHudMessage:@"正在开发中...."];
    CKBaoJingViewController *vc = [[CKBaoJingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)weixiuClick:(id)sender {
//    [self.view showHudMessage:@"正在开发中...."];
    CKWYComViewController *vc = [[CKWYComViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)baoyangClick:(id)sender {
//    [self.view showHudMessage:@"正在开发中...."];
    CKWBComViewController *vc = [[CKWBComViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)diantiClick:(id)sender {
//    [self.view showHudMessage:@"正在开发中...."];
    CKDianTiViewController *vc = [[CKDianTiViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
