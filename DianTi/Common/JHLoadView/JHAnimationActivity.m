//
//  JHAnimationActivity.m
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "JHAnimationActivity.h"
#define  kImageSide 50
@interface JHAnimationActivity ()
@property (nonatomic, weak) UIView*toView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *backImageView;
@end

@implementation JHAnimationActivity

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if(self){
        _image = image;
    }
    return self;
}
- (void)showInView:(UIView *)view
{
    self.toView = view;
    [self setFrame:CGRectMake(0, 0, 80, 80)];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kImageSide, kImageSide)];
    [self.imageView setImage:_image];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
    [self addSubview:self.imageView];
    //[self.imageView setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    self.layer.cornerRadius = 10.0f;
    [view addSubview:self];
    
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
   
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:self.toView.bounds];
        self.backImageView.backgroundColor = [UIColor clearColor];
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    self.center = CGPointMake(self.toView.frame.size.width/2.0f, self.toView.frame.size.height/2.0f);
    [self.toView addSubview:self.backImageView];
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = 10000;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}
- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self.imageView.layer removeAnimationForKey:@"Rotation"];
}
- (void)dismiss{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    [self removeFromSuperview];
}
@end
