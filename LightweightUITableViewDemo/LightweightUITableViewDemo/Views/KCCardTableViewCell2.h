//
//  KCCardTableViewCell2.h
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/18.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//  使用AutoLayout控制cell高度的情况示例(并且使用了Xib)

#import <UIKit/UIKit.h>
#import "KCPerson.h"

@interface KCCardTableViewCell2 : UITableViewCell

/**
 *  数据模型，用以填充控件数据
 */
@property (strong,nonatomic) KCPerson *person;

@end
