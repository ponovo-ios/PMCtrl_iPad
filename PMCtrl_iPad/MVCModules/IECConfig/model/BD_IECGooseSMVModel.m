//
//  BD_IECGooseSMVModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/27.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECGooseSMVModel.h"

@implementation BD_IECGooseSMVModel_618501Model
-(instancetype)initWithisTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress sourceMACAddress:(NSString *)sourceMACAddress APPID:(NSString *)APPID LDname:(NSString *)LDname DataSetName:(NSString *)DataSetName Vlan_priority:(NSString *)Vlan_priority Vlan_id:(NSString *)Vlan_id outputPort:(NSString *)outputPort stateCode1:(NSString *)stateCode1 stateCode2:(NSString *)stateCode2 ratedDelayTime:(NSString *)ratedDelayTime version:(NSString *)version passageNum:(NSString *)passageNum describe:(NSString *)describe{
    if (self = [super init]) {
        self.isTransmit = isTransmit;
        self.targeMACAddress = targeMACAddress;
        self.sourceMACAddress = sourceMACAddress;
        self.APPID = APPID;
        self.LDname = LDname;
        self.DataSetName = DataSetName;
        self.Vlan_priority = Vlan_priority;
        self.Vlan_id = Vlan_id;
        self.outputPort = outputPort;
        
        
    }
    return self;
}
@end

@implementation BD_IECGooseSMVModel_618502Model

-(instancetype)initWithTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress sourceMACAddress:(NSString *)sourceMACAddress APPID:(NSString *)APPID samplingDelayTime:(NSString *)samplingDelayTime Vlan_priority:(NSString *)Vlan_priority Vlan_id:(NSString *)Vlan_id outputPort:(NSString *)outputPort describe:(NSString *)describe passageNum:(NSString *)passageNum synchronousStyle:(NSString *)synchronousStyle svId:(NSString *)svId datSet:(NSString *)datSet{
    if (self = [super init]) {
        self.isTransmit = isTransmit;
        self.targeMACAddress = targeMACAddress;
        self.sourceMACAddress = sourceMACAddress;
        self.APPID = APPID;
        self.samplingDelayTime = self.samplingDelayTime;
        self.Vlan_priority = Vlan_priority;
        self.Vlan_id = Vlan_id;
        self.outputPort = outputPort;
        self.describe = self.describe;
        self.passageNum = passageNum;
        self.synchronousStyle = synchronousStyle;
        self.svId = svId;
        self.datSet = datSet;
    }
    return self;
}
@end

@implementation BD_IECGooseSMVModel_60044Model

-(instancetype)initWithTransmit:(BOOL)isTransmit LDName:(NSString *)LDName describe:(NSString *)describe opticalport:(NSString *)opticalport dataSetName:(NSString *)dataSetName passageNum:(NSString *)passageNum ratedDelayTime:(NSString *)ratedDelayTime stateObject1:(NSString *)stateObject1 stateObject2:(NSString *)stateObject2{
    if (self = [super init]) {
        self.isTransmit = isTransmit;
        self.LDName = LDName;
        self.describe = describe;
        self.opticalport = opticalport;
        self.dataSetName = dataSetName;
        self.passageNum = passageNum;
        self.ratedDelayTime = ratedDelayTime;
        self.stateObject1 = stateObject1;
        self.stateObject2 = stateObject2;
    }
    return  self;
}
@end


@implementation BD_IECGooseSMVModel_CollectorOutputModel

-(instancetype)initWithTransmit:(BOOL)isTransmit transformerType:(NSString *)transformerType describe:(NSString *)describe opticalport:(NSString *)opticalport temperature:(NSString *)temperature passageNum:(NSString *)passageNum ratedDelayTime:(NSString *)ratedDelayTime stateObject1:(NSString *)stateObject1 stateObject2:(NSString *)stateObject2{
    if (self = [super init]) {
        self.isTransmit = isTransmit;
        self.transformerType = transformerType;
        self.describe = describe;
        self.opticalport = opticalport;
        self.temperature = temperature;
        self.passageNum = passageNum;
        self.ratedDelayTime = ratedDelayTime;
        self.stateObject1 = stateObject1;
        self.stateObject2 = stateObject2;
    }
    return  self;
}

@end


@implementation BD_IECGooseSMVModel

@end
