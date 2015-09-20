
//
//  UITableView+KC.m
//  CMJStudio
//
//  Created by KenshinCui on 15/4/29.
//  Copyright (c) 2015年 CMJStudio. All rights reserved.
//

#import "UITableView+KC.h"
#import "UIView+KC.h"
#import "UITableViewCell+KC.h"
#import "KCTableViewArrayDataSource.h"
@import ObjectiveC;

@implementation UITableView (KC)

#pragma mark - 生命周期及其基类方法
static long kKCAutoCellHeightKey;
+ (void)load {
	objc_setAssociatedObject(self, &kKCAutoCellHeightKey, @(NO), OBJC_ASSOCIATION_ASSIGN);

	SEL selectors[] = {
		@selector(reloadData),
		@selector(insertSections:withRowAnimation:),
		@selector(deleteSections:withRowAnimation:),
		@selector(reloadSections:withRowAnimation:),
		@selector(moveSection:toSection:),
		@selector(insertRowsAtIndexPaths:withRowAnimation:),
		@selector(deleteRowsAtIndexPaths:withRowAnimation:),
		@selector(reloadRowsAtIndexPaths:withRowAnimation:),
		@selector(moveRowAtIndexPath:toIndexPath:)
	};
	for (int i = 0; i < sizeof(selectors) / sizeof(SEL); ++i) {
		SEL originSelector = selectors[i];
		SEL swizzledSelector = NSSelectorFromString([NSString stringWithFormat:@"kc_%@", NSStringFromSelector(originSelector)]);

		Method originMethod = class_getInstanceMethod(self, originSelector);
		Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

		method_exchangeImplementations(originMethod, swizzledMethod);
	}
}

#pragma mark - 公共方法
- (CGFloat)heightWithIndexPath:(NSIndexPath *)indexPath {
	if (!indexPath) {
		return 0.0;
	}
	CGFloat height = [self getCachedHeightWithIndexPath:indexPath];
	if (height == 0) {
		//		UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];//注意：不能调用此方法，不然会出现死循环，因为此方法会调用高度计算
		if (![self.dataSource isKindOfClass:[KCTableViewArrayDataSource class]]) {
			NSLog(@"计算高度过程中发生错误，错误详情：使用高度自适应功能必须配合KCTableViewArrayDataSource使用.");
			return 0.0;
		}
		KCTableViewArrayDataSource *dataSource = (KCTableViewArrayDataSource *)self.dataSource;
		if (dataSource.cellBlock) {
			static NSString *identtityKey = @"myTableViewCellIdentityKey1";
			UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:dataSource.reuseIdentifier ? dataSource.reuseIdentifier : identtityKey];
			if (cell == nil) {
				if (dataSource.cellClass) {
					cell = [[dataSource.cellClass alloc] initWithStyle:dataSource.cellStyle reuseIdentifier:identtityKey];
				} else {
					cell = [[UITableViewCell alloc] initWithStyle:dataSource.cellStyle reuseIdentifier:identtityKey];
				}
			}
			[cell prepareForReuse];
			id item;
			if (dataSource.data && dataSource.data.count > 0) {
				if (dataSource.sectionCount == 1 && dataSource.data.count > indexPath.row) {
					item = [dataSource itemAtIndex:indexPath];
				} else if (dataSource.sectionCount > 1 && [dataSource.data[indexPath.section] isKindOfClass:[NSArray class]]) {
					item = dataSource.data[indexPath.section][indexPath.row];
				}
			}
			if (dataSource.cellBlock) {
				dataSource.cellBlock(cell, item, indexPath);
			}

			height = cell.height;

		} else if (dataSource.cellForRowAtIndexPathBlock) {
			UITableViewCell *cell = dataSource.cellForRowAtIndexPathBlock(self, indexPath);
			[cell prepareForReuse];
			height = cell.height;
		}

		[self cacheHeightStoreWithIndexPath:indexPath height:height];
		//		self.heightStore[indexPath.section][indexPath.row] = @(height);
	}
	return height;
}

