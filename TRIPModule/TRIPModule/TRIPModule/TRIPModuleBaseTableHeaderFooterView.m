//
//  TRIPModuleBaseTableHeaderFooterView.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/26.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleBaseTableHeaderFooterView.h"

@implementation TRIPModuleBaseTableHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

+(CGFloat)heightForModel:(TRIPModuleBaseSectionModel *)sectionModel{
    return 0;
}

@end
