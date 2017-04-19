

//
//  WBMineContentViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WBMineContentViewController.h"
#import "DividingLine.h"
#import "MaintenanceManager.h"
#import "PersonInformation.h"
@interface WBMineContentViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *textBgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation WBMineContentViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.textBgView.height, KWindowWidth, 0.5)];
    [self.textBgView addSubview:line1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
}

- (void)setupSubview
{
    self.textView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    self.textView.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    
    self.textView.text = self.content;
    
    _numberLabel.text = [NSString stringWithFormat:@"%d/200",[self countTheStrLength:self.textView.text]];
}

- (IBAction)sureClick:(id)sender {
    
    if ([self countTheStrLength:self.textView.text] > 200) {
        [self.view showHudMessage:@"网络异常"];
        return;
    }
    __weak typeof(self) weakself = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager postMyRepairContentWithRid:_rId wbid:[PersonInformation sharedPersonInformation].userID  staffid:[PersonInformation sharedPersonInformation].staffid content:_textView.text success:^(id responseObject) {
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

- (void)textViewDidChange:(UITextView *)textView
{
    _numberLabel.text = [NSString stringWithFormat:@"%d/200",[self countTheStrLength:self.textView.text]];
}

- (int)countTheStrLength:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
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
