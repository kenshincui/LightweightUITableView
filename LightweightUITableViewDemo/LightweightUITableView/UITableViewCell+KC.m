//
//  UITableViewCell+KC.m
//  KCFramework
//
//  Created by Kenshin Cui on 15/1/16.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "UITableViewCell+KC.h"

@implementation UITableViewCell (KC)

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView {
	static NSString *identtityKey = @"KCFramework_TableViewCellIdentityKey1";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identtityKey];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
	}
	return cell;
}

#pragma mark - 加载xib
+ (UITableViewCell *)loadCellWithName:(NSString *)name tableView:(UITableView *)tableView reusableIdentifier:(NSString *)identifier {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil][0];
	}
	return cell;
}

+ (UIView *)selectedBackgroundViewWithColor:(UIColor *)color {
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = color;
	return view;
}

+ (void)setEdgeInsetsZeroForTableViewCell:(id)view {
	[self setEdgeInsets:UIEdgeInsetsZero forTableViewCell:view];
}

+ (void)setEdgeInsets:(UIEdgeInsets)insets forTableViewCell:(id)view {
	if ([view isKindOfClass:[UITableView class]]) {

		UITableView *tableView = (UITableView *)view;

		if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
			tableView.separatorInset = insets;
		}
		if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
			tableView.layoutMargins = insets;
		}
	}
	if ([view isKindOfClass:[UITableViewCell class]]) {

		UITableView *tableViewCell = (UITableView *)view;

		if ([tableViewCell respondsToSelector:@selector(setSeparatorInset:)]) {
			tableViewCell.separatorInset = insets;
		}
		if ([tableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
			tableViewCell.layoutMargins = insets;
		}
	}
}

#pragma mark - 属性
- (UITableView *)tableView {
	UIView *aView = self.superview;
	while (aView != nil) {
		if ([aView isKindOfClass:[UITableView class]]) {
			return (UITableView *)aView;
		}
		aView = aView.superview;
	}
	return nil;
}
- (void)setTableView:(UITableView *)tableView {
}

- (BOOL)seperatorPinToSupperviewMargins {
	return NO;
}
- (void)setSeperatorPinToSupperviewMargins:(BOOL)seperatorPinToSupperviewMargins {
	if (seperatorPinToSupperviewMargins) {
        UITableView *tableView=self.tableView;
		if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
			[tableView setSeparatorInset:UIEdgeInsetsZero];
		}

		if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
			[tableView setLayoutMargins:UIEdgeInsetsZero];
		}

		if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
			[self setLayoutMargins:UIEdgeInsetsZero];
		}
	}
}
@end
