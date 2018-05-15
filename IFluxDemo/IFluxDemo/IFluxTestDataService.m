//
//  IFluxTestDataService.m
//  IFluxDemo
//
//  Created by 邹明 on 16/10/8.
//  Copyright © 2016年 com.taobao. All rights reserved.
//

#import "IFluxTestDataService.h"

@implementation IFluxTestDataService

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static IFluxTestDataService *dataInstance;
    dispatch_once(&onceToken, ^{
        dataInstance = [[IFluxTestDataService alloc] init];
    });
    return dataInstance;
}

@end
