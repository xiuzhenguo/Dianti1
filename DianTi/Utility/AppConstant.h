//
//  AppConstant.h
//  GoftApp
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#ifndef GoftApp_AppConstant_h
#define GoftApp_AppConstant_h


#define kErrorDomain    @"Dianti.com"

#define PlaceholderImage [UIImage imageNamed:@""]
#define kLoadingImage       [UIImage imageNamed:@""]

#define VIEWWIDTH           SCREENBOUNDS.size.width
#define VIEWHEIGHT          SCREENBOUNDS.size.height
#define SCREENBOUNDS        [UIScreen mainScreen].bounds

//适配及屏幕
#define KWindowWidth VIEWWIDTH
#define KWindowHeight VIEWHEIGHT
#define KWindowAdapterWidth VIEWWIDTH/320
#define KWindowAdapterHeight VIEWHEIGHT/568

//字体
#define TEXTFONT(r)   [UIFont fontWithName:@"Helvetica" size:r]

#define isiPhone4           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

#define Adaptive_Width(text,font) [(text) boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 50) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(font)} context:nil];

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//获取当前版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kMainColor UIColorFromRGB(0x4bc7c7)
#define kLineColor UIColorFromRGB(0xbbbbbb)

#define kBackgroundColor UIColorFromRGB(0xF3F3F3)

#define kTextColor UIColorFromRGB(0x333333)


//------------------------单利宏定义--------------------------

#define IMPLEMENT_SINGLETON_HEADER(class)\
+ (instancetype)shared##class;

#define IMPLEMENT_SINGLETON(class)\
+ (instancetype)shared##class {\
static class* shared##class = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
shared##class = [[self alloc] init];\
});\
return shared##class;\
}


//通知


#endif
