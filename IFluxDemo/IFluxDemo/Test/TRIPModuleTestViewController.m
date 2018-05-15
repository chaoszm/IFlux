//
//  TRIPModuleTestViewController.m
//  TRIPCart
//
//  Created by 邹明 on 16/9/29.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import "TRIPModuleTestViewController.h"
#import "TRIPModuleTestDataService.h"
#import "TRIPModuleTestAddCellView.h"


@interface TRIPModuleTestViewController ()<IFluxListenerProtocol>

@end

@implementation TRIPModuleTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TRIPModuleTestDataService shareInstance] initFakeData];
    [self initSubView];
    __weak typeof(self) weakSelf = self;
    
}

-(void)initSubView{
    self.tableView.backgroundColor = [UIColor grayColor];
    
    
    TRIPModuleTestAddCellView *testAddView = [[TRIPModuleTestAddCellView alloc] init];
    testAddView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [TRIPModuleTestAddCellView heightForModel:nil]);
    testAddView.model = [[TRIPModuleTestDataService shareInstance] generateHeaderActionModel];
    [testAddView renderUI];
    [self.view addSubview:testAddView];
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(testAddView.frame),
                                      SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(testAddView.frame));
    [self reloadTableData];
    
    [[TRIPModuleTestDataService shareInstance] addBizDataListener:self];
}

//-(void)trigerDataChangeWithNew:(id)newData old:(id)oldData{
//    [self reloadTableData];
//}

-(void)trigerDataChangeWithChangeModel:(IFluxDataChangeModel *)changeModel{
    [self reloadTableData];
}

-(void)reloadTableData{
    [self configTableModel:[[TRIPModuleTestDataService shareInstance] outsideGetTableModel]];
    [self.tableView reloadData];
}

-(BOOL)needAddRefresh{
    return YES;
}

@end
