//
//  BD_DifferTestItemParaVCViewController.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferentialTestItemModel;
@class BD_DifferBaseDataModel;
@class BD_DifferAddSeriesView;
@interface BD_DifferTestItemParaVCViewController : UIViewController
@property(nonatomic,strong)BD_DifferBaseDataModel *testItemBaseData;
@property(nonatomic,assign)NSInteger currentSelItem;
@property(nonatomic,strong)NSMutableArray<BD_DifferentialTestItemModel *> *testListdataSource;
@property(nonatomic,strong)void(^listDataSourceChangedBlock)();
@property(nonatomic,strong)BD_DifferAddSeriesView *addSeriesView;
@property(nonatomic,strong)NSString *assessmentError;//评估误差范围
-(void)createDefaultData;
//通用参数更新页面
-(void)updateDataSource_generalData;
//整定值更新数据列表
-(void)updateDataSource_setData;
//测试页面恢复默认
-(void)testListdefaultState;
-(void)reloadTBView;
-(void)reloadTBVIewWithCellIndex:(int)cellIndex;
//更新参数设置页面数据
-(void)setParamViewData;
@end
