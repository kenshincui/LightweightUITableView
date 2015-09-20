//
//  KCTableViewController.h
//  KCFramework
//
//  Created by KenshinCui on 15/4/15.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCTableViewArrayDataSource.h"
#import "KCTableViewDelegate.h"

/**
 *  表格视图控制器
 */
@interface KCTableViewController : UIViewController
#pragma mark - 属性
/**
 *  主界面表格
 */
@property(strong, nonatomic) UITableView *tableView;
/**
 *  UITableView数据源对象
 */
@property(strong, nonatomic) KCTableViewArrayDataSource *dataSource;
/**
 *  UITableView数据源代理
 */
@property(strong, nonatomic) KCTableViewDelegate *delegate;
/**
 *  数据表数据
 *
 *  注意：对于动态数据，可以直接调用self.data来添加记录，如果是静态数据或者说是已经计算好的数据可以直接给self.data赋值
 */
@property(strong, nonatomic) NSMutableArray *data;

/**
 *  UITableView风格
 *
 *  注意：如果要设置表格样式必须在viewDidLoad之前（推荐放到init方法中），否则必须重新创建UITableView
 */
@property(assign, nonatomic) UITableViewStyle tableStyle;

@end
