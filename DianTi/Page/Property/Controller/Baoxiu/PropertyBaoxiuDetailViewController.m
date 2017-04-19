//
//  PropertyBaoxiuDetailViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/7.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyBaoxiuDetailViewController.h"
#import "PropertyFaultListViewController.h"
#import "PropertyManager.h"
#import "DividingLine.h"
#import "EvevatorModel.h"
#import "PersonInformation.h"
#import "FaultModel.h"
@interface PropertyBaoxiuDetailViewController ()
{
    NSArray *faultArray;
}

@property (weak, nonatomic) IBOutlet UIView *idView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet UIView *remarkView;

@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITextField *locationTf;
@property (weak, nonatomic) IBOutlet UITextField *typeTf;
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation PropertyBaoxiuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    self.navigationItem.title = @"报修详情";
}

- (void)setupView
{
    _addBtn.layer.borderColor = kMainColor.CGColor;
    _addBtn.layer.borderWidth = 1;
    
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line3 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line4 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.typeView.height - 0.5, KWindowWidth, 0.5)];
    DividingLine *line5 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.remarkView.height - 0.5, KWindowWidth, 0.5)];
    
    [self.idView addSubview:line1];
    [self.locationView addSubview:line2];
    [self.typeView addSubview:line3];
    [self.typeView addSubview:line4];
    [self.remarkView addSubview:line5];
    
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.borderColor = kMainColor.CGColor;
    self.addBtn.layer.borderWidth = 1;
    
    self.idTF.text = [NSString stringWithFormat:@"%@",self.model.innerid];
    self.locationTf.text = [NSString stringWithFormat:@"%@",self.model.location];
    
}


- (IBAction)addClick:(id)sender {
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    PropertyFaultListViewController *areaList = [storyboard instantiateViewControllerWithIdentifier:@"FaultAreaList"];
    areaList.view.frame = CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768);
    areaList.view.layer.cornerRadius = 10;
    areaList.view.layer.masksToBounds = YES;
    areaList.view.layer.borderWidth = 1;
    areaList.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    areaList.view.backgroundColor = [UIColor whiteColor];
    areaList.chooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            NSMutableString *tempStr = [NSMutableString string];
            faultArray = array;
            for (FaultModel *faultmodel in array) {
                [tempStr appendFormat:@"%@,",faultmodel.details];
            }
            [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
            self.typeTf.text = [NSString stringWithFormat:@"%@",tempStr];
        }
        [bgview removeFromSuperview];
    };
    if (faultArray != nil || faultArray.count > 0) {
        areaList.array = [NSMutableArray arrayWithArray:faultArray];
    }
    areaList.sender = [NSString stringWithFormat:@"baoxiuDetail"];
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];

}

- (IBAction)sureClick:(id)sender {
    if (self.typeTf.text.length == 0) {
        [self.view showHudMessage:@"请选择报警原因"];
    }
    else
    {
        NSString *remark;
        if (self.remarkTF.text.length == 0) {
            remark = @"无";
        }
        else
        {
            remark = self.remarkTF.text;
        }
        NSMutableString *tempStr = [NSMutableString string];
        for (FaultModel *faultmodel in faultArray) {
            [tempStr appendFormat:@"%@,",faultmodel.faultI];
        }
        [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
        __weak typeof(self) weakself = self;
        [self.view showHudWithActivity:@"正在加载"];
        if ([self.sender isEqualToString:@"zhuijiagaojing"]) {
            [PropertyManager insertAlarmAgainWithAid:self.model.alarmId alarmType:tempStr reporterId:[PersonInformation sharedPersonInformation].userID reportType:[PersonInformation sharedPersonInformation].user_type success:^(id responseObject) {
                [weakself.view hideHubWithActivity];
                [weakself.view showHudMessage:@"操作成功"];
                [weakself performBlock:^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                } afterDelay:1];
            } failure:^(NSError *error) {
                [weakself.view hideHubWithActivity];
                if([error.domain isEqualToString:kErrorDomain]){
                    [weakself.view showHudMessage:error.localizedDescription];
                }else{
                    [weakself.view showHudMessage:@"网络异常"];
                }
            }];
        }
        else
        {
            [PropertyManager insertAlarmWithLid:self.model.evevatorID alarmType:tempStr alarmDetils:remark reporterId:[PersonInformation sharedPersonInformation].userID reportType:[PersonInformation sharedPersonInformation].user_type success:^(id responseObject) {
                [weakself.view hideHubWithActivity];
                [weakself.view showHudMessage:@"操作成功"];
                [weakself performBlock:^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                } afterDelay:1];
            } failure:^(NSError *error) {
                [weakself.view hideHubWithActivity];
                if([error.domain isEqualToString:kErrorDomain]){
                    [weakself.view showHudMessage:error.localizedDescription];
                }else{
                    [weakself.view showHudMessage:@"网络异常"];
                }
            }];
        }
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
