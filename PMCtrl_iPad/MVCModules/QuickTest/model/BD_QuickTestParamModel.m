//
//  BD_QuickTestParamModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestParamModel.h"






@implementation BD_QuickTestPickerModel
-(instancetype)initWithTitle:(NSString *)title row:(NSArray *)row column:(int)column group:(int)group{
    self = [super init];
    if (self) {
        self.title = title;
        self.row = row;
        self.column = column;
        self.group = group;
    }
    return self;
}

@end


@implementation BD_QuickTestComSetModel
//
//-(instancetype)initWithIntegervalue:(NSString *)intergervalue integerActionTime:(NSString *)integerActionTime  varlabel:(NSString *)varlabel startValue:(NSString *)startValue endValue:(NSString *)endValue stepValue:(NSString *)stepValue changeTime:(NSString *)changeTime isAuto:(bool)isAuto autoChangeStyle:(int)autoChangeStyle isCocurrent:(bool)isCocurrent isAgingTest:(bool)isAgingTest delayTime:(NSString *)delayTime actionTime:(NSString *)actionTime isLock:(bool)isLock rateVoltage:(NSString *)rateVoltage rateCurrent:(NSString *)rateCurrent rateFrequency:(NSString *)rateFrequency{
//    self = [super init];
//    if (self) {
//        self.integervalue = intergervalue;
//        self.integerActionTime = integerActionTime;
//    
//        self.varlabel = varlabel;
//        self.startValue = startValue;
//        self.endValue = endValue;
//        self.stepValue = stepValue;
//        self.changeTime = changeTime;
//        self.isAuto = isAuto;
//        self.autoChangeStyle = autoChangeStyle;
//        self.isCocurrent = isCocurrent;
//        self.isAgingTest = isAgingTest;
//        self.delayTime = delayTime;
//        self.actionTime = actionTime;
//        self.isLock = isLock;
//        self.rateCurrent = rateCurrent;
//        self.rateVoltage = rateVoltage;
//        self.rateFrequency = rateFrequency;
//    }
//    return self;
//}

-(instancetype)init{
    if (self = [super init]) {
        self.integervalue = @"3.000";
        self.integerActionTime = @"1.000";
        
        self.varlabel = @"Ua1,幅值";
        self.startValue = @"3.000";
        self.endValue = @"1.000";
        self.stepValue = @"3.000";
        self.changeTime = @"1.000";
        self.isAuto = NO;
        self.autoChangeStyle = 0;
        self.isCocurrent = NO ;
        self.isAgingTest = NO ;
        self.delayTime = @"0.000" ;
//        self.actionTime = @"0.000";
        self.binaryIn = [NSNumber numberWithLong:1023];
        self.binaryOut = @(0);
        self.binaryLogic = 0;
        self.isLock = NO;
        self.rateCurrent = @"5.000";
        self.rateVoltage = @"100.000";
        self.rateFrequency = @"50.000";
        
    }
    return self;
}
@end


@implementation BD_PassagewayNumModel

-(instancetype)initWithNum:(int)voltagePassageNum currentPassageNum:(int)currentPassageNum{
    self = [super init];
    if (self) {
        self.voltagePassageNum = voltagePassageNum;
        self.currentPassageNum = voltagePassageNum;
    }
    return self;
}

@end
