//
//  ShezhiView.m
//  DianTi
//
//  Created by 云彩 on 2017/4/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ShezhiView.h"

@implementation ShezhiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void) setup {
    // swudhwudwdw
    
    NSArray *array = @[@"登出",@"修改密码"];
    self.btnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i< 2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 160, 1+41*i, 160, 40)];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.backgroundColor = UIColorFromRGB(0x4bc7c7);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:btn];
//        btn.tag = 1000+i;
        [self.btnArray addObject:btn];
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(KWindowWidth - 160, 42, 160, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}

-(void) hiddenSelf {
    [self removeFromSuperview];
}

@end
