//
//  TRIPModuleViewEngine.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/26.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleViewEngine.h"
#import "TRIPModuleBaseTableViewCell.h"
#import "TRIPModuleBaseTableHeaderFooterView.h"

#define STRING_IS_EMPTY(str) ((str) == nil ||![(str) isKindOfClass:[NSString class]]|| [(str) length]<1)

@implementation TRIPModuleViewEngine

+(id)objectForName:(NSString *)name{
    if (STRING_IS_EMPTY(name)) {
        return nil;
    }else{
        Class class = NSClassFromString(name);
        return [[class alloc] init];
    }
}

+(UIView *)viewForName:(NSString *)name{
    id targetObj = [TRIPModuleViewEngine objectForName:name];
    if ([targetObj isKindOfClass:[UIView class]]) {
        return targetObj;
    }
    return nil;
}

+(TRIPModuleBaseTableViewCell *)cellForViewName:(NSString *)name reuseId:(NSString *)reuseId{
    if (STRING_IS_EMPTY(name) || STRING_IS_EMPTY(reuseId)) {
        return nil;
    }else{
        Class class = NSClassFromString(name);
        if ([class isSubclassOfClass:[TRIPModuleBaseTableViewCell class]]) {
            return [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        }
        return nil;
    }
}

+(TRIPModuleBaseTableHeaderFooterView *)tableHeaderFooterViewForName:(NSString *)name
                                                             reuseId:(NSString *)reuseId{
    if (STRING_IS_EMPTY(name) || STRING_IS_EMPTY(reuseId)) {
        return nil;
    }else{
        Class class = NSClassFromString(name);
        if ([class isSubclassOfClass:[TRIPModuleBaseTableHeaderFooterView class]]) {
            return [[class alloc] initWithReuseIdentifier:reuseId];
        }
        return nil;
    }
}

+(CGFloat)heightForView:(NSString *)viewName withBizModel:(id)bizModel{
    if (STRING_IS_EMPTY(viewName)) {
        return 0;
    }
    CGFloat height = 0;
    Class viewClass = NSClassFromString(viewName);
    if ([viewClass respondsToSelector:@selector(heightForModel:)]) {
        //判断是否含有这个类方法
        height = [viewClass heightForModel:bizModel];
    }
    return height;
}

@end
