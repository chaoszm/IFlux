//
//  TRIPModuleBaseTableHeaderFooterView.h
//  TRIPCart
//
//  Created by 邹明 on 16/9/26.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRIPModuleBaseSectionModel.h"

@interface TRIPModuleBaseTableHeaderFooterView : UITableViewHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

+(CGFloat)heightForModel:(TRIPModuleBaseSectionModel *)sectionModel;

@end
