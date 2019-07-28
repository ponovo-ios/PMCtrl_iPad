//
//  BD_IECGooseTransmitSCLDataModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**goose发送 顶部scl配置列表模型*/
@interface BD_IECGooseTransmitSCLDataModel : NSObject
//是否发布
@property(nonatomic,assign)BOOL isTransmit;
//目标MAC地址
@property(nonatomic,strong)NSString *targeMACAddress;
//源mac地址
@property(nonatomic,strong)NSString *souceMACAddress;
//APPID
@property(nonatomic,strong)NSString *APPID;

@property(nonatomic,strong)NSString *Vlan_priority;
@property(nonatomic,strong)NSString *Vlan_id;
//输出光口
@property(nonatomic,strong)NSString *outputOpticalport;
@property(nonatomic,strong)NSString *describe;
@property(nonatomic,strong)NSString *passageNum;
@property(nonatomic,strong)NSString *version;
@property(nonatomic,assign)BOOL isTest;
@property(nonatomic,strong)NSString *gocbRef;
@property(nonatomic,strong)NSString *datSet;
@property(nonatomic,strong)NSString *goId;
@property(nonatomic,assign)BOOL ndsCom;
//允许生存时间
@property(nonatomic,strong)NSString *alowExistTime;

-(instancetype)initWithTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress  souceMACAddress:(NSString *)souceMACAddress  APPID:(NSString *)APPID  Vlan_priority:(NSString *)Vlan_priority Vlan_id:(NSString *)Vlan_id outputOpticalport:(NSString *)outputOpticalport  describe:(NSString *)describe  passageNum:(NSString *)passageNum  version:(NSString *)version  isTest:(BOOL)isTest  gocbRef:(NSString *)gocbRef  datSet:(NSString *)datSet  goId:(NSString *)goId  ndsCom:(BOOL)ndsCom alowExistTime:(NSString *)alowExistTime;
@end

/**goose发送 描述 通道类型 通道映射 初始值 */
@interface BD_IECGooseTransmitPassageModel : NSObject
//是否选中
@property(nonatomic,assign)BOOL isselected;
//描述
@property(nonatomic,strong)NSString *describe;
//通道类型
@property(nonatomic,strong)NSString *passageType;
//通道映射
@property(nonatomic,strong)NSString *passageMap;
//初始值
@property(nonatomic,strong)NSString *passageInitialvalue;

-(instancetype)initWithDescribe:(NSString *)describe passageType:(NSString *)passageType passageMap:(NSString *)passageMap passageInitialvalue:(NSString *)passageInitialvalue isselected:( BOOL)isselected;
@end
/**goose发送模型*/
@interface BD_IECGooseTransmitModel : NSObject
@property(nonatomic,strong)NSString *T1Time;
@property(nonatomic,strong)NSString *T2Time;
@property(nonatomic,strong)NSString *T0Time;
@property(nonatomic,strong)NSString *TimerQuality;
@property(nonatomic,strong)NSString *GroupDelayTime;
@property(nonatomic,strong)NSArray<BD_IECGooseTransmitSCLDataModel *> *SCLArr;
@property(nonatomic,strong)NSArray<BD_IECGooseTransmitPassageModel *> *passageDataArr;
-(instancetype)initWithT1Time:(NSString *)T1Time T2Time:(NSString *)T2Time T0Time:(NSString *)T0Time TimerQuality:(NSString *)TimerQuality GroupDelayTime:(NSString *)GroupDelayTime SCLArr:(NSArray<BD_IECGooseTransmitSCLDataModel *> *)SCLArr passageDataArr:(NSArray<BD_IECGooseTransmitPassageModel *> *)passageDataArr;
@end
