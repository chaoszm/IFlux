//
//  TRIPModuleBaseTableModel.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseTableModel.h"
#import "TRIPModuleBaseSectionModel.h"

@implementation TRIPModuleBaseTableModel

-(id)getFirstSectionCells{
    NSArray *sections = self.moduleSections;
    if (sections && sections.count>0) {
        TRIPModuleBaseSectionModel *sectionModel = sections[0];
        if (sectionModel && sectionModel.moduleCells) {
            return sectionModel.moduleCells;
        }
    }
    return nil;
}

+(TRIPModuleBaseTableModel *)generateSingleSectionTableModel{
    TRIPModuleBaseTableModel *tableModel = [[TRIPModuleBaseTableModel alloc] init];
    tableModel.moduleSections = [[NSMutableArray alloc] init];
    TRIPModuleBaseSectionModel *sectionModel = [[TRIPModuleBaseSectionModel alloc] init];
    sectionModel.isFirstSection = YES;
    sectionModel.isLaseSection = YES;    
    [tableModel.moduleSections addObject:sectionModel];
    sectionModel.moduleCells = [[NSMutableArray alloc] init];
    
    return tableModel;
}

@end
