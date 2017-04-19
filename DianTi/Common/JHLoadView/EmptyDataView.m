//
//  EmptyDataView.m
//  Huodi
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "EmptyDataView.h"

#define FAILEDLOADIMG [UIImage imageNamed:@""]

@implementation EmptyDataView
{
    UIImageView * imageview;
    UILabel *titleLabel;
   // UILabel *detailLabel;
    UIButton * actionButton;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title actionTitle:(NSString *)actionTitle;
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
        [titleLabel setTextColor:[UIColor grayColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:titleLabel];
        
        
//        detailLabel=[[UILabel alloc]init];
//        [detailLabel setFrame:CGRectMake(30,titleLabel.frame.size.height+titleLabel.frame.origin.y+6, self.frame.size.width-60, 20)];
//        [detailLabel setTextAlignment:NSTextAlignmentCenter];
//        [detailLabel setTextColor:[UIColor lightGrayColor]];
//        detailLabel.numberOfLines=2;
//        [detailLabel setText:@"请检查您的网络是否联网，点击按钮重新加载"];
//        [detailLabel setTextAlignment:NSTextAlignmentCenter];
//        [detailLabel setFont:[UIFont systemFontOfSize:13]];
//        [self addSubview:detailLabel];
        
        if(actionTitle.length){
            actionButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+16, 120, 40)];
            [actionButton setTitle:actionTitle forState:UIControlStateNormal];
            //[reloadButton setBackgroundColor:kMainColor];
            [actionButton.layer setBorderWidth:1];
            [actionButton.layer setBorderColor:kMainColor.CGColor];
            [actionButton setTitleColor:kMainColor forState:UIControlStateNormal];
            actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [actionButton.layer setCornerRadius:4];
            [actionButton setCenter:CGPointMake(self.frame.size.width/2.0f, actionButton.center.y)];
            [actionButton addTarget:self action:@selector(reloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:actionButton];
            self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            
        }

    }
    return self;
}

-(void)reloadBtnClick:(id)sender
{
    if(self.actionBlock){
        self.actionBlock();
    }
}

@end
