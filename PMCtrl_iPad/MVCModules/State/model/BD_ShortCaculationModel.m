//
//  BD_ShortCaculationModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ShortCaculationModel.h"

@implementation BD_ShortCaculationModel
-(instancetype)initWithFaultStyle:(NSString *)faultStyle ZPhiOrRx:(int)ZPhiOrRx ZPhi1:(NSString *)ZPhi1 ZPhi2:(NSString *)ZPhi2 Rx1:(NSString *)Rx1 Rx2:(NSString *)Rx2 caculationModel:(NSString *)caculationModel shortCurrent:(NSString *)shortCurrent shortVoltage:(NSString *)shortVoltage ZSZL:(NSString *)ZSZL cacultationStyle:(NSString *)cacultationStyle ampletude:(NSString *)ampletude phase:(NSString *)phase loadCurrent:(NSString *)loadCurrent loadPowerPhase:(NSString *)loadPowerPhase selectedGroup:(NSString *)selectedGroup{
    if (self = [super init]) {
        self.faultStyle = faultStyle;
        self.ZPhiOrRx = ZPhiOrRx;
        self.ZPhi1 = ZPhi1;
        self.ZPhi2 = ZPhi2;
        self.Rx1 = Rx1;
        self.Rx2 = Rx2;
        self.caculationModel = caculationModel;
        self.shortCurrent = shortCurrent;
        self.shortVoltage = shortVoltage;
        self.ZSZL = ZSZL;
        self.cacultationStyle = cacultationStyle;
        self.ampletude = ampletude;
        self.phase = phase;
        self.loadCurrent = loadCurrent;
        self.loadPowerPhase = loadPowerPhase;
        self.selectedGroup = selectedGroup;
    }
    return self;
}
@end
