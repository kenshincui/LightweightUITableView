//
//  KCTableViewArrayDataSourceWithCommitEditingStyle.m
//  CMJStudio
//
//  Created by KenshinCui on 15/5/25.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "KCTableViewArrayDataSourceWithCommitEditingStyle.h"

@implementation KCTableViewArrayDataSourceWithCommitEditingStyle

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.commitEditingStyleBlock) {
		self.commitEditingStyleBlock(tableView, editingStyle, indexPath);
	}
}

@end
