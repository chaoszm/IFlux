//
//  TRIPModuleBaseTableViewCell.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/26.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRIPModuleBaseCellModel.h"

@interface TRIPModuleBaseTableViewCell : UITableViewCell<IFluxListenerProtocol>

//需要绑定的数据
@property (nonatomic,strong) TRIPModuleBaseCellModel *cellModel;

//子类需要重写，并在这个方法里面实现subviews的初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//根据bizModel渲染，由子类实现
-(void)renderUI;

-(void)renderUIWithModel:(TRIPModuleBaseCellModel *)model;

/**
 *  根据数据获取View的高度，由子类实现
 *
 *  @param bizModel 业务Model
 *
 *  @return View的高度
 */
+(CGFloat)heightForModel:(TRIPModuleBaseCellModel *)cellModel;

//监听的回调事件
-(void)trigerDataChangeWithNew:(id)newData old:(id)oldData;

@end
