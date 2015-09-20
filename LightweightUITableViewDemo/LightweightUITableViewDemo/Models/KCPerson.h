//
//  KCPerson.h
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/18.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCPerson : NSObject
#pragma mark - 生命周期及其基类方法
- (instancetype)initWithName:(NSString *)name avatarUrl:(NSString *)avatarUrl introduction:(NSString *)introduction;

#pragma mark - 属性
@property(copy, nonatomic) NSString *name;

@property(copy, nonatomic) NSString *avatarUrl;

@property(copy, nonatomic) NSString *introduction;

@end
