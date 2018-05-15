//
//  TRIPModuleBaseTableViewController.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRIPModuleBaseTableModel;

typedef UITableViewCell *(^TRIPCartGenerateCellBlock)(UITableView *tableView,NSIndexPath *indexPath);
typedef CGFloat(^TRIPCartCalculateHeightBlock)(UITableView *tableView,NSIndexPath *indexPath);
typedef NSInteger(^TRIPCartCellNumBlock)(UITableView *tableView,NSInteger section);

@interface TRIPModuleBaseTableViewController : UIViewController

//UI
@property (nonatomic,strong) UITableView *tableView;

/**
 *  设置显示tableView的数据
 *
 *  @param tableModel
 */
-(void)configTableModel:(TRIPModuleBaseTableModel *)tableModel;

@end
