//
//  IFluxBaseView.h
//
//  Created by 邹明 on 16/9/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFluxBaseModel.h"
#import "IFluxListenerProtocol.h"

@interface IFluxBaseView : UIView<IFluxListenerProtocol>

//需要绑定的数据
@property (nonatomic,strong) IFluxBaseModel *model;

//根据bizModel渲染，由子类实现
-(void)renderUI;

-(void)renderUIWithModel:(IFluxBaseModel *)model;

/**
 *  根据数据获取View的高度，由子类实现
 *
 *  @param bizModel 业务Model
 *
 *  @return View的高度
 */
+(CGFloat)heightForModel:(IFluxBaseModel *)model;


//添加了监听的话需要实现以下两个方法中的一个。
//监听的数据源发生了变化触发，在子线程触发
-(void)trigerDataChangeWithNew:(id)newData old:(id)oldData;

//将新老数据源包装在一起，此时在主线程触发
-(void)trigerDataChangeWithChangeModel:(IFluxDataChangeModel *)changeModel;

@end
