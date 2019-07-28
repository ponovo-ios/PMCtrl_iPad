//
//  BD_StateTestDataParamVC+BD_StateTestActionListAction.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestDataParamVC+BD_StateTestActionListAction.h"
#import "BD_StateTestItemModel.h"
#import "BD_StateTestParamModel.h"
@implementation BD_StateTestDataParamVC (BD_StateTestActionListAction)
-(void)clearResult{
    //清除测试结果
    self.testListDataSource[self.currentTestItem].itemResult = @"";
    //清除评估结果
}

-(void)addTestItem{

    BD_StateTestItemModel *newModel = [[BD_StateTestItemModel alloc]init];
    newModel.itemNum = self.testListDataSource[self.currentTestItem].itemNum;
    newModel.itemName = self.testListDataSource[self.currentTestItem].itemName;
    newModel.itemProject = self.testListDataSource[self.currentTestItem].itemProject;
    newModel.itemSelect = self.testListDataSource[self.currentTestItem].itemSelect;
    newModel.itemResult =  self.testListDataSource[self.currentTestItem].itemResult;
    
    NSMutableArray *V_DataSource = [[NSMutableArray alloc]init];
    NSMutableArray *C_DataSource = [[NSMutableArray alloc]init];
    [self.testListDataSource[self.currentTestItem].itemParam.stateParam.voltageOutputDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [V_DataSource addObject:[obj copy]];
    }];
    [self.testListDataSource[self.currentTestItem].itemParam.stateParam.currentOutputDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [C_DataSource addObject:[obj copy]];
    }];
    
    newModel.itemParam.stateParam.isDirectCurrent = self.testListDataSource[self.currentTestItem].itemParam.stateParam.isDirectCurrent;
    newModel.itemParam.stateParam.voltageOutputDatas = V_DataSource;
    newModel.itemParam.stateParam.currentOutputDatas = C_DataSource;
    newModel.itemParam.triggerParam = [self.testListDataSource[self.currentTestItem].itemParam.triggerParam copy];
    newModel.itemParam.transmutationParam = [self.testListDataSource[self.currentTestItem].itemParam.transmutationParam copy];
    newModel.itemParam.result = self.testListDataSource[self.currentTestItem].itemParam.result;
    
    if (self.testListDataSource.count<100) {
        [self.testListDataSource insertObject:newModel atIndex:self.currentTestItem+1];
       
        [self.testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.itemNum = idx+1;
        }];
        self.currentTestItem = self.currentTestItem+1;
    } else {
        [MBProgressHUDUtil showMessage:@"最多只能添加100条测试项" toView:self.view];
    }
    
}


-(void)deleteTestItem{
    //应该先改变当前选择行，后删除
    if (self.testListDataSource.count>1) {
       
        [self.testListDataSource removeObjectAtIndex:self.currentTestItem];
        [self.testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.itemNum = idx+1;
        }];
        NSLog(@"%@", self.testListDataSource);
        if (self.currentTestItem!=0) {
            self.currentTestItem-=1;
            
        }
    }else{
        [MBProgressHUDUtil showMessage:@"至少保留一条测试项" toView:self.view];
    }
    
    
    
}

-(void)clearAllDataAndResult{
    [self.testListDataSource removeAllObjects];
    self.currentTestItem = 0;
    [self readDataFromPlist];
}
-(void)clearAllResult{
    [self.testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemResult = @"";
    }];
    
}

-(void)selectedAll{
    [self.testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemSelect = YES;
    }];
}
-(void)unselectedAll{
    [self.testListDataSource enumerateObjectsUsingBlock:^(BD_StateTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemSelect = NO;
    }];
}


@end
