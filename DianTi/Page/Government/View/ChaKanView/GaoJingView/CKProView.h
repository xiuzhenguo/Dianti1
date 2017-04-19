//
//  CKProView.h
//  DianTi
//
//  Created by 云彩 on 2017/4/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock) (NSString *titleArr);
typedef void(^isselectBlock) (NSString *titleID);

@interface CKProView : UIView

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) selectBlock finishButtonTitStr;
@property (nonatomic, strong) isselectBlock finishButtonTitID;

@end
