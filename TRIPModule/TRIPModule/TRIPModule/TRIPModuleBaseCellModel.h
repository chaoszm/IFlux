//
//  TRIPModuleBaseCellModel.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/22.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IFlux/IFlux.h>

@interface TRIPModuleBaseCellModel : IFluxBaseDataStore

//初始化最好用这个
-(instancetype)initWithViewName:(NSString *)viewName bizData:(id)bizData;

#pragma mark ----业务数据
@property (nonatomic,strong) id cellBizData;                //业务数据
@property (nonatomic,strong) NSString *viewName;            //cell视图的名字

#pragma mark ----tableViewCell相关配置
@property (nonatomic,assign) BOOL isFirstCell;              //外部设置是否第一个Cell的Model，默认为NO
@property (nonatomic,assign) BOOL isLaseCell;               //外部设置是否最后一个Cell的Model，默认为NO
@property (nonatomic,assign) BOOL canEdit;                  //cell是否可以编辑，默认为NO
@property (nonatomic,strong) NSString *reuseId;             //cell重用的Id，默认使用viewName，也可以自己手动设置

@end
