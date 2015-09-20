
//
//  KCAutHeightTableViewController.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/17.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  自动计算Cell行高(使用frame计算)

#import "KCAutoHeightTableViewController1.h"
#import "KCPersonService.h"
#import "KCCardTableViewCell1.h"
#import "KCLightweightUITableView.h"

@interface KCAutoHeightTableViewController1 ()

@end

@implementation KCAutoHeightTableViewController1
#pragma mark - 生命周期及其基类方法
- (void)viewDidLoad {
	[super viewDidLoad];

	[self initializer];
}

#pragma mark - 私有方法
- (void)initializer {
    self.title = @"自动计算行高";
    //如果使用KCTableViewDelegate只需要配置UITableView的autoCellHeight属性为YES即可（当然在定义Cell中需要实现height方法）
    self.tableView.estimatedRowHeight = 300.0;
    self.tableView.autoCellHeight = YES;
	self.dataSource.cellClass = [KCCardTableViewCell1 class];
    self.data = [[KCPersonService requestPersons] mutableCopy];
    [self.dataSource setCellBlock:^(KCCardTableViewCell1 *cell, id dataItem, NSIndexPath *indexPath) {
        cell.person = dataItem;
    }];
    [self.delegate setWillDisplayCellBlock:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.seperatorPinToSupperviewMargins = YES;//分割线两端对齐
    }];
}
@end
