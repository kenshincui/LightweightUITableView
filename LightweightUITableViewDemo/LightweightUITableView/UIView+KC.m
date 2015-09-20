//
//  UIView+KC.m
//  KCFramework
//
//  Created by Kenshin Cui on 15/1/20.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "UIView+KC.h"

@implementation UIView (KC)
#pragma mark 控件尺寸
- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}
- (CGSize)size {
	return self.frame.size;
}
- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}
- (CGFloat)width {
	return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}
- (CGFloat)height {
	return self.frame.size.height;
}
- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}
- (CGPoint)origin {
	return self.frame.origin;
}
- (void)setX:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}
- (CGFloat)x {
	return self.frame.origin.x;
}
- (void)setY:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}
- (CGFloat)y {
	return self.frame.origin.y;
}

- (CGFloat)centerX {
	return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
	CGPoint center = self.center;
	center.x = centerX;
	self.center = center;
}
- (CGFloat)centerY {
	return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
	CGPoint center = self.center;
	center.y = centerY;
	self.center = center;
}

- (CGFloat)maxX {
	return CGRectGetMaxX(self.frame);
}
- (void)setMaxX:(CGFloat)maxX {
	self.x = maxX - self.width;
}
- (CGFloat)maxY {
	return CGRectGetMaxX(self.frame);
}
- (void)setMaxY:(CGFloat)maxY {
	self.y = maxY - self.height;
}
#pragma mark 截屏
- (UIImage *)captureScreen {
	//1.开启一个图像上下文
	UIGraphicsBeginImageContext(self.bounds.size);

	//2.渲染当前控件图层内容到上下文

	//取得当前上下文，注意此时获得的不是窗口上下文而是图像上下文
	CGContextRef context = UIGraphicsGetCurrentContext();
	//渲染图层到上下文
	[self.layer renderInContext:context];

	//3.从当前上下方获得图片
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

	//4.关闭图像上下文
	UIGraphicsEndImageContext();

	return image;
}
@end