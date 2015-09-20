//
//  ViewController.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/17.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  通过数据源和代理对象给控制器瘦身

#import "KCMainViewController.h"
#import "KCAutoHeightTableViewController1.h"
#import "KCAutoHeightTableViewController2.h"
#import "KCLightweightUITableView.h"

@interface KCMainViewController ()

@property(strong, nonatomic) UITableView *tableView;
/**
 *  数据源定义
 */
@property(strong, nonatomic) KCTableViewArrayDataSource *dataSource;
/**
 *  代理定义
 */
@property(strong, nonatomic) KCTableViewDelegate *delegate;
/**
 *  存储数据，数组中可以存放任何对象类型
 */
@property(strong, nonatomic) NSMutableArray *data;

@end

@implementation KCMainViewController
#pragma mark - 生命周期及其基类方法
- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"轻量级UITableView解决方案";
	[self.view addSubview:self.tableView];

	[self.tableView reloadData];
}

#pragma mark - 属性
- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		_tableView.dataSource = self.dataSource;
		_tableView.delegate = self.delegate;
	}
	return _tableView;
}

- (KCTableViewArrayDataSource *)dataSource {
	if (!_dataSource) {
		_dataSource = [[KCTableViewArrayDataSource alloc] initWithData:self.data
                         cellBlock:^(UITableViewCell *cell, NSString *dataItem, NSIndexPath *indexPath) {
                           cell.textLabel.text = dataItem;
                         }];
	}
	return _dataSource;
}

- (KCTableViewDelegate *)delegate {
	if (!_delegate) {
		_delegate = [[KCTableViewDelegate alloc] init];
		__weak typeof(self) weakSelf = self;
		[_delegate setSelectRowAtIndexPathBlock:^(id cell, NSIndexPath *indexPath) {
            NSString *controllerName = [NSString stringWithFormat:@"KCAutoHeightTableViewController%ld",indexPath.row + 1];
            UIViewController *autoHeightController = [NSClassFromString(controllerName) new];
            [weakSelf.navigationController pushViewController:autoHeightController animated:YES];
		}];
	}
	return _delegate;
}

- (NSMutableArray *)data {
	if (!_data) {
		_data = [NSMutableArray arrayWithObjects:@"自动计算行高1（frame布局）", @"自动计算行高2（AutoLayout布局）", nil];
	}
	return _data;
}

@end
