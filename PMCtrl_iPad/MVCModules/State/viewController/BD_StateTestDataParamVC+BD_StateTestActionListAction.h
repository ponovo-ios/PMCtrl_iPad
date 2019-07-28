//
//  BD_StateTestDataParamVC+BD_StateTestActionListAction.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestDataParamVC.h"

@interface BD_StateTestDataParamVC (BD_StateTestActionListAction)
/**清除当前项结果*/
-(void)clearResult;
/**添加测试项*/
-(void)addTestItem;
/**删除测试项*/
-(void)deleteTestItem;
/**清空添加项测试结果和评估结果*/
-(void)clearAllDataAndResult;
/**清空所有测试结果和评估*/
-(void)clearAllResult;
/**全选*/
-(void)selectedAll;
/**全不选*/
-(void)unselectedAll;
@end
