//
//  BD_StateTestCommonParamModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/5.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestCommonParamModel.h"

@implementation BD_StateTestCommonParamModel

-(instancetype)init{
    if (self = [super init]) {
        self.nominalVoltage = @"100.000";
        self.nominalCurrent = @"5.000";
        self.ratedPower = @"50.000";
        self.binaryChangeState = 0;
        self.reduceCocurrent = NO;
        self.reduceTime = @"0.100";
        self.cycleIndex = @"1";
    }
    return self;
}
-(instancetype)initWithVoltage:(NSString *)nominalVoltage nominalCurrent:(NSString *)nominalCurrent ratedPower:(NSString *)ratedPower binaryChangeState:(int)binaryChangeState reduceCocurrent:(BOOL)reduceCocurrent reduceTime:(NSString *)reduceTime cycleIndex:(NSString *)cycleIndex{
    if (self = [super init]) {
        self.nominalVoltage = nominalVoltage;
        self.nominalCurrent = nominalCurrent;
        self.ratedPower = ratedPower;
        self.binaryChangeState = binaryChangeState;
        self.reduceTime = reduceTime;
        self.reduceCocurrent = reduceCocurrent;
        self.cycleIndex = cycleIndex;
    }
    return self;
}
@end
