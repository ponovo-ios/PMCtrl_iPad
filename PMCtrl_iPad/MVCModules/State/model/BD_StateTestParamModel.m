//
//  BD_StateTestParamModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateTestParamModel.h"




@implementation BD_StateTestTriggerParamModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.TriggerType = @1;
        self.TriggerLogic =  @1;
        self.TriggerTime =  @5;
//        self.sGpstime =  @1;
//        self.nsGpsTime =  @1;
        self.Gpstime = @"00:00:00";
        self.nBiValide =  @1;
        self.nbinaryout =  @1;
        self.trigerHoldTime =  @1;
        self.isBinaryOutStateInvert =  YES;
        self.binaryOutStateInvertHoldTime =  @1;
        self.isdfdt = NO;
        self.isdvdt = NO;
        self.isComGradient  = NO;
        self.BArr = [[NSArray alloc]init];;
        self.BoArr = [[NSArray alloc]init];
    }
    return self;
}

-(instancetype)initWithTirggerType:(NSNumber *)TriggerType TriggerLogic:(NSNumber *)TriggerLogic TriggerTime:(NSNumber *)TriggerTime Gpstime:(NSString *)Gpstime nBiValide:(NSNumber *)nBiValide nbinaryout:(NSNumber *)nbinaryout trigerHoldTime:(NSNumber *)trigerHoldTime isBinaryOutStateInvert:(bool)isBinaryOutStateInvert binaryOutStateInvertHoldTime:(NSNumber *)binaryOutStateInvertHoldTime isdfdt:(bool)isdfdt isdvdt:(bool)isdvdt isComGradient:(bool)isComGradient  BArr:(NSArray<NSNumber *> *)BArr BoArr:(NSArray<NSNumber *> *)BoArr{
    self = [super init];
    if (self) {
        self.TriggerType = TriggerType;
        self.TriggerLogic = TriggerLogic;
        self.TriggerTime = TriggerTime;
        self.Gpstime = Gpstime;
//        self.nsGpsTime = nsGpsTime;
        self.nBiValide = nBiValide;
        self.nbinaryout = nbinaryout;
        self.trigerHoldTime = trigerHoldTime;
        self.isBinaryOutStateInvert = isBinaryOutStateInvert;
        self.binaryOutStateInvertHoldTime = binaryOutStateInvertHoldTime;
        self.isdfdt = isdfdt;
        self.isdvdt = isdvdt;
        self.isComGradient  = isComGradient;
        self.BArr = BArr;
        self.BoArr = BoArr;
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    
    BD_StateTestTriggerParamModel *param = [[[self class] allocWithZone:zone] init];
    param.TriggerType = self.TriggerType;
    param.TriggerLogic = self.TriggerLogic;
    param.TriggerTime = self.TriggerTime;
    param.Gpstime = self.Gpstime;
//    param.nsGpsTime = self.nsGpsTime;
    param.nBiValide = self.nBiValide;
    param.nbinaryout = self.nbinaryout;
    param.trigerHoldTime = self.trigerHoldTime;
    param.isBinaryOutStateInvert = self.isBinaryOutStateInvert;
    param.binaryOutStateInvertHoldTime = self.binaryOutStateInvertHoldTime;
    param.isdfdt = self.isdfdt;
    param.isdvdt = self.isdvdt;
    param.isComGradient = self.isComGradient;
    param.BArr = [self.BArr copy];
    param.BoArr = [self.BoArr copy];
    return param;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_StateTestTriggerParamModel *param = [[[self class] allocWithZone:zone] init];
    param.TriggerType = self.TriggerType;
    param.TriggerLogic = self.TriggerLogic;
    param.TriggerTime = self.TriggerTime;
    param.Gpstime = self.Gpstime;
//    param.nsGpsTime = self.nsGpsTime;
    param.nBiValide = self.nBiValide;
    param.nbinaryout = self.nbinaryout;
    param.trigerHoldTime = self.trigerHoldTime;
    param.isBinaryOutStateInvert = self.isBinaryOutStateInvert;
    param.binaryOutStateInvertHoldTime = self.binaryOutStateInvertHoldTime;
    param.BArr = [self.BArr copy];
    param.BoArr = [self.BoArr copy];
    return param;
}

@end

@implementation BD_StateTestOutputParamModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isDirectCurrent = NO;
        self.voltageOutputDatas = [[NSMutableArray alloc]init];
        self.currentOutputDatas = [[NSMutableArray alloc]init];
    }
    return self;
}
-(instancetype)initWithIsDirectCurrent:(bool)isDirectCurrent voltageOutputDatas:(NSMutableArray<BD_TestDataParamModel *>*)voltageOutputDatas currentOutputDatas:(NSMutableArray<BD_TestDataParamModel *> *)currentOutputDatas{
    if (self = [self init]) {
        self.isDirectCurrent = isDirectCurrent;
        self.voltageOutputDatas = voltageOutputDatas ;
        self.currentOutputDatas = currentOutputDatas;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_StateTestOutputParamModel *outputdata = [[[self class] allocWithZone:zone]init];
    outputdata.isDirectCurrent = self.isDirectCurrent;
    outputdata.voltageOutputDatas = [self.voltageOutputDatas mutableCopy ];
    outputdata.currentOutputDatas = [self.currentOutputDatas mutableCopy];
    return outputdata;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_StateTestOutputParamModel *outputdata = [[[self class] allocWithZone:zone]init];
    outputdata.isDirectCurrent = self.isDirectCurrent;
    outputdata.voltageOutputDatas = [self.voltageOutputDatas mutableCopy];
    outputdata.currentOutputDatas = [self.currentOutputDatas mutableCopy];
    return outputdata;
}
@end


@implementation BD_StateTestParamModel
-(instancetype)init{
    self = [super init];
    if (self) {
        self.stateParam = [[BD_StateTestOutputParamModel alloc]init];
        self.triggerParam = [[BD_StateTestTriggerParamModel alloc] init];
        self.transmutationParam = [[BD_StateTestTransmutationDetailModel alloc]init];
        self.result = @0;
    }
    return self;
}
-(instancetype)initWithStateParam:(BD_StateTestOutputParamModel *)stateParam triggerParam:(BD_StateTestTriggerParamModel *)triggerParam transmutationParam:(BD_StateTestTransmutationDetailModel *)transmutationParam result:(NSNumber *)result{
    self = [super init];
    if (self) {
        self.stateParam = stateParam;
        self.triggerParam = triggerParam;
        self.transmutationParam = transmutationParam;
        self.result = result;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    BD_StateTestParamModel *param = [[[self class] allocWithZone:zone] init];
    param.stateParam = [self.stateParam copy];
    param.triggerParam = [self.triggerParam copy];
    param.transmutationParam = [self.transmutationParam copy];
    param.result = self.result;
    return param;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_StateTestParamModel *param = [[[self class] allocWithZone:zone] init];
    param.stateParam = [self.stateParam copy];
    param.triggerParam = [self.triggerParam copy];
    param.transmutationParam = [self.transmutationParam copy];
    param.result = self.result;
    return param;
}

@end
