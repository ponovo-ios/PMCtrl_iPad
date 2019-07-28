//
//  BD_IECGooseTransmitSCLDataModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECGooseTransmitModel.h"

@implementation BD_IECGooseTransmitSCLDataModel

-(instancetype)initWithTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress souceMACAddress:(NSString *)souceMACAddress APPID:(NSString *)APPID Vlan_priority:(NSString *)Vlan_priority Vlan_id:(NSString *)Vlan_id outputOpticalport:(NSString *)outputOpticalport describe:(NSString *)describe passageNum:(NSString *)passageNum version:(NSString *)version isTest:(BOOL)isTest gocbRef:(NSString *)gocbRef datSet:(NSString *)datSet goId:(NSString *)goId ndsCom:(BOOL)ndsCom alowExistTime:(NSString *)alowExistTime{
    if (self = [super init]) {
        self.isTransmit = isTransmit;
        self.targeMACAddress = targeMACAddress;
        self.souceMACAddress = souceMACAddress;
        self.APPID = APPID;
        self.Vlan_priority = Vlan_priority;
        self.Vlan_id = Vlan_id;
        self.outputOpticalport  = outputOpticalport;
        self.describe = describe;
        self.passageNum = passageNum;
        self.version = version;
        self.isTest = isTest;
        self.gocbRef = gocbRef;
        self.datSet = datSet;
        self.goId = goId;
        self.ndsCom = ndsCom;
        self.alowExistTime = alowExistTime;
    }
    return self;
}
@end

@implementation BD_IECGooseTransmitPassageModel
-(instancetype)initWithDescribe:(NSString *)describe passageType:(NSString *)passageType passageMap:(NSString *)passageMap passageInitialvalue:(NSString *)passageInitialvalue isselected:(BOOL)isselected{
    if (self = [super init]) {
        self.describe = describe;
        self.passageType = passageType;
        self.passageMap = passageMap;
        self.passageInitialvalue = passageInitialvalue;
        self.isselected = isselected;
    }
    return self;
}
@end

@implementation BD_IECGooseTransmitModel

-(instancetype)initWithT1Time:(NSString *)T1Time T2Time:(NSString *)T2Time T0Time:(NSString *)T0Time TimerQuality:(NSString *)TimerQuality GroupDelayTime:(NSString *)GroupDelayTime SCLArr:(NSArray<BD_IECGooseTransmitSCLDataModel *> *)SCLArr passageDataArr:(NSArray<BD_IECGooseTransmitPassageModel *> *)passageDataArr{
    if (self = [super init]) {
        self.T1Time = T1Time;
        self.T2Time = T2Time;
        self.T0Time = T0Time;
        self.TimerQuality = TimerQuality;
        self.GroupDelayTime = GroupDelayTime;
        self.SCLArr = SCLArr;
        self.passageDataArr = passageDataArr;
    }
    return self;
}
@end

