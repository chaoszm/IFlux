//
//  IFluxDispatchManager.m
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/13.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import "IFluxDispatchManager.h"
#import "IFluxBaseDataStore.h"

@interface IFluxDispatchManager ()

//key是action，value是dataStore的地址对象的nsMapTable表,结构为@{@"click":@{@"0x123456":id,@"111111":id}}
@property (nonatomic,strong) NSMutableDictionary *actionMap;

@end

@implementation IFluxDispatchManager

//事件从View传出Action,到dispatcher，然后由dispatcher分发事件到对应的dataStore,对应的dataStore处理Action的数据加工,处理完成数据处理后，可以由View监听对应的数据，View进行相应的改变，也可以由对应的PageController对象处理。
+(instancetype)shareInstance{
    static IFluxDispatchManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IFluxDispatchManager alloc] init];
    });
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        _actionMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark -Logic
//注册
-(void)registerEventName:(NSString *)eventName
         withDataStore:(IFluxBaseDataStore *)dataStore{
    [self addToActionMapWithName:eventName
                     DataStore:dataStore];
}

-(void)addToActionMapWithName:(NSString *)eventName
                  DataStore:(IFluxBaseDataStore *)dataStore{
    if (!eventName || eventName.length<=0 || !dataStore) {
        return;
    }
    NSMapTable *serviceList = _actionMap[eventName];
    NSString *dsAdr = [NSString stringWithFormat:@"%p",dataStore];
    __weak IFluxBaseDataStore *weakDS = dataStore;
    if (serviceList && [serviceList isKindOfClass:[NSMapTable class]]) {
        //本身存在，添加进去即可
        @synchronized (serviceList) {
            //防止dataStore重复添加导致重复调用的问题
            [serviceList setObject:weakDS forKey:dsAdr];
        }
    }else{
        //本身不存在,需要新建
        NSMapTable *dataStoreList = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory
                                                            valueOptions:NSPointerFunctionsWeakMemory];
        [dataStoreList setObject:weakDS forKey:dsAdr];
        _actionMap[eventName] = dataStoreList;
    }
}

-(void)logoutDataStore:(IFluxBaseDataStore *)dataStore{
    if (!dataStore) {
        return;
    }
    for (NSMapTable *serviceList in [_actionMap allValues]) {
        if (serviceList && serviceList.count>0) {
            NSString *dsAdr = [NSString stringWithFormat:@"%p",dataStore];
            [serviceList removeObjectForKey:dsAdr];
        }
    }
}

//注销某个dataStore的之前注册的某个Action
-(void)logoutEvent:(NSString *)eventName
   withDataStore:(IFluxBaseDataStore *)dataStore{
    if (!eventName || eventName.length<=0 || dataStore) {
        return;
    }
    NSMapTable *serviceList = _actionMap[eventName];
    if (serviceList && [serviceList isKindOfClass:[NSMapTable class]]) {
        NSString *dsAdr = [NSString stringWithFormat:@"%p",dataStore];
        [serviceList removeObjectForKey:dsAdr];
    }
}

//将事件分发到已注册的dataStore中
-(void)dispatchToRegisterDataStoreWithAction:(NSString *)eventName
                                       context:(IFluxEventContext *)context{
    if (eventName && eventName.length >0 && _actionMap[eventName]) {
        NSMapTable *serviceList = _actionMap[eventName];
        NSEnumerator *enumerator = serviceList.objectEnumerator;
        IFluxBaseDataStore *dataStoreObj = [enumerator nextObject];
        while (dataStoreObj) {
//            //同步
//            [dataStoreObj handleEventWithName:eventName context:context];
//            dataStoreObj = [enumerator nextObject];
            //异步
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [dataStoreObj handleEventWithName:eventName context:context];
            });
            dataStoreObj = [enumerator nextObject];
        }
    }
}

//将事件分发到指定的dataStore中
-(void)dispatchActionEvent:(NSString *)eventName
                   context:(IFluxEventContext *)context
             toDataStore:(IFluxBaseDataStore *)dataStore{
    if (eventName && eventName.length >0 && dataStore) {
        [dataStore handleEventWithName:eventName context:context];
    }
}

@end
