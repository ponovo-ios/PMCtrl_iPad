//
//  BD_StateTestCommonParamModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/5.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_StateTestCommonParamModel : NSObject
@property(nonatomic,strong)NSString *nominalVoltage;
@property(nonatomic,strong)NSString *nominalCurrent;
@property(nonatomic,strong)NSString *ratedPower;
//开入翻转参考状态
@property(nonatomic,assign)int binaryChangeState;//0第一个状态 1 上一个状态
//叠加衰减直流分量
@property(nonatomic,assign)BOOL reduceCocurrent;
//衰减时间常数
@property(nonatomic,strong)NSString *reduceTime;
//循环次数
@property(nonatomic,strong)NSString *cycleIndex;

-(instancetype)initWithVoltage:(NSString *)nominalVoltage nominalCurrent:(NSString *)nominalCurrent ratedPower:(NSString *)ratedPower binaryChangeState:(int)binaryChangeState reduceCocurrent:(BOOL)reduceCocurrent reduceTime:(NSString *)reduceTime cycleIndex:(NSString *)cycleIndex;
@end
