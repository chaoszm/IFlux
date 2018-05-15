//
//  TRIPModuleTestDataService.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleTestDataService.h"

@interface TRIPModuleTestDataService ()

@property (nonatomic,strong) TRIPModuleBaseTableModel *tableModel;

@end

@implementation TRIPModuleTestDataService

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static TRIPModuleTestDataService *dataInstance;
    dispatch_once(&onceToken, ^{
        dataInstance = [[TRIPModuleTestDataService alloc] init];
    });
    return dataInstance;
}

-(instancetype)init{
    if (self = [super init]) {
        _tableModel = [TRIPModuleBaseTableModel generateSingleSectionTableModel];
        
        __weak typeof(self) weakSelf = self;
        [self registerEventWithName:@"addImgCell" callback:^BOOL(IFluxEventContext *context) {
            TRIPModuleBaseCellModel *imageModel = [weakSelf generateImageModuleCellModel];
            [weakSelf addModel:imageModel];
            return YES;
        }];
        [self registerEventWithName:@"addTextCell" callback:^BOOL(IFluxEventContext *context) {
            TRIPModuleBaseCellModel *textModel = [weakSelf generateTextModuleCellModel];
            [weakSelf addModel:textModel];
            return YES;
        }];
        
        [self registerEventWithName:@"addNum" callback:^BOOL(IFluxEventContext *context) {
            [weakSelf allCellAddNum];
            return YES;
        }];
    }
    return self;
}

-(void)allCellAddNum{
    NSMutableArray *cells = [_tableModel getFirstSectionCells];
    for (int i = 0; i<cells.count; i++) {
        TRIPModuleBaseCellModel *cellModel = cells[i];
        if (cellModel.cellBizData && cellModel.cellBizData[@"title"]) {
            NSMutableDictionary *bizDic = cellModel.cellBizData;
            NSString *title = cellModel.cellBizData[@"title"];
            title = [NSString stringWithFormat:@"测试标题%d",i];
//            cellModel.cellBizData[@"title"] = title;
            bizDic[@"title"] = title;
            [cellModel outsideConfigBizData:bizDic];
        }
    }
//    [self outsideConfigBizData:_tableModel];
}

-(void)addModel:(TRIPModuleBaseCellModel *)model{
    NSArray *sections = self.tableModel.moduleSections;
    if (sections && sections.count>0) {
        TRIPModuleBaseSectionModel *sectionModel = sections[0];
        if (sectionModel.moduleCells) {
            [sectionModel.moduleCells addObject:model];
        }
    }
    [self outsideConfigBizData:_tableModel];
}

-(TRIPModuleBaseTableModel *)outsideGetTableModel{
    return (TRIPModuleBaseTableModel *)[self outsideGetBizData];
}

-(void)initFakeData{
    NSMutableArray *sections = _tableModel.moduleSections;
    TRIPModuleBaseSectionModel *sectionModel = sections[0];
    sectionModel.moduleCells = [[NSMutableArray alloc] init];
    [sectionModel.moduleCells addObject:[self generateImageModuleCellModel]];
    [sectionModel.moduleCells addObject:[self generateTextModuleCellModel]];
    
    [self outsideConfigBizData:_tableModel];
}

-(TRIPModuleBaseCellModel *)generateTextModuleCellModel{
    TRIPModuleBaseCellModel *testCellModel = [[TRIPModuleBaseCellModel alloc]
                                              initWithViewName:@"TRIPModuleTestTextTypeTableViewCell"
                                              bizData:[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"测试标题",@"content":@"测试内容"}]];
    return testCellModel;
}

-(TRIPModuleBaseCellModel *)generateImageModuleCellModel{
    TRIPModuleBaseCellModel *testCellModel = [[TRIPModuleBaseCellModel alloc]
                                              initWithViewName:@"TRIPModuleTestImgTypeTableViewCell"
                                              bizData:[NSMutableDictionary dictionaryWithDictionary:@{@"pic":@"",@"title":@"测试标题",@"content":@"测试内容"}]];
    return testCellModel;
}

-(TRIPModuleBaseModel *)generateHeaderActionModel{
    TRIPModuleBaseModel *headModel = [[TRIPModuleBaseModel alloc] init];
    NSArray *bizData = @[@{@"name":@"添加图片cell",@"action":@"addImgCell"},
                             @{@"name":@"添加text组件",@"action":@"addTextCell"},
                         @{@"name":@"添加序号",@"action":@"addNum"}];
    headModel.bizData = bizData;
    return headModel;
}

@end
