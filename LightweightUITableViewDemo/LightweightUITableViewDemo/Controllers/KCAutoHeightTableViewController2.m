
//
//  KCAutoHeightTableViewController2.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/18.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCAutoHeightTableViewController2.h"
#import "KCPersonService.h"
#import "KCCardTableViewCell2.h"
#import "KCLightweightUITableView.h"

static NSString *const cellIdentifier = @"KCCardTableViewCell2";
@implementation KCAutoHeightTableViewController2
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
    //注册Nib
    [self.dataSource registerNibName:cellIdentifier reuseIdentifier:cellIdentifier forCellWithTableView:self.tableView];
    self.data = [[KCPersonService requestPersons] mutableCopy];
    [self.dataSource setCellBlock:^(KCCardTableViewCell2 *cell, id dataItem, NSIndexPath *indexPath) {
        cell.person = dataItem;
    }];
    [self.delegate setWillDisplayCellBlock:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.seperatorPinToSupperviewMargins = YES;//分割线两端对齐
    }];
}
@end
