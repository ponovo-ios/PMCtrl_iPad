//
//  BD_SysParaModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SysParaModel.h"

@implementation BD_DeviceChanelDesc
-(instancetype)init{
    if (self = [super init]) {
        self.smvMaxGroupNum = 0;//SMV最大组数
        self.goosePubMaxGroupMum=0;//GOOSE最大组数
        self.gooseinMaxGroupNum=0;//goosein 最大组数
        self.analogVoltMaxChanel=0;//模拟量电压最大通道
        self.analogCurrentMaxChanel=0;//模拟量电流最大通道
        self.frequencyMax=0;//频率范围
        self.voltageMax=0.0;//电压范围
        self.currentMax=0.0;//电流范围
        self.isHasUDC=YES;//是否有Udc;
        self.UDCMax=0.0;//Udc范围
        self.isHasIDC=YES;
        self.IDCMax=0.0;
        self.binaryInMaxNum=0;//开入量个数
        self.binaryOutMaxNum=0;//开出量个数
        self.isHasDigitalOut=YES ;//是否有数字输出功能
        self.isHasVoltAnalogOut=YES;//是否有模拟输出功能
        self.isHasCurAnalogOut=YES;//
        self.digitalModuleNum=0;//数字模块数
        self.digitalModulePortNum=0 ;//数字模块光口数
        self.analogVoltModuleCount=0 ;//电压模块数
        self.analogVoltModuleBeginNum=0 ;//电压模块起始编号
        self.AnalogVoltModuleChanleCount = @[];;//电压模块通道数,数组中存放int
        self.analogCurrentModuleCount=0;//电流模块数
        self.analogCurrentModuleBeginNum=0;//电流模块起始编号
        self.analogCurrentModuleChanleCount=@[];//电流模块通道数,数组中存放int
        self.deviceNumber=0;//device number only one;
    }
    return self;
}
@end

@implementation BD_SysParaModel

-(instancetype)init{
    if (self = [super init]) {
        self.chanelDesc = [[BD_DeviceChanelDesc alloc]init];
    }
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_SysParaModel *zoneM = [[[self class]allocWithZone:zone]init];
    zoneM.chanelDesc = self.chanelDesc;
    return zoneM;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_SysParaModel *zoneM = [[[self class]allocWithZone:zone]init];
    zoneM.chanelDesc = self.chanelDesc;
    return zoneM;
}
@end
