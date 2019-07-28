//
//  BD_StateTestDataParamVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_StateTestItemModel;
@interface BD_StateTestDataParamVC : UIViewController
@property(nonatomic,strong)NSMutableArray<BD_StateTestItemModel *> *testListDataSource;
@property(nonatomic,assign)NSInteger currentTestItem;
@property(nonatomic,assign)NSInteger groupNum;
@property(nonatomic,copy)void(^testListDataSourceCompleteBlock)();
-(void)readDataFromPlist;
-(void)updateViewData;
/**设置参数设置页面不可用--试验进行过程中，页面不可用编辑*/
-(void)setParamViewUnUsed;
/**设置参数设置页面可用--试验停止状态，页面可编辑*/
-(void)setParamViewUsed;
/**刷新当前测试项对应的cell*/
- (void)reloadRowInTableviewWithNcur:(int)ncur;
/**短路计算页面数据恢复默认*/
//注：在重新配置通道后，短路计算页面的数据应该恢复默认
-(void)setCaculatVCDefaultData;
@end
