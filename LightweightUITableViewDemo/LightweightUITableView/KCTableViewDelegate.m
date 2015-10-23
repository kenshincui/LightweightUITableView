//
//  KCTableViewDelegate.m
//  CMJStudio
//
//  Created by KenshinCui on 15/3/17.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCTableViewDelegate.h"
#import "UITableView+KC.h"

#define KCOSVersionLessThan(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)

@interface KCTableViewDelegate ()

/**
 *  Cell是否正在被点击,避免连续点击
 */
@property(assign, nonatomic) BOOL isCellSelecting;

@end

@implementation KCTableViewDelegate

- (void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forHeaderWithTableView:(UITableView *)tableView {
	self.headerIdentifier = reuseInditifier;
	[tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:reuseInditifier];
}
- (void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forHeaderWithTableView:(UITableView *)tableView {
	self.headerIdentifier = reuseInditifier;
	[tableView registerClass:cls forHeaderFooterViewReuseIdentifier:reuseInditifier];
}
- (void)registerNibName:(NSString *)nibName reuseIdentifier:(NSString *)reuseInditifier forFooterWithTableView:(UITableView *)tableView {
	self.footerIdentifier = reuseInditifier;
	[tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forHeaderFooterViewReuseIdentifier:reuseInditifier];
}
- (void)registerClass:(Class)cls reuseIdentifier:(NSString *)reuseInditifier forFooterWithTableView:(UITableView *)tableView {
	self.footerIdentifier = reuseInditifier;
	[tableView registerClass:cls forHeaderFooterViewReuseIdentifier:reuseInditifier];
}

#pragma mark UITableView代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (self.selectRowAtIndexPathBlock) {
		if (self.isCellSelecting) {
			return;
		}
		self.isCellSelecting = YES;
		self.selectRowAtIndexPathBlock(cell, indexPath);
		self.isCellSelecting = NO;
	}
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (self.deselectRowAtIndexPathBlock) {
		self.deselectRowAtIndexPathBlock(cell, indexPath);
	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.willDisplayCellBlock) {
		self.willDisplayCellBlock(cell, indexPath);
	}
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.endDisplayingCellBlock) {
		self.endDisplayingCellBlock(cell, indexPath);
	}
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
	if (self.endDisplayingHeaderBlock) {
		self.endDisplayingHeaderBlock(view, section);
	}
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
	if (self.endDisplayingFooterBlock) {
		self.endDisplayingFooterBlock(view, section);
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView.autoCellHeight) {
		return [tableView heightWithIndexPath:indexPath];
	}
	if (self.heightForRowAtIndexPathBlock) {
		return self.heightForRowAtIndexPathBlock(indexPath);
	}

	return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (self.heightForHeaderInSectionBlock) {
		return self.heightForHeaderInSectionBlock(section);
	}
	if (KCOSVersionLessThan(@"8") && (tableView.sectionHeaderHeight == 17.5 || tableView.sectionHeaderHeight == 23.0)) { //避免iOS7不指定头部高度出现空白头部
		return CGFLOAT_MIN;
	}
	return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if (self.heightForFooterInSectionBlock) {
		return self.heightForFooterInSectionBlock(section);
	}
	if (KCOSVersionLessThan(@"8") && (tableView.sectionFooterHeight == 17.5 || tableView.sectionFooterHeight == 23.0)) { //避免iOS7不指定尾部高度出现空白尾部
		return CGFLOAT_MIN;
	}
	return tableView.sectionFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (self.viewForHeaderInSectionBlock) {
		return self.viewForHeaderInSectionBlock(tableView, section);
	}
	static NSString *identtityKey = @"myTableViewHeaderIdentityKey1";
	UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerIdentifier ? self.headerIdentifier : identtityKey];
	if (!header) {
		if (self.headerClass) {
			header = [[self.headerClass alloc] initWithReuseIdentifier:identtityKey];

		} else {
			header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identtityKey];
		}
	}
	if (self.headerViewBlock) {
		self.headerViewBlock(header, section);
	}
	return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if (self.viewForFooterInSectionBlock) {
		return self.viewForFooterInSectionBlock(tableView, section);
	}
	static NSString *identtityKey = @"myTableViewFooterIdentityKey1";
	UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerIdentifier ? self.footerIdentifier : identtityKey];
	if (!footer) {
		if (self.headerClass) {
			footer = [[self.headerClass alloc] initWithReuseIdentifier:identtityKey];

		} else {
			footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identtityKey];
		}
	}
	if (self.footerViewBlock) {
		self.footerViewBlock(footer, section);
	}
	return footer;
}

#pragma mark - UIScrollView相关代理实现
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (self.scrollViewDidScrollBlock) {
		self.scrollViewDidScrollBlock(scrollView);
	}
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	if (self.scrollViewWillBeginDeceleratingBlock) {
		self.scrollViewWillBeginDeceleratingBlock(scrollView);
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (self.scrollViewDidEndDeceleratingBlock) {
		self.scrollViewDidEndDeceleratingBlock(scrollView);
	}
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	if (self.scrollViewWillEndDraggingBlock) {
		self.scrollViewWillEndDraggingBlock(scrollView, velocity, targetContentOffset);
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (self.scrollViewDidEndDraggingBlock) {
		self.scrollViewDidEndDraggingBlock(scrollView, decelerate);
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	!self.scrollViewDidEndScrollingAnimationBlock ?: self.scrollViewDidEndScrollingAnimationBlock(scrollView);
}

#pragma mark - 私有方法
- (void)setIsCellSelecting:(BOOL)isCellSelecting {
	@synchronized(self) {
		if (!isCellSelecting) {
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			  _isCellSelecting = NO;
			});
		} else {
			_isCellSelecting = YES;
		}
	}
}
@end
