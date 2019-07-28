//
//  BD_DifferTestItemParaVCViewController+BD_DifferParamActionList.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/20.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferTestItemParaVCViewController+BD_DifferParamActionList.h"
#import "BD_DifferentialTestItemModel.h"

#import "BD_DifferBaseDataModel.h"
#import "BD_DifferIrCaculateManager.h"
#import "BD_DifferAddSeriesView.h"
@implementation BD_DifferTestItemParaVCViewController (BD_DifferParamActionList)
-(void)clearResult{
    //清除测试结果
    self.testListdataSource[self.currentSelItem].itemResult = @"";
    //清除评估结果
}

-(void)allClear{
    [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemResult = @"";
    }];
}
-(void)addTestItem{
    [self.testListdataSource insertObject:[self.testListdataSource[self.currentSelItem] copy] atIndex:self.currentSelItem+1];
    [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemNum = idx+1;
        obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
    }];
}
-(void)addTestItemSeries{
    WeakSelf;
    self.addSeriesView.okActionBlock = ^(float start, float end, float step, int num) {
        [weakself addSeriesTestItem:start end:end step:step num:num];
    };
    [self.addSeriesView showAddSeriesView];
}
-(void)deleteTestItem{
    if (self.testListdataSource.count>1) {
        //应该先改变当前选择行，后删除
            int num = 0;
            BD_DifferentialTestItemModel *info = self.testListdataSource[self.currentSelItem];
            if (info.testItemParam.itemType != DifferTestItemType_Characteristic) {
                
                for (int i = 0; i<self.testListdataSource.count; i++) {
                    if (self.testListdataSource[i].itemName == info.testItemParam.itemName) {
                        num++;
                    }
                }
                if (![info.testItemParam.itemName hasPrefix:@"比率制动系数"]) {
                    if (num<=1) {
                        [MBProgressHUDUtil showMessage:@"至少保留一个该测试类型" toView:self.view];
                    } else {
                        
                        [self.testListdataSource removeObjectAtIndex:self.currentSelItem];
                        [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            obj.itemNum = idx+1;
                            obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
                        }];
                        if (self.currentSelItem!=0) {
                            self.currentSelItem-=1;
                        }else{
                            self.currentSelItem = 0;
                        }
                        
                    }
                } else {
                    if (num<=2) {
                        [MBProgressHUDUtil showMessage:@"至少保留一个该测试类型" toView:self.view];
                    } else {
                        
                        [self.testListdataSource removeObjectAtIndex:self.currentSelItem];
                        [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            obj.itemNum = idx+1;
                            obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
                        }];
                        if (self.currentSelItem!=0) {
                            self.currentSelItem-=1;
                        }else{
                            self.currentSelItem = 0;
                        }
                    }
                }

                
            } else {
                [self.testListdataSource removeObjectAtIndex:self.currentSelItem];
                [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.itemNum = idx+1;
                    obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
                }];
                if (self.currentSelItem!=0) {
                    self.currentSelItem-=1;
                }else{
                    self.currentSelItem = 0;
                }
            }
            
        
       
    } else {
         [MBProgressHUDUtil showMessage:@"至少保留一条测试项" toView:self.view];
    }
}

-(void)deleteNtestItem{
    [self.testListdataSource removeAllObjects];
    [self createDefaultData];
}


-(void)addSeriesTestItem:(float)start end:(float)end step:(float)step num:(int)num {
    if (start>end) {
        for (float i = start; i>=end; i-=step) {
            BD_DifferentialTestItemParaModel *param5 =[[BD_DifferentialTestItemParaModel alloc]init];
            param5.itemName = [NSString stringWithFormat:@"Ir=%.3fA",i];
            param5.itemType = DifferTestItemType_Characteristic;
            param5.iIndex=[NSString stringWithFormat:@"%ld",self.currentSelItem+1];
           
            param5.Ir=[NSString stringWithFormat:@"%.3f",i];
            param5.fUp=@"0";
            param5.fDown=@"1";
            param5.testPhasorType=self.testItemBaseData.testPhasorType;
            param5.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
            param5.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
            [[BD_DifferIrCaculateManager shared] caculateUpDownData:param5];
            BD_DifferentialTestItemModel *testItem5 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:self.currentSelItem+1 itemName:[NSString stringWithFormat:@"Ir:%.3fA",i] itemSelect:YES itemResult:@"" testItemParam:param5 testItemAssessment:[[BD_DifferAssessmentModel alloc]init]];
            [self.testListdataSource insertObject:testItem5 atIndex:self.currentSelItem+1];
        }
    } else {
        for (float i =start; i<=end; i+=step) {
            BD_DifferentialTestItemParaModel *param5 =[[BD_DifferentialTestItemParaModel alloc]init];
            param5.itemName = [NSString stringWithFormat:@"Ir=%.3fA",i];
            param5.itemType = DifferTestItemType_Characteristic;
            param5.iIndex=[NSString stringWithFormat:@"%ld",self.currentSelItem+1];
            param5.Ir=[NSString stringWithFormat:@"%.3f",i];
            param5.fUp=@"0";
            param5.fDown=@"1";
            param5.testPhasorType=self.testItemBaseData.testPhasorType;
            param5.frequency=[NSString stringWithFormat:@"%.3f",self.testItemBaseData.frequency];
            param5.testAccuracy= [NSString stringWithFormat:@"%.3f",self.testItemBaseData.testAccuracy];
            [[BD_DifferIrCaculateManager shared] caculateUpDownData:param5];
           
            BD_DifferentialTestItemModel *testItem5 = [[BD_DifferentialTestItemModel alloc]initWithItemNum:self.currentSelItem+1 itemName:[NSString stringWithFormat:@"Ir=%.3f",i] itemSelect:YES itemResult:@"" testItemParam:param5 testItemAssessment:[[BD_DifferAssessmentModel alloc]init]];
            [self.testListdataSource insertObject:testItem5 atIndex:self.currentSelItem+1];
        }
    }
    [self.testListdataSource enumerateObjectsUsingBlock:^(BD_DifferentialTestItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemNum = idx+1;
        obj.testItemParam.iIndex = [NSString stringWithFormat:@"%ld",idx+1];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self reloadTBView];
    });
}

@end
