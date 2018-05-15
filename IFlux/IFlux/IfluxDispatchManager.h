//
//  IFluxDispatchManager.h
//  testTerminalFeatures
//
//  Created by 邹明 on 16/9/13.
//  Copyright © 2016年 com.zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFluxBaseDataStore.h"

@interface IFluxDispatchManager : NSObject

+(instancetype)shareInstance;

//注册
-(void)registerEventName:(NSString *)eventName
         withDataStore:(IFluxBaseDataStore *)dataStore;

//注销DataStore,在dataStore被销毁的时候一定要记得注销，不然不能释放
-(void)logoutDataStore:(IFluxBaseDataStore *)dataStore;

//注销某个DataStore的之前注册的某个Action
-(void)logoutEvent:(NSString *)eventName
   withDataStore:(IFluxBaseDataStore *)dataStore;

//将事件分发到已注册的DataStore中
-(void)dispatchToRegisterDataStoreWithAction:(NSString *)eventName
                                       context:(IFluxEventContext *)context;

//将事件分发到指定的DataStore中
-(void)dispatchActionEvent:(NSString *)eventName
                   context:(IFluxEventContext *)context
             toDataStore:(IFluxBaseDataStore *)dataStore;

@end
