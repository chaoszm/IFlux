//
//  TRIPModuleTestTextTypeTableViewCell.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleTestTextTypeTableViewCell.h"

@interface TRIPModuleTestTextTypeTableViewCell ()

@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UILabel *content;

@end

@implementation TRIPModuleTestTextTypeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 18)];
        _title.font = [UIFont fontWithName:@"Helvetica" size:15];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_title];
        
        _content = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 18)];
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
    _title.text = bizData[@"title"];
    _content.text = bizData[@"content"];
}

+(CGFloat)heightForModel:(TRIPModuleBaseCellModel *)cellModel{
    return 60;
}

@end
