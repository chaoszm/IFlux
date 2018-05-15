//
//  TRIPModuleBaseTableViewController.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseTableViewController.h"
#import "TRIPModuleBaseTableModel.h"
#import "TRIPModuleBaseTableModel.h"
#import "TRIPModuleBaseSectionModel.h"
#import "TRIPModuleBaseCellModel.h"
#import "TRIPModuleBaseTableViewCell.h"
#import "TRIPModuleViewEngine.h"
#import "TRIPModuleBaseTableHeaderFooterView.h"

#define STRING_IS_EMPTY(str) ((str) == nil ||![(str) isKindOfClass:[NSString class]]|| [(str) length]<1)

static NSString *kTripModuleBaseCellId = @"k_trip_module_table_cell_id";

@interface TRIPModuleBaseTableViewController ()<UITableViewDelegate, UITableViewDataSource>

//配置Table的参数Model
@property (nonatomic,strong) TRIPModuleBaseTableModel *tableModel;

@end

@implementation TRIPModuleBaseTableViewController

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initBaseSubviews];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

#pragma mark - UI
-(void)initBaseSubviews{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}


#pragma mark TRIPCartBaseEventDelegate
-(NSDictionary *)handleEventWithEventName:(NSString *)eventName context:(NSDictionary *)context{
    //子类重写
    return nil;
}

#pragma mark logic
-(TRIPModuleBaseCellModel *)getCellModelWith:(NSIndexPath *)indexPath{
    TRIPModuleBaseSectionModel *sectionModel = [self getSectionModelWith:indexPath];
    if (sectionModel) {
        NSInteger row = indexPath.row;
        if (sectionModel.moduleCells && sectionModel.moduleCells.count>0
            && row>=0 && row <sectionModel.moduleCells.count) {
            return sectionModel.moduleCells[row];
        }
    }
    return nil;
}

-(TRIPModuleBaseSectionModel *)getSectionModelWith:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        return _tableModel.moduleSections[section];
    }
    return nil;
}

#pragma mark outsideCall
-(void)configTableModel:(TRIPModuleBaseTableModel *)tableModel{
    _tableModel = tableModel;
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRIPModuleBaseCellModel *cellModel = [self getCellModelWith:indexPath];
    if (cellModel) {
        return [TRIPModuleViewEngine heightForView:cellModel.viewName withBizModel:cellModel];
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        if (STRING_IS_EMPTY(sectionModel.sectionHeaderViewName)) {
            return 0.00001f;
        }
        return [TRIPModuleViewEngine heightForView:sectionModel.sectionHeaderViewName
                                      withBizModel:sectionModel];
    }
    return 0.00001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        if (STRING_IS_EMPTY(sectionModel.sectionFooterViewName)) {
            return 0.00001f;
        }
        return [TRIPModuleViewEngine heightForView:sectionModel.sectionFooterViewName
                                      withBizModel:sectionModel];
    }
    return 0.00001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        if (STRING_IS_EMPTY(sectionModel.sectionHeaderViewName) ||
            STRING_IS_EMPTY(sectionModel.sectionHeaderReuseId)) {
            return [[UIView alloc] init];
        }
        TRIPModuleBaseTableHeaderFooterView *headerView = [_tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.sectionHeaderReuseId];
        if (headerView) {
            return headerView;
        }else{
            return [TRIPModuleViewEngine tableHeaderFooterViewForName:sectionModel.sectionHeaderViewName
                                                              reuseId:sectionModel.sectionHeaderReuseId];
        }
    }
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_tableModel && _tableModel.moduleSections.count>0
        && section>=0 && section <_tableModel.moduleSections.count) {
        TRIPModuleBaseSectionModel *sectionModel = _tableModel.moduleSections[section];
        if (STRING_IS_EMPTY(sectionModel.sectionFooterViewName) ||
            STRING_IS_EMPTY(sectionModel.sectionFooterReuseId)) {
            return [[UIView alloc] init];
        }
        TRIPModuleBaseTableHeaderFooterView *headerView = [_tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionModel.sectionFooterReuseId];
        if (headerView) {
            return headerView;
        }else{
            return [TRIPModuleViewEngine tableHeaderFooterViewForName:sectionModel.sectionFooterViewName
                                                              reuseId:sectionModel.sectionFooterReuseId];
        }
    }
    return [[UIView alloc] init];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TRIPModuleBaseSectionModel *sectionModel = [self getSectionModelWith:[NSIndexPath indexPathForRow:0 inSection:section]];
    if (sectionModel && sectionModel.moduleCells) {
        return sectionModel.moduleCells.count;
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TRIPModuleBaseCellModel *cellModel = [self getCellModelWith:indexPath];
    if (cellModel) {
        return cellModel.canEdit;
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_tableModel && _tableModel.moduleSections) {
        return _tableModel.moduleSections.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRIPModuleBaseCellModel *cellModel = [self getCellModelWith:indexPath];
    if (!cellModel || STRING_IS_EMPTY(cellModel.viewName)) {
        return [[TRIPModuleBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTripModuleBaseCellId];
    }
    
    NSString *reuseId = cellModel.reuseId;
    TRIPModuleBaseTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [TRIPModuleViewEngine cellForViewName:cellModel.viewName reuseId:reuseId];
        if (!cellModel) {
            return [[TRIPModuleBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTripModuleBaseCellId];
        }
    }
    if ([cell isKindOfClass:[TRIPModuleBaseTableViewCell class]]) {
        CGFloat height = [TRIPModuleViewEngine heightForView:cellModel.viewName withBizModel:cellModel];
        cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        
        [cell.cellModel removeBizDataListener:cell];
        
        cell.cellModel = cellModel;
        [cell renderUI];
        
        [cell.cellModel addBizDataListener:cell];
    }
    
    return cell;
}


@end