#pragma mark - 属性
- (NSMutableArray *)heightStore {
	return objc_getAssociatedObject(self, _cmd);
}
- (void)setHeightStore:(NSMutableArray *)heightStore {
	objc_setAssociatedObject(self, @selector(heightStore), heightStore, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)autoCellHeight {
	return [objc_getAssociatedObject(self, &kKCAutoCellHeightKey) boolValue];
}
- (void)setAutoCellHeight:(BOOL)autoCellHeight {
	objc_setAssociatedObject(self, &kKCAutoCellHeightKey, @(autoCellHeight), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 私有方法
- (void)buildEmptyHeightStoreIfNeedWithIndexPaths:(NSArray *)indexPaths {
	if (!self.heightStore) {
		self.heightStore = [NSMutableArray array];
	}
	[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        for (int i=0; i<=indexPath.section; ++i) {
            if (i>=self.heightStore.count) {
                self.heightStore[i]=@[].mutableCopy;
            }
        }
        NSMutableArray *rows=self.heightStore[indexPath.section];
        for (int j=0; j<=indexPath.row; ++j) {
            if (j>=rows.count) {
                rows[j]=@(0);
            }
        }
	}];
}
- (CGFloat)getCachedHeightWithIndexPath:(NSIndexPath *)indexPath {
	[self buildEmptyHeightStoreIfNeedWithIndexPaths:@[ indexPath ]];
	return [self.heightStore[indexPath.section][indexPath.row] floatValue];
}
- (void)cacheHeightStoreWithIndexPath:(NSIndexPath *)indexPath height:(CGFloat)height {
	[self buildEmptyHeightStoreIfNeedWithIndexPaths:@[ indexPath ]];
	self.heightStore[indexPath.section][indexPath.row] = @(height);
}
//即将缓存但是还没有缓存的分组和行
- (NSArray *)indexPathsOfHaveNoCache {
	NSMutableArray *toBeCacheIndexPaths = [NSMutableArray array];
	NSInteger sectionCount = [self numberOfSections];
	for (NSInteger i = 0; i < sectionCount; ++i) {
		NSInteger rowCount = [self numberOfRowsInSection:i];
		for (NSInteger j = 0; j < rowCount; ++j) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:j inSection:i];
            [self buildEmptyHeightStoreIfNeedWithIndexPaths:@[indexPath]];
			CGFloat height = [self.heightStore[i][j] floatValue];
			if (height == 0) {
				[toBeCacheIndexPaths addObject:[NSIndexPath indexPathForRow:j inSection:i]];
			}
		}
	}
	return [toBeCacheIndexPaths copy];
}
- (void)preCacheHeightStore {
	if (!self.autoCellHeight) {
		return;
	}
	if (![self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
		return;
	}
	NSMutableArray *indexPathsOfHaveNoCache = [self indexPathsOfHaveNoCache].mutableCopy;
	CFRunLoopRef runloop = CFRunLoopGetCurrent();
	CFStringRef mode = kCFRunLoopDefaultMode;
	CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (indexPathsOfHaveNoCache.count==0) {
            CFRunLoopRemoveObserver(runloop, observer, mode);
            CFRelease(observer);
            return ;
        }
        NSIndexPath *indexPath=indexPathsOfHaveNoCache.firstObject;
        [indexPathsOfHaveNoCache removeObject:indexPath];
        
        [self performSelectorOnMainThread:@selector(preCacheHeightWithIndexPath:) withObject:indexPath waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
	});
	CFRunLoopAddObserver(runloop, observer, mode);
}
- (void)preCacheHeightWithIndexPath:(NSIndexPath *)indexPath {
	CGFloat height = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
	self.heightStore[indexPath.section][indexPath.row] = @(height);
}

#pragma mark - Swizzle方法
- (void)kc_reloadData {
	if (self.autoCellHeight) {
		[self.heightStore removeAllObjects];
	}

	[self kc_reloadData];
	[self preCacheHeightStore];
}
- (void)kc_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
	if (self.autoCellHeight) {
		[sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self.heightStore insertObject:@[].mutableCopy  atIndex:idx];
		}];
	}

	[self kc_insertSections:sections withRowAnimation:animation];
	[self preCacheHeightStore];
}
- (void)kc_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
	if (self.autoCellHeight) {
		[sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [self.heightStore removeObjectAtIndex:idx];
		}];
	}
	[self kc_deleteSections:sections withRowAnimation:animation];
}
- (void)kc_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
	if (self.autoCellHeight) {
		[sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            if (idx<self.heightStore.count) {
                NSMutableArray *rows=self.heightStore[idx];
                [rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx2, BOOL *stop) {
                    rows[idx2]=@(0);
                }];
            }

		}];
	}
	[self kc_reloadSections:sections withRowAnimation:animation];
	[self preCacheHeightStore];
}
- (void)kc_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
	if (self.autoCellHeight) {
		if (section < self.heightStore.count && newSection < self.heightStore.count) {
			[self.heightStore exchangeObjectAtIndex:section withObjectAtIndex:newSection];
		}
	}

	[self kc_moveSection:section toSection:newSection];
	[self preCacheHeightStore];
}
- (void)kc_insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
	if (self.autoCellHeight) {
		[self buildEmptyHeightStoreIfNeedWithIndexPaths:indexPaths];
		[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            NSMutableArray *rows=self.heightStore[indexPath.section];
            [rows insertObject:@(0) atIndex:indexPath.row];
		}];
	}

	[self kc_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
	[self preCacheHeightStore];
}
- (void)kc_deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
	if (self.autoCellHeight) {
		NSMutableDictionary *toRemoveDic = @{}.mutableCopy;
		[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            NSMutableIndexSet *toRemoveIndexs;
            if (![toRemoveDic.allKeys containsObject:@(indexPath.section)]) {
                toRemoveIndexs=[NSMutableIndexSet indexSet];
                [toRemoveDic setObject:toRemoveIndexs forKey:@(indexPath.section)];
            }else{
                toRemoveIndexs=toRemoveDic[@(indexPath.section)];
                [toRemoveIndexs addIndexes:[NSIndexSet indexSetWithIndex:indexPath.row]];
            }
		}];
		[toRemoveDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSIndexSet *indexSets, BOOL *stop) {
            NSMutableArray *rows=self.heightStore[key.integerValue];
            [rows removeObjectsAtIndexes:indexSets];
		}];
	}

	[self kc_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}
- (void)kc_reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
	if (self.autoCellHeight) {
		[self buildEmptyHeightStoreIfNeedWithIndexPaths:indexPaths];
		[indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
            self.heightStore[indexPath.section][indexPath.row]=@(0);
		}];
	}

	[self kc_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
	[self preCacheHeightStore];
}
- (void)kc_moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
	if (self.autoCellHeight) {
		[self buildEmptyHeightStoreIfNeedWithIndexPaths:@[ indexPath, newIndexPath ]];
		NSMutableArray *sourceRows = self.heightStore[indexPath.section];
		NSMutableArray *newRows = self.heightStore[newIndexPath.section];
		CGFloat sourceHeight = [sourceRows[indexPath.row] floatValue];
		CGFloat newHeight = [newRows[newIndexPath.row] floatValue];
		sourceRows[indexPath.row] = @(newHeight);
		newRows[newIndexPath.row] = @(sourceHeight);
	}

	[self kc_moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

@end
