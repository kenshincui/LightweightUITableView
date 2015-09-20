//
//  KCCardTableViewCell2.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/18.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  使用AutoLayout控制cell高度的情况示例(并且使用了Xib)

#import "KCCardTableViewCell2.h"
#import "KCLightweightUITableView.h"

static const CGFloat kAvatarWidth = 100.0;
static const CGFloat kCommonSpace = 8.0;

@interface KCCardTableViewCell2 ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@end

@implementation KCCardTableViewCell2

#pragma mark - 生命周期及其基类方法
- (void)awakeFromNib {
    //注意使用AutoLayout在这里需要制定宽度才能换行
    [self.introductionLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - kAvatarWidth - 3 * kCommonSpace];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

//注意这里仍然需要返回height，不过可以利用AutoLayout来计算高度
-(CGFloat)height{
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

#pragma mark - 属性
- (void)setPerson:(KCPerson *)person {
    _person = person;
    
    //设置数据并更改布局
    self.avatarImageView.image = [UIImage imageNamed:person.avatarUrl]; //注意这里使用了本地图片用以模拟
    self.nameLabel.text = person.name;
    self.introductionLabel.text = person.introduction;
}
@end
