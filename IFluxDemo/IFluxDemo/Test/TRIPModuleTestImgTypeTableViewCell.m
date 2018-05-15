//
//  TRIPModuleTestImgTypeTableViewCell.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleTestImgTypeTableViewCell.h"

@interface TRIPModuleTestImgTypeTableViewCell ()

@property (nonatomic,strong) UIImageView *picView;

@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UILabel *content;

@end

@implementation TRIPModuleTestImgTypeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:_picView];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH-70, 18)];
        _title.font = [UIFont fontWithName:@"Helvetica" size:15];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_title];
        
        _content = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, SCREEN_WIDTH-70, 18)];
        _content.font = [UIFont fontWithName:@"Helvetica" size:15];
        _content.textColor = [UIColor blackColor];
        _content.textAlignment = NSTextAlignmentLeft;
        _content.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_content];
    }
    return self;
}

-(void)renderUIWithModel:(TRIPModuleBaseCellModel *)model{
    NSDictionary *bizData = model.cellBizData;
    [self renderUIWithBizDic:bizData];
}

-(void)renderUIWithBizDic:(NSDictionary *)bizData{
    
    _picView.image = [UIImage imageNamed:@"default_small"];
    _title.text = bizData[@"title"];
    _content.text = bizData[@"content"];
}

//-(void)trigerDataChangeWithNew:(id)newData old:(id)oldData{
//    [self renderUIWithBizDic:newData];
//}

-(void)trigerDataChangeWithChangeModel:(IFluxDataChangeModel *)changeModel{
    [self renderUIWithBizDic:changeModel.recentData];
}

+(CGFloat)heightForModel:(TRIPModuleBaseCellModel *)cellModel{
    return 60;
}

@end
