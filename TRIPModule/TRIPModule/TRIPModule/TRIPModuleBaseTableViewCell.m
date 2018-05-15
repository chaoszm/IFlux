//
//  TRIPModuleBaseTableViewCell.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/26.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseTableViewCell.h"

@implementation TRIPModuleBaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)renderUI{
    [self renderUIWithModel:self.cellModel];
}

-(void)renderUIWithModel:(TRIPModuleBaseCellModel *)model{
    
}

+(CGFloat)heightForModel:(TRIPModuleBaseCellModel *)cellModel{
    return 0;
}

@end
