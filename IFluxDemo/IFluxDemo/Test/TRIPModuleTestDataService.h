//
//  TRIPModuleTestDataService.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TRIPModuleTestDataService : IFluxBaseDataStore

+(instancetype)shareInstance;

-(void)initFakeData;

-(TRIPModuleBaseTableModel *)outsideGetTableModel;

-(TRIPModuleBaseModel *)generateHeaderActionModel;

@end
