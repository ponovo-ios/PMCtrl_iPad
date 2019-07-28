//
//  BD_DifferTestItemParaVCViewController+BD_DifferParamActionList.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/20.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferTestItemParaVCViewController.h"

@interface BD_DifferTestItemParaVCViewController (BD_DifferParamActionList)
/**清除结果*/
-(void)clearResult;
/**全部清除*/
-(void)allClear;
/**添加测试项*/
-(void)addTestItem;
/**添加系列*/
-(void)addTestItemSeries;
/**删除测试项*/
-(void)deleteTestItem;
/**删除N-1*/
-(void)deleteNtestItem;
@end
