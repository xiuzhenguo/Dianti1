//
//  CKBaoJingView.h
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GaoJingModel.h"


typedef void(^selectBlock) (NSString *titleStr);
typedef void(^isselectBlock) (NSString *titleStr);

@interface CKBaoJingView : UIView

@property (nonatomic, strong) selectBlock finishButtonTitleStr;
@property (nonatomic, strong) isselectBlock finishButtonTitleID;

@property (nonatomic, strong) NSString *strId;

@property (nonatomic, strong) NSString *nameStr;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *type;

@end
