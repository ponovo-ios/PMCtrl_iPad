//
//  BD_IECGooseSMVModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/27.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BD_IECGooseSMVModel_618501Model : NSObject
//是否发布
@property(nonatomic,assign)BOOL isTransmit;
//目标MAC地址
@property(nonatomic,strong)NSString *targeMACAddress;
//源MAC地址
@property(nonatomic,strong)NSString *sourceMACAddress;
//APPID
@property(nonatomic,strong)NSString *APPID;
//LDName
@property(nonatomic,strong)NSString *LDname;
//DataSetName
@property(nonatomic,strong)NSString *DataSetName;
//VLAN_Priority
@property(nonatomic,strong)NSString *Vlan_priority;
//Vlan_ID
@property(nonatomic,strong)NSString *Vlan_id;
//输出口选择
@property(nonatomic,strong)NSString *outputPort;
//状态字1
@property(nonatomic,strong)NSString *stateCode1;
//状态字2
@property(nonatomic,strong)NSString *stateCode2;
//额定延时
@property(nonatomic,strong)NSString *ratedDelayTime;
//配置版本号
@property(nonatomic,strong)NSString *version;
//通道个数
@property(nonatomic,strong)NSString *passageNum;
//描述
@property(nonatomic,strong)NSString *describe;

-(instancetype)initWithisTransmit:(BOOL)isTransmit
                  targeMACAddress:(NSString *)targeMACAddress
                 sourceMACAddress:(NSString *)sourceMACAddress
                            APPID:(NSString *)APPID
                           LDname:(NSString *)LDname
                      DataSetName:(NSString *)DataSetName
                    Vlan_priority:(NSString *)Vlan_priority
                  Vlan_id:(NSString *)Vlan_id
                  outputPort:(NSString *)outputPort
                       stateCode1:(NSString *)stateCode1
                       stateCode2:(NSString *)stateCode2
                   ratedDelayTime:(NSString *)ratedDelayTime
                          version:(NSString *)version
                  passageNum:(NSString *)passageNum
                         describe:(NSString *)describe;
@end
@interface BD_IECGooseSMVModel_618502Model : NSObject
//是否发布
@property(nonatomic,assign)BOOL isTransmit;
//目标MAC地址
@property(nonatomic,strong)NSString *targeMACAddress;
//源MAC地址
@property(nonatomic,strong)NSString *sourceMACAddress;
//APPID
@property(nonatomic,strong)NSString *APPID;
//采样延时
@property(nonatomic,strong)NSString *samplingDelayTime;
//VLAN_Priority
@property(nonatomic,strong)NSString *Vlan_priority;
//Vlan_ID
@property(nonatomic,strong)NSString *Vlan_id;
//输出口选择
@property(nonatomic,strong)NSString *outputPort;
//描述
@property(nonatomic,strong)NSString *describe;
//通道数
@property(nonatomic,strong)NSString *passageNum;
//版本号
@property(nonatomic,strong)NSString *version;
//同步方式
@property(nonatomic,strong)NSString *synchronousStyle;
//svID
@property(nonatomic,strong)NSString *svId;
//datSet
@property(nonatomic,strong)NSString *datSet;

-(instancetype)initWithTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress
                sourceMACAddress:(NSString *)sourceMACAddress APPID:(NSString *)APPID samplingDelayTime:(NSString *)samplingDelayTime Vlan_priority:(NSString *)Vlan_priority Vlan_id:(NSString *)Vlan_id outputPort:(NSString *)outputPort describe:(NSString *)describe passageNum:(NSString *)passageNum synchronousStyle:(NSString *)synchronousStyle svId:(NSString *)svId datSet:(NSString *)datSet;
@end

@interface BD_IECGooseSMVModel_60044Model : NSObject
//是否发布
@property(nonatomic,assign)BOOL isTransmit;
//LDName
@property(nonatomic,strong)NSString *LDName;

//描述
@property(nonatomic,strong)NSString *describe;
//光口
@property(nonatomic,strong)NSString *opticalport;
//dataSetName
@property(nonatomic,strong)NSString *dataSetName;
//通道数
@property(nonatomic,strong)NSString *passageNum;
//额定延时
@property(nonatomic,strong)NSString *ratedDelayTime;
//状态字1
@property(nonatomic,strong)NSString *stateObject1;
//状态字2
@property(nonatomic,strong)NSString *stateObject2;


-(instancetype)initWithTransmit:(BOOL)isTransmit LDName:(NSString *)LDName describe:(NSString *)describe opticalport:(NSString *)opticalport dataSetName:(NSString *)dataSetName passageNum:(NSString *)passageNum ratedDelayTime:(NSString *)ratedDelayTime stateObject1:(NSString *)stateObject1 stateObject2:(NSString *)stateObject2;
@end

@interface BD_IECGooseSMVModel_CollectorOutputModel : NSObject
//是否发布
@property(nonatomic,assign)BOOL isTransmit;
//互感器类型
@property(nonatomic,strong)NSString *transformerType;

//描述
@property(nonatomic,strong)NSString *describe;
//光口
@property(nonatomic,strong)NSString *opticalport;
//温度
@property(nonatomic,strong)NSString *temperature;
//通道数
@property(nonatomic,strong)NSString *passageNum;
//额定延时
@property(nonatomic,strong)NSString *ratedDelayTime;
//状态字1
@property(nonatomic,strong)NSString *stateObject1;
//状态字2
@property(nonatomic,strong)NSString *stateObject2;


-(instancetype)initWithTransmit:(BOOL)isTransmit transformerType:(NSString *)transformerType describe:(NSString *)describe opticalport:(NSString *)opticalport temperature:(NSString *)temperature passageNum:(NSString *)passageNum ratedDelayTime:(NSString *)ratedDelayTime stateObject1:(NSString *)stateObject1 stateObject2:(NSString *)stateObject2;
@end
@interface BD_IECGooseSMVModel : NSObject

@end
