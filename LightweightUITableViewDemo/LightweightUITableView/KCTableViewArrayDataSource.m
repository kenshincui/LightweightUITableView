//
//  KCTableViewArrayDataSource.m
//  KCFramework
//
//  Created by Kenshin Cui on 15/2/2.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCTableViewArrayDataSource.h"
#import "KCTableViewArrayDataSourceWithCommitEditingStyle.h"
@import ObjectiveC;

@interface KCTableViewArrayDataSource ()

@end

@implementation KCTableViewArrayDataSource

- (instancetype)init {
	if (self = [super init]) {
		self.sectionCount = 1;
		self.cellStyle = UITableViewCellStyleDefault;
	}
	return self;
}

#pragma mark - 公开方法
- (void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forCellWithTableView:(UITableView *)tableView {
    self.nibName = nibName;
	self.reuseIdentifier = reuseInditifier;
	[tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:reuseInditifier];
}
-(void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forCellWithTableView:(UITableView *)tableView{
    self.reuseIdentifier = reuseInditifier;
    self.cellClass = cls;
    [tableView registerClass:cls forCellReuseIdentifier:reuseInditifier];
}

- (instancetype)initWithData:(NSArray *)data cellBlock:(void (^)(id, id, NSIndexPath *))cellBlock {
	if (self = [self init]) {
		self.data = data;
		self.cellBlock = cellBlock;
	}
	return self;
}

- (instancetype)initWithData:(NSArray *)data cellClass:(Class)cellClass cellBlock:(void (^)(id, id, NSIndexPath *))cellBlock {
	if (self = [self initWithData:data cellBlock:cellBlock]) {
		self.cellClass = cellClass;
	}
	return self;
}

- (id)itemAtIndex:(NSIndexPath *)indexPath {
	return self.data[indexPath.row];
}

+ (instancetype)dataSourceWithData:(NSArray *)data cellBlock:(void (^)(id, id, NSIndexPath *))cellBlock {
	id obj = [[self alloc] initWithData:data cellBlock:cellBlock];
	return obj;
}

+ (instancetype)dataSourceWithData:(NSArray *)data cellClass:(Class)cellClass cellBlock:(void (^)(id, id, NSIndexPath *))cellBlock {
	return [[self alloc] initWithData:data cellClass:cellClass cellBlock:cellBlock];
}

#pragma mark - UITableView数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (self.numberOfSectionsInTableViewBlock) {
		self.sectionCount = self.numberOfSectionsInTableViewBlock(self.data);
	}
	return self.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.numberOfRowsInSectionBlock) {
		return self.numberOfRowsInSectionBlock(self.data, section);
	}
	return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.cellForRowAtIndexPathBlock) {
		return self.cellForRowAtIndexPathBlock(tableView, indexPath);
	}

	static NSString *identtityKey = @"myTableViewCellIdentityKey1";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier ? self.reuseIdentifier : identtityKey];
	if (cell == nil) {
		if (self.cellClass) {
			cell = [[self.cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:identtityKey];
		} else {
			cell = [[UITableViewCell alloc] initWithStyle:self.cellStyle reuseIdentifier:identtityKey];
		}
	}
	id dataItem;
	if (self.data && self.data.count > 0) {
		if (self.sectionCount == 1&&self.data.count>indexPath.row) {
			dataItem = [self itemAtIndex:indexPath];
		} else if(self.sectionCount>1&&[self.data[indexPath.section] isKindOfClass:[NSArray class]]){
			dataItem = self.data[indexPath.section][indexPath.row];
		}
	}
	if (self.cellBlock) {
		self.cellBlock(cell, dataItem, indexPath);
	}
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (self.titleForHeaderInSectionBlock) {
		return self.titleForHeaderInSectionBlock(section);
	}
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (self.titleForFooterInSectionBlock) {
		return self.titleForFooterInSectionBlock(section);
	}
	return nil;
}

#pragma mark - 属性
-(void)setCommitEditingStyleBlock:(void (^)(UITableView *, UITableViewCellEditingStyle, NSIndexPath *))commitEditingStyleBlock{
    _commitEditingStyleBlock = commitEditingStyleBlock;
    if(commitEditingStyleBlock){
        object_setClass(self, [KCTableViewArrayDataSourceWithCommitEditingStyle class]);
    }
}
@end
