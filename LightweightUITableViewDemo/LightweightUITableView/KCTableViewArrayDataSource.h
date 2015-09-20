//
//  KCTableViewArrayDataSource.h
//  KCFramework
//
//  Created by Kenshin Cui on 15/2/2.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  UITableView数据源对象，简化UITableView的使用,注意此对象创建时必须强引用
 *
 *  注意：
 *  1.对于多个不同cell类型的表格请自行实现cellForRowAtIndexPathBlock并自己控制重用，不用指定identifier、cellBlock等
 *  2.data如果需要动态修改建议传递NSMutableArray直接引用（不要传递copy或者mutableCopy）在外部修改data(增删数据而不是直接赋值为另一个对象)引用而不用直接赋值
 *  3.对于分组表格，需要重写组数、行数回调方法
 *  4.如果Cell使用xib,则必须提前注册并且需要指定reuseIdentifier（但是cellClass可以不指定）,推荐直接使用“-(void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forTableView:(UITableView *)tableView或者“- (void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forTableView:(UITableView *)tableView”方法来注册
 */
@interface KCTableViewArrayDataSource : NSObject <UITableViewDataSource>

#pragma mark - 属性
/**
 *  UITableViewCell类型
 */
@property(assign, nonatomic) Class cellClass;

@property(assign, nonatomic) UITableViewCellStyle cellStyle;

/**
 *  UITableViewCell重用标识
 *
 *  注意在外部注册的自定义Cell必须指定此标识并同注册时指定的标示相同
 */
@property(copy, nonatomic) NSString *reuseIdentifier;

/**
 *  分组数，默认为1
 */
@property(assign, nonatomic) NSInteger sectionCount;

/**
 *  UITableView数据存储对象
 */
@property(strong, nonatomic) NSArray *data;

@property(copy, nonatomic) void (^cellBlock)(id cell, id dataItem, NSIndexPath *indexPath);


/**
 *  分组头部标题回调
 */
@property(copy, nonatomic) NSString * (^titleForHeaderInSectionBlock)(NSInteger section) ;

/**
 *  分组尾部标题回调
 */
@property(copy, nonatomic) NSString * (^titleForFooterInSectionBlock)(NSInteger section) ;

/**
 *  分组数计算回调
 */
@property(copy, nonatomic) NSUInteger (^numberOfSectionsInTableViewBlock)(NSArray *data) ;

/**
 *  行数计算回调
 */
@property(copy, nonatomic) NSUInteger (^numberOfRowsInSectionBlock)(NSArray *data, NSInteger section) ;
/**
 *  单元格创建回调
 */
@property(copy, nonatomic) UITableViewCell * (^cellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath) ;

/**
 *  编辑提交回调
 */
@property (copy,nonatomic) void (^commitEditingStyleBlock)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath) ;

#pragma mark - 方法
/**
 *  注册Xib类型
 *
 *  @param nibName         Xib名称
 *  @param reuseInditifier 重用标识
 *  @param tableView       表格
 */
- (void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forCellWithTableView:(UITableView *)tableView;
/**
 *  注册Cell类型
 *
 *  @param cls             类型
 *  @param reuseInditifier 重用标识
 *  @param tableView       表格
 */
-(void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forCellWithTableView:(UITableView *)tableView;

/**
 *  初始化一个表格数据源对象
 *
 *  注意：如果要自定义Cell请使用“-(instancetype)initWithData: cellClass: cellBlock:”方法
 *
 *  @param data      数据对象数组
 *  @param cellBlock 单元格操作回调函数
 *
 *  @return 表格数据源对象
 */
- (instancetype)initWithData:(NSArray *)data cellBlock:(void (^)(id cell, id dataItem, NSIndexPath *indexPath))cellBlock;

/**
 *  初始化一个表格数据源对象并指定自定义Cell类型
 *
 *  @param data      数据对象数组
 *  @param cellClass Cell类型
 *  @param cellBlock 单元格操作回调函数
 *
 *  @return 表格数据源对象
 */
- (instancetype)initWithData:(NSArray *)data cellClass:(Class)cellClass cellBlock:(void (^)(id cell, id dataItem, NSIndexPath *indexPath))cellBlock;

/**
 *  获取指定所以的数据对象
 *
 *  @param indexPath 所以路径
 *
 *  @return 数据对象
 */
- (id)itemAtIndex:(NSIndexPath *)indexPath;

/**
 *  初始化一个表格数据源对象
 *
 *  @param data      数据对象数组
 *  @param cellBlock 单元格操作回调函数
 *
 *  @return 表格数据源对象
 */
+ (instancetype)dataSourceWithData:(NSArray *)data cellBlock:(void (^)(id cell, id dataItem, NSIndexPath *indexPath))cellBlock;

/**
 *  初始化一个表格数据源对象
 *
 *  @param data      数据对象数组
 *  @param cellClass Cell类型
 *  @param cellBlock 单元格操作回调函数
 *
 *  @return 表格数据源对象
 */
+ (instancetype)dataSourceWithData:(NSArray *)data cellClass:(Class)cellClass cellBlock:(void (^)(id cell, id dataItem, NSIndexPath *indexPath))cellBlock;
@end
