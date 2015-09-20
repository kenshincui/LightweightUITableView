//
//  KCStatusTableViewCell.h
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/17.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  使用frame手动控制cell高度的情况示例

#import "KCTableViewCell.h"
#import "KCPerson.h"

@interface KCCardTableViewCell1 : KCTableViewCell

/**
 *  数据模型，用以填充控件数据
 */
@property (strong,nonatomic) KCPerson *person;

@end
