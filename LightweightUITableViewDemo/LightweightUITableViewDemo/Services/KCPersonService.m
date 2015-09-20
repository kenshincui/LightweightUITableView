//
//  KCPersonService.m
//  LightweightUITableViewDemo
//
//  Created by KenshinCui on 15/9/18.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCPersonService.h"
#import "KCPerson.h"

@implementation KCPersonService

+(NSArray *)requestPersons{
    //这里手动构造数据，实际开发中通常是从服务器端情况数据
    NSMutableArray *arrayM = [NSMutableArray array];
    NSString *filePath= [[NSBundle mainBundle] pathForResource:@"Persons.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    [array enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
        KCPerson *person = [[KCPerson alloc]initWithName:dic[@"name"] avatarUrl:dic[@"avatarUrl"] introduction:dic[@"introduction"]];
        [arrayM addObject:person];
    }];
    return [arrayM copy];
}

@end
