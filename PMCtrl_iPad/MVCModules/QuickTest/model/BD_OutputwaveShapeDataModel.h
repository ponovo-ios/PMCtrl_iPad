//
//  BD_OutputwaveShapeDataModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 输出实时波形图模型*/
@interface BD_OutputwaveShapeDataModel : NSObject
@property(nonatomic,strong)NSMutableArray *voltageArr;
@property(nonatomic,strong)NSMutableArray *currentArr;
-(instancetype)initWithVoltageArr:(NSMutableArray *)voltageArr currentArr:(NSMutableArray *)currentArr;
@end



