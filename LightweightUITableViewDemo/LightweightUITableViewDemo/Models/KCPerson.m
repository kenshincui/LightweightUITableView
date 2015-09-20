//
//  KCPerson.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/18.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCPerson.h"

@implementation KCPerson
#pragma mark - 生命周期及其基类方法
- (instancetype)initWithName:(NSString *)name avatarUrl:(NSString *)avatarUrl introduction:(NSString *)introduction {
	if (self = [super init]) {
		self.name = name;
		self.avatarUrl = avatarUrl;
		self.introduction = introduction;
	}
	return self;
}
@end
