//
//  KCTableViewDelegate.h
//  CMJStudio
//
//  Created by KenshinCui on 15/3/17.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  UITableView代理对象，用于创建轻量级UIViewController或UITableViewController
 *
 *  注意：
 *  1.对于过个不同的分组头、尾视图，必须自己实现viewForHeaderInSectionBlock、viewForFooterInSectionBlock
 *       而不能直接使用headerViewBlock、footerViewBlock配置
 *  2.如果UITableView设置了autoCellHeight=YES没有特殊行高计算的情况下可以省略heightForRowAtIndexPathBlock设置
 */
@interface KCTableViewDelegate : NSObject <UITableViewDelegate>
/**
 *  注册头、尾部视图类型
 *
 *  @param nibName         Xib名称
 *  @param reuseInditifier 重用标识
 *  @param tableView       表格
 */
- (void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forHeaderWithTableView:(UITableView *)tableView;
/**
 *  注册头部视图类型
 *
 *  @param cls             类型
 *  @param reuseInditifier 重用标识
 *  @param tableView       表格
 */
- (void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forHeaderWithTableView:(UITableView *)tableView;
/**
 *  注册尾部视图类型
 *
 *  @param cls             Xib名称
 *  @param reuseInditifier 重用标识
 *  @param tableView       表格
 */
- (void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forFooterWithTableView:(UITableView *)tableView;
/**
 *  注册尾部视图类型
 *
 *  @param cls             类型
 *  @param reuseInditifier 重用标识
 *  @param tableView       表格
 */
- (void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forFooterWithTableView:(UITableView *)tableView;

#pragma mark - UITableView相关代理实现属性
/**
 *  Header类型
 *
 *  注意：必须继承于UITableViewHeaderFooterView并且只有自定义分组头时才需要指定
 */
@property(strong, nonatomic) Class headerClass;

/**
 *  Footer类型，注意必须继承于UITableViewHeaderFooterView
 */
@property(strong, nonatomic) Class footerClass;

/**
 *  Header重用标识
 */
@property(copy, nonatomic) NSString *headerIdentifier;

/**
 *  Footer重用标识
 */
@property(copy, nonatomic) NSString *footerIdentifier;

/**
 *  选中某行回调
 */
@property(copy, nonatomic) void (^selectRowAtIndexPathBlock)(id cell, NSIndexPath *indexPath);

/**
 *  取消选中某行回调
 */
@property(copy, nonatomic) void (^deselectRowAtIndexPathBlock)(id cell, NSIndexPath *indexPath);

/**
 *  将要显示单元格时回调
 */
@property(copy, nonatomic) void (^willDisplayCellBlock)(id cell, NSIndexPath *indexPath);

/**
 *  将要结束显示单元格时的回调
 */
@property(copy, nonatomic) void (^endDisplayingCellBlock)(id cell, NSIndexPath *indexPath);

/**
 *  将要结束显示头部视图时的回调
 */
@property(copy, nonatomic) void (^endDisplayingHeaderBlock)(UIView *header, NSInteger section);

/**
 *  将要结束显示尾部视图时的回调
 */
@property(copy, nonatomic) void (^endDisplayingFooterBlock)(UIView *footer, NSInteger section);

/**
 *  高度计算回调
 */
@property(copy, nonatomic) CGFloat (^heightForRowAtIndexPathBlock)(NSIndexPath *indexPath);

/**
 *  分组头部高度回调
 */
@property(copy, nonatomic) CGFloat (^heightForHeaderInSectionBlock)(NSInteger section);

/**
 *  分组尾部高度回调
 */
@property(copy, nonatomic) CGFloat (^heightForFooterInSectionBlock)(NSInteger section);

/**
 *  分组标题视图配置，必须自己实现头部缓存，支持多个不同section视图
 */
@property(copy, nonatomic) UIView * (^viewForHeaderInSectionBlock)(UITableView *tableView, NSInteger section);
/**
 *  分组标题视图配置
 */
@property(copy, nonatomic) void (^headerViewBlock)(id headerView, NSInteger section);

/**
 *  分组尾部标题视图回调
 */
@property(copy, nonatomic) UIView * (^viewForFooterInSectionBlock)(UITableView *tableView, NSInteger section);
/**
 *  分组尾部标题视图回调
 */
@property(copy, nonatomic) void (^footerViewBlock)(id footerView, NSInteger section);

#pragma mark - UIScrollView相关代理实现属性
/**
 *  开始滚动回调
 */
@property(copy, nonatomic) void (^scrollViewDidScrollBlock)(UIScrollView *scrollView);

/**
 *  即将停止滚动回调
 */
@property(copy, nonatomic) void (^scrollViewWillBeginDeceleratingBlock)(UIScrollView *scrollView);

/**
 *  停止滚动回调
 */
@property(copy, nonatomic) void (^scrollViewDidEndDeceleratingBlock)(UIScrollView *scrollView);

/**
 *  即将停止拖拽回调
 */
@property(copy, nonatomic) void (^scrollViewWillEndDraggingBlock)(UIScrollView *scrollView, CGPoint velocity, CGPoint *targetContentOffset);

/**
 *  拖拽停止回调
 */
@property(copy, nonatomic) void (^scrollViewDidEndDraggingBlock)(UIScrollView *scrollView, BOOL decelerate);

/**
 *  滚动动画结束回调(注意只用调用程序滚动才会调用此方法[例如：scrollToRowAtIndexPath:indexPath atScrollPosition: animated:]，手动滚动不会调用)
 */
@property(copy, nonatomic) void (^scrollViewDidEndScrollingAnimationBlock)(UIScrollView *scrollView);

@end
