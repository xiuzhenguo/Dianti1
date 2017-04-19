//
//  UIView+Additon.h
//  DoubanAlbum
//
//  Created by Tonny on 12-12-10.
//  Copyright (c) 2012年 SlowsLab. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEVICE_IS_IPHONE5                   ([[UIScreen mainScreen] bounds].size.height == 568)
#define DEVICE_IS_IPHONE4                   ([[UIScreen mainScreen] bounds].size.height == 480)
#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height

#define SystemNavbarHeight                  self.navigationController.navigationBar.frame.size.height

#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]

#define IsiOS7Later                         (IOSVersion >= 7.0)

#define NavBarHeight                        (IsiOS7Later ? (SystemNavbarHeight + StatusBarHeight) : SystemNavbarHeight)

#define NavTopOffset                        (IsiOS7Later ?  StatusBarHeight : 0)
@interface UIView (baseAdditon)

/**
 
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

- (id)subviewWithTag:(NSInteger)tag;

- (UIViewController*)viewController;

- (void)setMenuActionWithBlock:(void (^)(void))block;

- (void)moveOrigin:(CGPoint)origin;
- (void)moveX:(CGFloat)x;
- (void)moveY:(CGFloat)y;



- (void)toLeft;
- (void)toTop;
- (void)toRight;
- (void)toBottom;

- (void)autoExpand;
- (void) fitInSize: (CGSize) aSize;

- (UIView*)subviewAtIndex:(NSInteger)index;
- (UIView*)prevView;
- (UIView*)nextView;
- (NSInteger)indexOfSubview:(UIView*)subview;
- (NSInteger)allSubviewsCount;

- (void)removeAllSubviews;

- (void)fadeInAnimationWithDuration:(NSTimeInterval)duration
						 completion:(void (^)(BOOL))completion;
- (void)fadeOutAnimationWithDuration:(NSTimeInterval)duration
						  completion:(void (^)(BOOL))completion;

- (UIImage*)capturedImageWithSize:(CGSize)size;

- (void)showHudMessage:(NSString *)message;
- (void)showHudMessage:(NSString *)message offset:(CGFloat)offsetY;
- (void)showDetailMessage:(NSString *)message;
- (void)showDetailMessage:(NSString *)message offset:(CGFloat)offsetY;


// 带加载圈的HUD
- (void)showHudWithActivity:(NSString *)message;
- (void)hideHubWithActivityAfterDelay:(float)seconds;

- (void)hideHubWithActivity;

@end
