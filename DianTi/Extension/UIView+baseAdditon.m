//
//  UIView+Additon.m
//  DoubanAlbum
//
//  Created by Tonny on 12-12-10.
//  Copyright (c) 2012年 SlowsLab. All rights reserved.
//

#import "UIView+baseAdditon.h"
#import <objc/runtime.h>
#import "MBProgressHUD.h"
#define defaultViewTag 3323221
#define hubViewTag 4343523
@implementation UIView (baseAdditon)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.left + self.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    if(right == self.right){
        return;
    }
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.top + self.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    if(bottom == self.bottom){
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    if(height == self.height){
        return;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (id)subviewWithTag:(NSInteger)tag{
    for(UIView *view in [self subviews]){
        if(view.tag == tag){
            return view;
        }
    }
    
    return nil;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;

- (void)setMenuActionWithBlock:(void (^)(void))block {
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
	
	if (!gesture) {
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		void(^action)(void) = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
		
		if (action) {
			action();
		}
	}
}

- (void)moveOrigin:(CGPoint)origin
{
	self.origin = CGPointMake(self.frame.origin.x + origin.x, self.frame.origin.y + origin.y);
}

- (void)moveX:(CGFloat)x
{
	self.left = self.origin.x + x;
}

- (void)moveY:(CGFloat)y
{
	self.top = self.origin.y + y;
}



- (void)toLeft
{
	self.left = 0.0;
}

- (void)toTop
{
	self.top = 0.0;
}

- (void)toRight
{
	if( self.superview ){
		self.left = self.superview.width - self.width;
	}
}

- (void)toBottom
{
	if( self.superview ){
		self.top = self.superview.height - self.height;
	}
}

- (void)autoExpand
{
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (UIView*)subviewAtIndex:(NSInteger)index
{
	return [self.subviews objectAtIndex:index];
}

- (UIView*)prevView
{
	UIView*	view = nil;
	
	//Superviewが存在する場合のみ
	if( self.superview ){
		NSInteger	index = [self.superview indexOfSubview:self];
		if( 0 < index ){
			view = [self.superview subviewAtIndex:index-1];
		}
	}
	
	return view;
}

- (UIView*)nextView
{
	UIView*	view = nil;
	
	//Superviewが存在する場合のみ
	if( self.superview ){
		NSInteger	index = [self.superview indexOfSubview:self];
		if( index < [self.superview allSubviewsCount]-1 ){
			view = [self.superview subviewAtIndex:index+1];
		}
	}
	
	return view;
}

- (NSInteger)indexOfSubview:(UIView*)subview
{
	return [self.subviews indexOfObject:subview];
}

- (NSInteger)allSubviewsCount
{
	return [self.subviews count];
}

- (void)removeAllSubviews
{
	NSEnumerator*	enumerator = [self.subviews reverseObjectEnumerator];
	
	UIView*	subView = nil;
	while( subView = [enumerator nextObject] ){
		[subView removeFromSuperview];
	}
}

- (void)fadeInAnimationWithDuration:(NSTimeInterval)duration
						 completion:(void (^)(BOOL))completion
{
	[self.layer removeAllAnimations];
	
	self.alpha = 0.0;
	self.hidden = NO;
	
	//フェードインアニメーション
	[UIView animateWithDuration:duration
					 animations:^{
						 self.alpha = 1.0;
					 }
					 completion:^( BOOL finished ){
						 if( finished == NO ){
							 self.hidden = YES;
						 }
						 
						 //コールバック
						 if( completion ){
							 completion( finished );
						 }
					 }];
}

- (void)fadeOutAnimationWithDuration:(NSTimeInterval)duration
						  completion:(void (^)(BOOL))completion
{
	[self.layer removeAllAnimations];
	

	[UIView animateWithDuration:duration
					 animations:^{
						 self.alpha = 0.0;
					 }
					 completion:^( BOOL finished ){
						 self.alpha = 1.0;
						 if( finished == NO ){
							 self.hidden = NO;
						 }else{
							 self.hidden = YES;
						 }
						 

						 if( completion ){
							 completion( finished );
						 }
					 }];
}

- (UIImage*)capturedImageWithSize:(CGSize)size
{
	UIImage*	image = nil;
	CGRect		rect = CGRectZero;
	
	rect.size = size;
	
	UIGraphicsBeginImageContextWithOptions( /*rect.size*/self.bounds.size, NO, 0 );	// ラスト引数に0を指定する事により、機種依存の解像度を吸収してくれるっぽい
	
	CGContextRef	context = UIGraphicsGetCurrentContext();
	CGContextFillRect( context, rect );
	[self.layer renderInContext:context];
	image = [UIImage imageWithData:UIImagePNGRepresentation( UIGraphicsGetImageFromCurrentImageContext() )];
	
	UIGraphicsEndImageContext();
	
	return image;
}
// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}


- (void)showDetailMessage:(NSString *)message offset:(CGFloat)offsetY
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
//    hud.detailsLabelText = message;
    hud.detailsLabel.text = message;
    
//    hud.yOffset = offsetY;
    [hud setOffset:CGPointMake(hud.offset.x, offsetY)];
    
    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:1.5];
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)showDetailMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
//    hud.detailsLabelText = message;
    hud.detailsLabel.text = message;
    
    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:2.5];
    [hud hideAnimated:YES afterDelay:2.5];
}

- (void)showHudMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
    //CGSize textSize = [message sizeWithFont:[UIFont systemFontOfSize:16] ];
//    [hud setDetailsLabelFont:[UIFont systemFontOfSize:16]];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
  
//    hud.detailsLabelText = message;
    hud.detailsLabel.text = message;

    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:1.5];
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)showHudMessage:(NSString *)message offset:(CGFloat)offsetY
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
    //CGSize textSize = [message sizeWithFont:[UIFont systemFontOfSize:16] ];
//    [hud setDetailsLabelFont:[UIFont systemFontOfSize:16]];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    
//    hud.detailsLabelText = message;
    hud.detailsLabel.text = message;
//    hud.yOffset = offsetY;
    [hud setOffset:CGPointMake(hud.offset.x, offsetY)];
    
    
    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:1.5];
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)showHudWithActivity:(NSString *)message
{
    MBProgressHUD *hud1 = (MBProgressHUD *)[self viewWithTag:hubViewTag];
    if (hud1) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.tag = hubViewTag;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeIndeterminate;
    
    if (message && message.length>0) {
//        hud.labelText = message;
        hud.label.text = message;
    }

}
- (void)hideHubWithActivityAfterDelay:(float)seconds
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = (MBProgressHUD *)[self viewWithTag:hubViewTag];
        if (!hud) {
            return;
        }else
        {
            hud.removeFromSuperViewOnHide = YES;
//            [hud hide:YES afterDelay:seconds];
            [hud hideAnimated:YES afterDelay:seconds];
        }
    });
}
- (void)hideHubWithActivity
{
    
    dispatch_async(dispatch_get_main_queue(), ^{

        MBProgressHUD *hud = (MBProgressHUD *)[self viewWithTag:hubViewTag];
        if (!hud) {
            return;
        }else
        {
            hud.removeFromSuperViewOnHide = YES;
//            [hud hide:YES afterDelay:0];
            [hud hideAnimated:YES afterDelay:0];
        }
    });
}
//---------------------------------------------------------------------------------
#pragma mark - Override
//---------------------------------------------------------------------------------
- (BOOL)isExclusiveTouch
{

	return YES;
}

@end
