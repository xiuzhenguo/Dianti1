
//
//  FailedloadView.m
//  ShakeOrder
//
//  Created by aaaa on 14-7-25.
//  Copyright (c) 2014年 hjc. All rights reserved.
//

#import "FailedloadView.h"

#define FAILEDLOADIMG [UIImage imageNamed:@""]

@interface FailedloadView ()
@end

@implementation FailedloadView
{
    UIImageView * imageview;
    UILabel *titleLabel;
    UILabel *detailLabel;
    UIButton * reloadButton;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
   
        [self setBackgroundColor:[UIColor whiteColor]];
        imageview = [[UIImageView alloc]init];
        [imageview setContentMode:UIViewContentModeScaleAspectFit];
       
        imageview.frame = CGRectMake(0, 0 ,frame.size.width*57.0f/375.0f
                                     , frame.size.width*57.0f/375.0f);
        imageview.center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f-100);
        [self addSubview:imageview];
        
        [imageview setImage:FAILEDLOADIMG];
        
        

        
        titleLabel=[[UILabel alloc]init];
        [titleLabel setFrame:CGRectMake(0, imageview.frame.size.height+imageview.frame.origin.y+10, self.frame.size.width, 20)];
        [titleLabel setTextColor:kMainColor];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:@"数据加载失败！"];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:titleLabel];

        
        detailLabel=[[UILabel alloc]init];
        [detailLabel setFrame:CGRectMake(30,titleLabel.frame.size.height+titleLabel.frame.origin.y+6, self.frame.size.width-60, 20)];
        [detailLabel setTextAlignment:NSTextAlignmentCenter];
        [detailLabel setTextColor:[UIColor lightGrayColor]];
        detailLabel.numberOfLines=2;
        [detailLabel setText:@"请检查您的网络是否联网，点击按钮重新加载"];
        [detailLabel setTextAlignment:NSTextAlignmentCenter];
        [detailLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:detailLabel];
     
        reloadButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(detailLabel.frame)+16, 120, 40)];
        [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        //[reloadButton setBackgroundColor:kMainColor];
        [reloadButton.layer setBorderWidth:1];
        [reloadButton.layer setBorderColor:kMainColor.CGColor];
        [reloadButton setTitleColor:kMainColor forState:UIControlStateNormal];
        reloadButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [reloadButton.layer setCornerRadius:4];
        [reloadButton setCenter:CGPointMake(self.frame.size.width/2.0f, reloadButton.center.y)];
        [reloadButton addTarget:self action:@selector(reloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reloadButton];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
    }
    return self;
}


-(void)reloadBtnClick:(id)sender
{
    if(self.reloadBlock){
        self.reloadBlock();
    }
}


@end
