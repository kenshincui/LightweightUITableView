//
//  KCTableViewCell.h
//  CMJStudio
//
//  Created by KenshinCui on 15/4/1.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  UITableViewCell扩展类，实现Cell间距设置、背景设置等功能
 *
 *  注意：
 *  1.使用此类时所有子控件需要添加到containerView中而不要添加到contentView中
 *  2.子控件添加时必须按照自上而下的顺序添加（因为高度计算依靠最后一个控件）
 *  3.子类在模型设置中可以获取containerView的宽度，但是无法获取高度，只有在layoutSubViews中可以获得其高度
 *  4.如果需要指定边框底部内间距，需要创建对象之后立即设置（必须发生在模型设置之前）
 *  5.外部必须调用一次height方法（事实上不调用height，此类也没有太多意义了）
 */
@interface KCTableViewCell : UITableViewCell

#pragma mark - 公共方法


#pragma mark - 属性
/**
 *  Cell外边距（margin）
 */
@property(assign, nonatomic) UIEdgeInsets containerInset;
/**
 *  Cell内下边距（padding-bottom）
 */
@property(assign, nonatomic) CGFloat containerPaddingBottom;
/**
 *  边框宽度
 */
@property(assign, nonatomic) CGFloat borderWidth;
/**
 *  边框颜色
 */
@property(strong, nonatomic) UIColor *borderColor;
/**
 *  Cell容器视图
 */
@property(strong, nonatomic) UIView *containerView;
/**
 *  Cell最终高度
 */
@property(assign, nonatomic) CGFloat height;
@end
