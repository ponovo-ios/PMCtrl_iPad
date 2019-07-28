//
//  BD_BinaryStateLineView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/24.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_BinaryStateModel.h"
@interface BD_BinaryStateLineView : UIView
/**状态图线颜色*/
@property(nonatomic,strong)UIColor *statelineColor;
/**坐标系线颜色*/
@property(nonatomic,strong)UIColor *coordinateColor;
/**x轴标签文字颜色*/
@property(nonatomic,strong)UIColor *xValuesColor;
/**x轴标签文字*/
@property(nonatomic,strong)NSArray *xValues;
/**开入开出状态图数据源数组*/

@property(nonatomic,strong)NSArray<BD_BinaryStateViewModel *> *binaryStateDataSource;
//-(void)drawBinaryStartLine:(NSArray<BD_BinaryStateModel *> *)binaryState;

@end
