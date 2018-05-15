//
//  TRIPModuleViewEngine.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/26.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TRIPModuleBaseTableViewCell;
@class TRIPModuleBaseTableHeaderFooterView;
@class TRIPModuleBaseCellModel;
@class TRIPModuleBaseSectionModel;

@interface TRIPModuleViewEngine : NSObject

/**
 *  根据名字获取视图对象
 *
 *  @param name 类名
 *
 *  @return 视图
 */
+(UIView *)viewForName:(NSString *)name;

/**
 *  根据名字获取cell视图对象
 *
 *  @param name cell类名
 *
 *  @return cell视图
 */
+(TRIPModuleBaseTableViewCell *)cellForViewName:(NSString *)name
                                        reuseId:(NSString *)reuseId;

+(TRIPModuleBaseTableHeaderFooterView *)tableHeaderFooterViewForName:(NSString *)name
                                                             reuseId:(NSString *)reuseId;

/**
 *  根据名字和业务数据获取视图的高度
 *
 *  @param viewName view名
 *  @param bizModel 业务数据
 *
 *  @return view的高度
 */
+(CGFloat)heightForView:(NSString *)viewName withBizModel:(id)bizModel;

@end

