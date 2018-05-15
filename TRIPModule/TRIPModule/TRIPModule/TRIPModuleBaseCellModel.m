//
//  TRIPModuleBaseCellModel.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseCellModel.h"

static NSString *kTripModuleBaseCellId = @"k_trip_module_table_cell_id";

@implementation TRIPModuleBaseCellModel

-(instancetype)init{
    if (self = [super init]) {
        _isFirstCell = NO;
        _isLaseCell = NO;
        _canEdit = NO;
        _reuseId = kTripModuleBaseCellId;
    }
    return self;
}

-(instancetype)initWithViewName:(NSString *)viewName bizData:(id)bizData{
    if (self = [self init]) {
        _viewName = viewName;
        _cellBizData = bizData;
        
        _reuseId = viewName;
    }
    return self;
}

@end
