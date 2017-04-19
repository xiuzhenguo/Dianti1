//
//  JHRefreshGifHeader.m
//  Huodi
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "JHRefreshGifHeader.h"
@interface JHRefreshGifHeader()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation JHRefreshGifHeader
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.1 forState:state];
}

#pragma mark - 实现父类的方法
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
}

- (void)placeSubviews
{
    [super placeSubviews];
    if (self.stateLabel.hidden) return;
    
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    
    if (self.lastUpdatedTimeLabel.hidden) {
        // 状态
        CGRect frame = self.bounds;
        frame.origin.y=10;
        frame.size.height = frame.size.height-frame.origin.y;
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = frame;
    } else {
        CGFloat stateLabelH = self.mj_h * 0.5;
        // 状态
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.mj_x = 0;
            self.stateLabel.mj_y = 0;
            self.stateLabel.mj_w = self.mj_w;
            self.stateLabel.mj_h = stateLabelH;
        }
        
        // 更新时间
        if (self.lastUpdatedTimeLabel.constraints.count == 0) {
            self.lastUpdatedTimeLabel.mj_x = 0;
            self.lastUpdatedTimeLabel.mj_y = stateLabelH;
            self.lastUpdatedTimeLabel.mj_w = self.mj_w;
            self.lastUpdatedTimeLabel.mj_h = self.mj_h - self.lastUpdatedTimeLabel.mj_y;
        }
    }

    if (self.gifView.constraints.count) return;
    CGRect frame = self.bounds;
    frame.origin.y=-6;
//    frame.origin.x += 40;
//    frame.size.height = frame.size.height-frame.origin.y;
    self.gifView.frame = frame;
    self.stateLabel.mj_y += 12;
//    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
//        self.gifView.contentMode = UIViewContentModeCenter;
//    } else {
//        self.gifView.contentMode = UIViewContentModeRight;
//        self.gifView.mj_w = self.mj_w * 0.5 - 90;
//    }
    self.gifView.contentMode = UIViewContentModeCenter;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateIdle) {
        [self.gifView stopAnimating];
    }
}

@end
