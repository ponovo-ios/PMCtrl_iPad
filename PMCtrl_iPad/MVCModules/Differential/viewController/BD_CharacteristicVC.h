//
//  BD_CharacteristicVC.h
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/7/10.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferentialTestItemParaModel;
@interface BD_CharacteristicVC : UIViewController
@property(nonatomic,strong)BD_DifferSetDataModel *setData;
@property(nonatomic,strong)NSArray<BD_DifferentialTestItemParaModel *> *testItemArr;
@property(nonatomic,strong)NSMutableArray<UIImage *> *characterImages;
@property(nonatomic,assign)NSInteger currentTestItem;
//更新特性曲线图数据
-(void)configLineChart;
-(void)updateQDChartData;
-(void)updateHarmChartData;
-(void)updateActionTimeChartData;
-(void)updateMarkViewWithTestItemIndex:(NSInteger)index;

//修改误差范围
-(void)changeErrorRate:(CGFloat)downRate upRate:(CGFloat)upRate;
@end
