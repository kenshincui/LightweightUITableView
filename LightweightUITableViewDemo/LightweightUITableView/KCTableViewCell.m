//
//  KCTableViewCell.m
//  CMJStudio
//
//  Created by KenshinCui on 15/4/1.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCTableViewCell.h"
#import "UIView+KC.h"

@interface KCTableViewCell ()

//容器背景（注意不是Cell背景视图）
@property(strong, nonatomic) UIView *containerBackgroundView;

@end

@implementation KCTableViewCell

#pragma mark - 覆盖方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self buildContainer];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	//重新设置背景视图和容器视图的大小
	UIView *lastView = [self.containerView.subviews lastObject];
	CGFloat lastViewY = CGRectGetMaxY(lastView.frame);
    CGFloat height=self.borderWidth * 2 + self.containerPaddingBottom + lastViewY;
	self.containerBackgroundView.height = height;
	self.containerView.height = self.containerPaddingBottom + lastViewY;
}

- (void)awakeFromNib {
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

#pragma mark - 公共方法

#pragma mark - 属性
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth=borderWidth;
    [self layoutContainer];
}

-(void)setContainerPaddingBottom:(CGFloat)containerPaddingBottom{
    _containerPaddingBottom=containerPaddingBottom;
    [self layoutContainer];
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor=borderColor;
    self.containerBackgroundView.backgroundColor=_borderColor;
}

- (CGFloat)height {
//	return CGRectGetMaxY(self.containerBackgroundView.frame);
    //重新设置背景视图和容器视图的大小
    UIView *lastView = [self.containerView.subviews lastObject];
    CGFloat lastViewY = CGRectGetMaxY(lastView.frame);
    CGFloat height=self.borderWidth * 2 + self.containerPaddingBottom+self.containerInset.top+self.containerInset.bottom + lastViewY;
    return height;
}

#pragma mark - 私有方法
- (void)buildContainer {
	//容器背景视图
	self.containerBackgroundView = [[UIView alloc] init];
	[self.contentView addSubview:self.containerBackgroundView];

	//容器视图
	self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor=[UIColor whiteColor];//默认容器为白色
	[self.containerBackgroundView addSubview:self.containerView];
    
    //设置默认的边框颜色
    self.borderColor=[UIColor grayColor];
}

-(void)layoutContainer{
    //重置布局
    self.containerBackgroundView.x = self.containerInset.left;
    self.containerBackgroundView.y = self.containerInset.top;
    self.containerBackgroundView.width = [UIScreen mainScreen].bounds.size.width - self.containerInset.left - self.containerInset.right;
    
    self.containerView.x = self.borderWidth;
    self.containerView.y = self.borderWidth;
    self.containerView.width = self.containerBackgroundView.width - 2 * self.borderWidth;

}

@end
