//
//  TRIPModuleBaseView.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRIPModuleBaseModel.h"

@interface TRIPModuleBaseView : UIView

//需要绑定的数据
@property (nonatomic,strong) TRIPModuleBaseModel *model;

//根据bizModel渲染，由子类实现
-(void)renderUI;

-(void)renderUIWithModel:(TRIPModuleBaseModel *)model;

/**
 *  根据数据获取View的高度，由子类实现
 *
 *  @param bizModel 业务Model
 *
 *  @return View的高度
 */
+(CGFloat)heightForModel:(TRIPModuleBaseModel *)model;

@end
