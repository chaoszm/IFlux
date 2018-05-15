//
//  IFluxListenerProtocol.h
//
//  Created by 邹明 on 16/9/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFluxDataChangeModel.h"

@protocol IFluxListenerProtocol <NSObject>

//监听的数据源发生了变化触发，在子线程触发
-(void)trigerDataChangeWithNew:(id)newData old:(id)oldData;

//将新老数据源包装在一起，此时在主线程触发
-(void)trigerDataChangeWithChangeModel:(IFluxDataChangeModel *)changeModel;

@end
