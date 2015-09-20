# LightweightUITableView
![](https://github.com/kenshincui/LightweightUITableView/blob/master/LightweightUITableViewDemo/LightweightUITableViewDemo/Resources/cmjLogo120.png?raw=true)

LightweightUITalbeView项目是一个简化UITableView开发的轻量级类库，使用它你可以不用再编写繁杂的数据源和代理方法，可以不用再手动维护可变高度的Cell行高，所有的这一切均有类库自动实现，让开发者只需要关注具体的业务。
## 目录
LightweightUITalbeView      包含整个轻量级UITableview所需要的内容，可以直接copy到项目中使用；
LightweightUITalbeViewDemo  用于演示LightweightUITalbeView库的使用；
##说明
* KCTableViewArrayDataSource和KCTableViewDelegate用于给UIViewController中的UITableView的dataSource和delegate瘦身，也是LightweightUITalbeView的核心，二者将数据源和代理方法从控制器中解放出来，并提供了一些便捷方法用于快速配置数据；
* UITableView+KC 用于实现自动行高扩展处理，理论上来说和KCTableViewArrayDataSource、KCTableViewDelegate可以分开使用，但是为了设置更加方便建议配合使用；
* KCTableViewArrayDataSourceWithCommitEditingStyle用于处理可编辑Cell，KCTableViewArrayDataSource会根据属性设置动态调用，外界无需直接调用；
* UITableViewCell+KC是对于UITableViewCell的扩展，仅用于辅助操作；
* KCTableViewCell是对UITableViewCell的简单封装，方便配置Cell背景和设置间距，一般用于frame控制行高的情况，和当前库没有直接联系，仅用于辅助；
* KCTableViewController是对于KCTableViewArrayDataSource、KCTableViewDelegate、UITableView+KC使用的简单控制器封装，用于辅助开发者快速创建使用LightweightUITalbeView的表格控制器；
* UIView+KC是对UIView属性的简单扩展，和当前库没有直接联系，仅用于辅助；

总之，KCTableViewArrayDataSource、KCTableViewDelegate、UITableView+KC三个类是给UITableView瘦身的核心，理论上其他辅助类如果不需要均可以去掉（需要开发者简单修改使用的辅助方法，但是可行）。
##示例
1. 控制器瘦身
借助于KCTableViewArrayDataSource和KCTableViewDelegate对象代理控制器视图成为数据源和代理，避免冗余的数据源和代理方法，开发人员只需要关注属配置和必要的代理实现，并且二者均使用block实现，避免同一类方法分散到各处造成维护困扰。并且二者在命名方式上完全和原来的数据源方法、代理方法相对应，开发起来几乎零学习成本。另外为了便于开发，这里除了对应方法的block还提供了很多可以简化开发人员的方法，例如对于"- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath "这个数据源方法，则除了提供对应的“cellForRowAtIndexPathBlock”这个block之外，通常情况下如果只有一组数据、一种cell样式还可以直接使用"cellBlock"来简化数据配置，这个方法除了提供cell对象参数还提供了与之对应的数据项避免开发人员自己去数组中取出对应的模型（更多配置可以参考代码和具体的注释说明）。
如下示例中，由于在KCTableViewArrayDataSource中默认实现了返回分组数和行数的实现，如果仅仅包含一组数据可以不用实现分组数据源方法，而行数的实现KCTableViewArrayDataSource默认会返回配置的数组的个数，因此开发人员仅仅需要配置"cellForRowAtIndexPathBlock"来配置数据展示（事实上下面的代码中直接使用了默认的构造方法来完成了这个block的配置，代码更加简化）。同样的道理，KCTableViewDelegate则使用block来代理代理方法。
配置数据源
```objc
        //数据源方法通过block实现
		_dataSource = [[KCTableViewArrayDataSource alloc] initWithData:self.data
                         cellBlock:^(UITableViewCell *cell, NSString *dataItem, NSIndexPath *indexPath) {
                           cell.textLabel.text = dataItem;
                         }];
        //更多数据源配置
//        [_dataSource setNumberOfRowsInSectionBlock:^NSUInteger(NSArray * data, NSInteger section) {
//            
//        }];
```
配置代理
```objc
        //代理方法通过block实现
		[_delegate setSelectRowAtIndexPathBlock:^(id cell, NSIndexPath *indexPath) {
            NSString *controllerName = [NSString stringWithFormat:@"KCAutoHeightTableViewController%ld",indexPath.row + 1];
            UIViewController *autoHeightController = [NSClassFromString(controllerName) new];
            [weakSelf.navigationController pushViewController:autoHeightController animated:YES];
		}];
        //更多代理配置
//        [_delegate setHeightForRowAtIndexPathBlock:^CGFloat(NSIndexPath *indexPath) {
//            
//        }];
```
2. 自动计算Cell高度
 从iOS 8开发人员才能利用"self-sizing cell"自动计算行高，但是这种方式似乎并没有iOS 7那么流畅，因为它会多次计算Cell高度，效率似乎并没有那么高。另外，目前不支持iOS 7还是不太现实的，或者说你还想要兼容更低版本。LightweightUITableView提供了一种更加通用和高效的解决方案。使用UITableView+KC 会让Cell行高计算更加方便（无论你是使用frame还是AutoLayout布局），再配合上KCTableViewDelegate这种实现则更加简洁，使用是直接配置UITableView的autoCellHeight为YES即可（当然建议配置estimatedRowHeight）。UITableView+KC内部会自动在空闲时间预计算Cell高度，并且自动维护行高不会多次计算行高。
 在下面的实例中，仅仅通过几行代码即实现了Cell行高的计算。
```objc
    //如果使用KCTableViewDelegate只需要配置UITableView的autoCellHeight属性为YES即可（当然在定义Cell中需要实现height方法）
    self.tableView.estimatedRowHeight = 300.0;
    self.tableView.autoCellHeight = YES;
	self.dataSource.cellClass = [KCCardTableViewCell1 class];
    self.data = [[KCPersonService requestPersons] mutableCopy];
    [self.dataSource setCellBlock:^(KCCardTableViewCell1 *cell, id dataItem, NSIndexPath *indexPath) {
        cell.person = dataItem;
    }];
    [self.delegate setWillDisplayCellBlock:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.seperatorPinToSupperviewMargins = YES;//分割线两端对齐
    }];
```
## 效果
