//
//  IFluxBaseDataStore.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/15.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "IFluxBaseDataStore.h"
#import "IFluxDispatchManager.h"
#import "IFluxDataChangeModel.h"

#pragma mark IFluxEventContext
@implementation IFluxEventContext

+(instancetype)contextWithPslf:(id)pslf data:(id)data callback:(void (^)(id))callback{
    IFluxEventContext *context = [[IFluxEventContext alloc] init];
    context.pslf = pslf;
    context.data = data;
    context.callback = callback;
    return context;
}

//无参数上下文
+ (instancetype)contextWithPslf:(id)pslf{
    IFluxEventContext *context = [[IFluxEventContext alloc] init];
    context.pslf = pslf;
    context.data = nil;
    context.callback = nil;
    return context;
}

@end

#pragma mark IFluxBaseDataStore

@interface IFluxBaseDataStore ()
//事件的集合
@property (nonatomic,strong) NSMutableDictionary *eventMap;

//添加业务数据监听的弱对象
@property (nonatomic,strong) NSMapTable *listeners;

@property (nonatomic,readonly) id bizData;

@end

@implementation IFluxBaseDataStore

-(instancetype)init{
    if (self = [super init]) {
        _eventMap = [[NSMutableDictionary alloc] init];
        _listeners = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                           valueOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

-(void)dealloc{
    [_eventMap removeObserver:self forKeyPath:@"test"];
}

-(id)outsideGetBizData{
    return _bizData;
}

-(void)outsideConfigBizData:(id)bizData{
    NSEnumerator *enumerator = _listeners.objectEnumerator;
    id listener = enumerator.nextObject;
    while (listener) {
        if ([listener respondsToSelector:@selector(trigerDataChangeWithChangeModel:)]) {
            
            IFluxDataChangeModel *changeModel = [[IFluxDataChangeModel alloc] init];
            changeModel.recentData = bizData;
            changeModel.formerData = _bizData;
            [listener performSelectorOnMainThread:@selector(trigerDataChangeWithChangeModel:)
                                       withObject:changeModel
                                    waitUntilDone:NO];
        }
        listener = enumerator.nextObject;
    }
    
    _bizData = bizData;
}

-(void)addBizDataListener:(id)listener{
    if (!listener) {
        return;
    }
    NSString *listenerAddr = [NSString stringWithFormat:@"%p",listener];
    __weak id weakListener = listener;
    [_listeners setObject:weakListener forKey:listenerAddr];
}

-(void)removeBizDataListener:(id)listener{
    if (!listener) {
        return;
    }
    NSString *listenerAddr = [NSString stringWithFormat:@"%p",listener];
    if (!listenerAddr && listenerAddr.length>0 && [_listeners objectForKey:listenerAddr]) {
        [_listeners removeObjectForKey:listenerAddr];
    }
}

//处理action的方法，由子类实现，实现的时候最好调用一下super
-(void)handleEventWithName:(NSString *)name context:(IFluxEventContext *)context{
    if (name && _eventMap[name]) {
        IFluxEventBlock block = _eventMap[name];
        block(context);
        if (context.callback) {
            context.callback(context);
        }
    }
}

//注册事件,注册的时候会同时在DispatchManager中注册本dataStore
-(void)registerEventWithName:(NSString *)eventName callback:(IFluxEventBlock)callbackBlock{
    //同时在分发器中注册
    [[IFluxDispatchManager shareInstance] registerEventName:eventName withDataStore:self];
    
    if (eventName && callbackBlock) {
        _eventMap[eventName] = [callbackBlock copy];
    }
}

//获取指定Name的block回调
- (IFluxEventBlock)eventBlockForName:(NSString *)name{
    if (!name || name.length<=0) {
        return nil;
    }
    return _eventMap[name];
}

@end
