//
//  KCTableViewController.m
//  KCFramework
//
//  Created by KenshinCui on 15/4/15.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCTableViewController.h"
#import <UIKit/UIKit.h>

@interface KCTableViewController ()

@end

@implementation KCTableViewController

#pragma mark - 生命周期及其基类方法
- (instancetype)init {
	if (self = [super init]) {
		self.tableStyle = UITableViewStylePlain;
	}
	return self;
}

#pragma mark - 覆盖方法
- (void)viewDidLoad {
	[super viewDidLoad];
	[self addTableViewToController];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	//设置数据源和代理
	self.tableView.dataSource = self.dataSource;
	self.tableView.delegate = self.delegate;
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
}

#pragma mark - 属性
- (void)setData:(NSMutableArray *)data {
	_data = data;
	self.dataSource.data = _data;
}

#pragma mark - 私有方法
- (void)addTableViewToController {
	self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.tableStyle];
	[self.view addSubview:self.tableView];

	self.dataSource = [[KCTableViewArrayDataSource alloc] init];
	self.data = [NSMutableArray array];
	self.delegate = [[KCTableViewDelegate alloc] init];
}

- (void)dealloc {
	self.tableView.delegate = nil; //避免滚动过程中返回造成crash问题
}

@end
