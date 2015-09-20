//
//  UITableView+KC.h
//  CMJStudio
//
//  Created by KenshinCui on 15/4/29.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UITableView分类扩展,添加高度缓存，解决动态行高问题
 *
 *  使用：
 *  1.设置autoCellHeight=YES
 *  2.在tableView:heightForRowAtIndexPath:代理方法中调用heightWithIndexPath:返回高度
 *  3.为了更有效的预缓存高度建议使用之前设置UITableView的estimatedRowHeight属性
 *  4.如果UITableView的代理为KCTableViewDelegate则可以省略第2步
 *  注意：
 *  1.cell必须实现height方法才能正确计算高度，推荐使用方式：
 *    a.如果仅仅支持iOS8可以直接设置estimatedRowHeight配合AutoLayout即可实现自动高度，不用使用此类
 *    b.如果是仅仅支持iOS7或者iOS8并且使用AutoLayout不闪烁可以使用systemLayoutSizeFittingSize:方法在cell的height中返回正确的高度
 *    c.如果是想支持iOS6以下并且使用AutoLayout布局可以使用systemLayoutSizeFittingSize:方法在cell的height中返回正确的高度
 *    d.如果不使用AutoLayout则直接使用frame计算高度
 *  2.如果需要预加载缓存必须设置estimatedRowHeight属性，否则会先计算所有所有高度才会显示Cell，此时预加载没有意义
 *  3.此类依赖于KCTableViewArrayDataSource
 *  4.如果配合了KCTableViewDelegate使用只需要设置autoCellHeight=YES即可
 */
@interface UITableView (KC)
#pragma mark - 公共方法
/**
 *  是否启用自动高度计算，默认为NO不会自动计算
 */
@property(assign, nonatomic) BOOL autoCellHeight;
/**
 *  取得行高
 *  
 *  注意：自定义cell必须实现height方法
 *
 *  @param indexPath 当前分组和行
 *
 *  @return 行高
 */
- (CGFloat)heightWithIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 私有方法
//高度缓存集合，注意只有使用heightWithIndexPath:方法时才会创建存储
@property(strong, nonatomic) NSMutableArray *heightStore;

@end
