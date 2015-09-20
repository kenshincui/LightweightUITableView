//
//  UIView+KC.h
//  KCFramework
//
//  Created by Kenshin Cui on 15/1/20.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 *  UIView分类扩展
 */
@interface UIView (KC)

#pragma mark 尺寸
/**
 * 控件尺寸
 */
@property(assign, nonatomic) CGSize size;
/**
 * 控件宽度
 */
@property(assign, nonatomic) CGFloat width;
/**
 * 控件高度
 */
@property(assign, nonatomic) CGFloat height;
/**
 * 控件坐标
 */
@property(assign, nonatomic) CGPoint origin;
/**
 * 控件x坐标
 */
@property(assign, nonatomic) CGFloat x;
/**
 * 控件y坐标
 */
@property(assign, nonatomic) CGFloat y;

/**
 *  中心点x坐标
 */
@property(assign, nonatomic) CGFloat centerX;

/**
 *  中心点y坐标
 */
@property(assign, nonatomic) CGFloat centerY;
/**
 *  x方向最大值(控件不超出右侧边界为前提)
 */
@property(assign, nonatomic) CGFloat maxX;
/**
 *  y方向最大值（控件不超出下编辑为前提）
 */
@property(assign, nonatomic) CGFloat maxY;

@end


