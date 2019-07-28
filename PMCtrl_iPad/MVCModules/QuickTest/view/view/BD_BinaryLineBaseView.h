//
//  BD_BinaryLineBaseView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/27.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_BinaryStateModel.h"
@interface BD_BinaryLineBaseView : UIView
/**坐标系中，x轴的最大值，y*/
@property(nonatomic,assign)int xmaxValue;
/**线颜色*/
@property(nonatomic,strong)UIColor *lineColor;
/**开入开出状态图的数据源*/
@property(nonatomic,strong)NSArray<BD_BinaryStateModel *> *lineDataArr;
@end
