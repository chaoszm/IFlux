//
//  IFluxBaseDataStore.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/15.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark TBCartEventContext
// 事件上下文
@interface IFluxEventContext : NSObject
@property(nonatomic, weak) id pslf;           // 事件所属，weak，可能为nil
@property(nonatomic, strong) id data;           // 事件数据
@property(nonatomic, copy) void (^callback)(id);   // callback

//有参数上下文
+ (instancetype)contextWithPslf:(id)pslf data:(id)data callback:(void (^)(id param))callback;

//无参数上下文
+ (instancetype)contextWithPslf:(id)pslf;

@end




typedef BOOL (^IFluxEventBlock)(IFluxEventContext *context);

#pragma mark IFluxBaseDataStore

@interface IFluxBaseDataStore : NSObject

-(id)outsideGetBizData;

-(void)outsideConfigBizData:(id)bizData;

//添加业务数据的监听者
-(void)addBizDataListener:(id)listener;

//手动移除业务数据监听者
-(void)removeBizDataListener:(id)listener;

//处理action的方法，由子类实现，实现的时候最好调用一下super
-(void)handleEventWithName:(NSString *)name context:(IFluxEventContext *)context;

//注册事件,注册的时候会同时在DispatchManager中注册本dataStore
-(void)registerEventWithName:(NSString *)eventName callback:(IFluxEventBlock)callbackBlock;

//获取指定Name的block回调
- (IFluxEventBlock)eventBlockForName:(NSString *)name;

@end
