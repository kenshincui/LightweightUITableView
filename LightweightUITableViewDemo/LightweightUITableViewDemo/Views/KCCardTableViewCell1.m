//
//  KCStatusTableViewCell.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/17.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  使用frame手动控制cell高度的情况示例

#import "KCCardTableViewCell1.h"
#import "KCLightweightUITableView.h"

static const CGFloat kAvatarWidth = 100.0;
static const CGFloat kCommonSpace = 8.0;

@interface KCCardTableViewCell1 ()

@property(strong, nonatomic) UIImageView *avatarImageView;
@property(strong, nonatomic) UILabel *nameLabel;
@property(strong, nonatomic) UILabel *introductionLabel;

@end

@implementation KCCardTableViewCell1

#pragma mark - 生命周期及其基类方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self initializer];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

//注意：继承自KCTableViewCell可以不用自己返回height，非特殊情况下不用重新height的getter方法
//-(CGFloat)height{
//    return [super height];
//}

#pragma mark - 私有方法
- (void)initializer {
	//设置cell布局、背景等
	//	self.containerInset = UIEdgeInsetsMake(kCommonSpace, kCommonSpace, kCommonSpace, kCommonSpace); //控件内容外边距
	self.containerPaddingBottom = kCommonSpace; //控件内容下边距
						    //	self.borderColor = [UIColor darkGrayColor]; //分割线颜色
						    //	self.borderWidth = 1.0;		       //分割线宽度

	//添加子控件
	[self.containerView addSubview:self.avatarImageView];
	[self.containerView addSubview:self.nameLabel];
	[self.containerView addSubview:self.introductionLabel];
}

#pragma mark - 属性
- (void)setPerson:(KCPerson *)person {
	_person = person;

	//设置数据并更改布局
	self.avatarImageView.image = [UIImage imageNamed:person.avatarUrl]; //注意这里使用了本地图片用以模拟
	self.nameLabel.text = person.name;
	self.introductionLabel.text = person.introduction;
	self.introductionLabel.width = [UIScreen mainScreen].bounds.size.width - kAvatarWidth - 3 * kCommonSpace;
	[self.introductionLabel sizeToFit];
}

/**
 *  头像
 */
- (UIImageView *)avatarImageView {
	if (!_avatarImageView) {
		_avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kCommonSpace, kCommonSpace, kAvatarWidth, kAvatarWidth)];
	}
	return _avatarImageView;
}

/**
 *  姓名
 */
- (UILabel *)nameLabel {
	if (!_nameLabel) {
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImageView.frame) + kCommonSpace, kCommonSpace, 200.0, 18.0)];
		_nameLabel.font = [UIFont systemFontOfSize:17.0];
		_nameLabel.textColor = [UIColor colorWithRed:243.0 / 255.0 green:115.0 / 255.0 blue:45.0 / 255.0 alpha:1.0];
	}
	return _nameLabel;
}

/**
 *  简介，高度不固定
 */
- (UILabel *)introductionLabel {
	if (!_introductionLabel) {
		_introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + kCommonSpace, [UIScreen mainScreen].bounds.size.width - kAvatarWidth - 3 * kCommonSpace, 18.0)];
		_introductionLabel.font = [UIFont systemFontOfSize:16.0];
		_introductionLabel.numberOfLines = 0;
	}
	return _introductionLabel;
}
@end
