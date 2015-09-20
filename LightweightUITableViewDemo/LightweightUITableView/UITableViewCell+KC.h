//
//  UITableViewCell+KC.h
//  KCFramework
//
//  Created by Kenshin Cui on 15/1/16.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UITableViewCell扩展方法
 */
@interface UITableViewCell (KC)
#pragma mark - 公共方法
/**
*  快速创建一个可重用Cell
*
*  @param tableView 当前UITableView（从此缓存池中获取可重用Cell）
*
*  @return 可重用Cell
*/
+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView;

/**
 *  创建xib
 *
 *  @param name       xib的名字
 *  @param tableView  tableview
 *  @param identifier cell重用标示符
 *
 *  @return 返回自定义的cell
 */
+ (UITableViewCell *)loadCellWithName:(NSString *)name tableView:(UITableView *)tableView reusableIdentifier:(NSString *)identifier;

/**
 *  自定义cell选中显示的视图
 *
 *  @param color 选中视图的颜色
 */
+ (UIView *)selectedBackgroundViewWithColor:(UIColor *)color;

/**
 *  用于设置tableview上cell底部的线条两端无间隔显示完全
 *
 *  tableview需要设置
 *  -tableView:willDisplayCell:forRowAtIndexPath:调用传入cell
 *
 *  @param view 为tableview 或 tableViewCell
 */
+ (void)setEdgeInsetsZeroForTableViewCell:(id)view;

/**
 *
 *  @param insets 距离cell上下左右的距离
 *  @param view   为tableview 和tableViewCell
 */
+ (void)setEdgeInsets:(UIEdgeInsets)insets forTableViewCell:(id)view;


#pragma mark - 属性
/**
 *  取得Cell所在的TableView
 */
@property (strong,nonatomic) UITableView *tableView;
/**
 *  分割线是否延伸到两端
 */
@property (assign,nonatomic) BOOL seperatorPinToSupperviewMargins;

@end
