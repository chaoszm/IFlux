//
//  TRIPModuleTestAddCellView.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/30.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleTestAddCellView.h"

@interface TRIPTagItemView : UILabel

@end

@implementation TRIPTagItemView

-(void)setText:(NSString *)text{
    [super setText:text];
    [self sizeToFit];
    
    CGRect frame = self.frame;
    frame.size.width = frame.size.width + 32;
    frame.size.height = frame.size.height + 10;
    self.frame = frame;
}

@end

@interface TRIPModuleTestAddCellView ()

@property (nonatomic,strong) UIScrollView *scrollView;

//上一次渲染的model集合
@property (nonatomic,strong) NSArray *lastRenderModel;

//渲染的tagView的集合
@property (nonatomic,strong) NSMutableArray *tagViews;

@end

@implementation TRIPModuleTestAddCellView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0,59.5,SCREEN_WIDTH,0.5)];
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
        [self addSubview:bottomLine];
        
        _tagViews = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)renderUIWithModel:(TRIPModuleBaseModel *)model{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    NSArray *buttonList = model.bizData;
    
    
    for (NSDictionary *categoryDic in buttonList) {
        NSString *name = categoryDic[@"name"] ;
        if (!STRING_IS_EMPTY(name)) {
            [items addObject:name];
        }
    }
    
    //如果没有变化，则不用重新生成
    if ([items isEqualToArray:_lastRenderModel]) {
        return;
    }
    
    //否则需要清除视图，重新生成
    for (UIView *tagView in _tagViews) {
        [tagView removeFromSuperview];
    }
    [_tagViews removeAllObjects];
    
    NSInteger originX = 20;
    for (int i=0; i<items.count; i++) {
        TRIPTagItemView *item = [self getItemViewWithOriginX:originX text:items[i]];
        [_scrollView addSubview:item];
        originX = originX + CGRectGetWidth(item.frame) +10;
        
        item.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTagViewWith:)];
        [item addGestureRecognizer:tapRecognizer];
        
        tapRecognizer.view.tag = 1024+i;
        
        [_tagViews addObject:item];
    }
    if (originX >SCREEN_WIDTH) {
        _scrollView.contentSize = CGSizeMake(originX, CGRectGetHeight(self.frame));
    }
    
    _scrollView.frame = self.bounds;
    _lastRenderModel = items;
}

-(void)clickTagViewWith:(UITapGestureRecognizer *)tapGesture{
    
    NSInteger index = tapGesture.view.tag-1024;
    NSArray *buttonList = self.model.bizData;
    
    NSString *action;
    if (index>=0 && index<buttonList.count) {
        NSDictionary *item = buttonList[index];
        action = item[@"action"];
    }
    
    [[IFluxDispatchManager shareInstance] dispatchToRegisterDataStoreWithAction:action context: [IFluxEventContext contextWithPslf:self]];
}

-(TRIPTagItemView *)getItemViewWithOriginX:(NSInteger)originX text:(NSString *)text{
    TRIPTagItemView *item = [[TRIPTagItemView alloc] init];
    item.backgroundColor = [UIColor colorWithHexString:@"#F2F3F4"];
    item.frame = CGRectMake(originX, (CGRectGetHeight(self.frame)+20.f-26)/2 , 30, 0);
    item.font = [UIFont fontWithName:@"Helvetica" size:12];
    item.layer.cornerRadius = 12;
    item.layer.masksToBounds = YES;
    item.textColor = [UIColor colorWithHexString:@"#A5A5A5"];
    item.textAlignment = NSTextAlignmentCenter;
    item.text = text;
    
    return item;
}

+(CGFloat)heightForModel:(TRIPModuleBaseCellModel *)cellModel{
    return 60.f;
}

@end
