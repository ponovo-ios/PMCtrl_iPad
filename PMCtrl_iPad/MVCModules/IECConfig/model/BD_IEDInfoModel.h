//
//  BD_IECInfoModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/3/29.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**订阅消息*/
@interface BD_SubRECInfo:NSObject
//内部虚端子信息
@property(nonatomic,strong)NSString *ref;
//描述
@property(nonatomic,strong)NSString *desc;

//外部虚端子信息
@property(nonatomic,strong)NSString *sub_IED_name;
@property(nonatomic,strong)NSString *sub_ldInst;
@property(nonatomic,strong)NSString *sub_ref;

@property(nonatomic,assign)NSInteger index_IED;
@property(nonatomic,assign)NSInteger index_GSE_SMV;
@property(nonatomic,assign)NSInteger index_Rec;

@end

@interface BD_ConnectPubInfo:NSObject
@property(nonatomic,assign)NSInteger index_IED;
@property(nonatomic,assign)NSInteger index_Rec;
@end

/**发布消息*/
@interface BD_PublishRECInfo:NSObject

@property(nonatomic,strong)NSString *ref;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *bType;
//一条信息发布给多个IED
@property(nonatomic,strong)NSMutableArray<BD_ConnectPubInfo *> *recPubList;
@end

/**GOOSE发送数据块*/
@interface BD_GSEInfo:NSObject
@property(nonatomic,strong)NSString *apName;    //访问点名称
@property(nonatomic,strong)NSString *apDesc;

@property(nonatomic,strong)NSString *cbName;    //控制块名称
@property(nonatomic,strong)NSString *ldInst;    //逻辑设备
@property(nonatomic,strong)NSString *desc;      //控制块注释
//Address
@property(nonatomic,strong)NSString *MAC_Adress;
@property(nonatomic,strong)NSString *VLAN_ID;
@property(nonatomic,strong)NSString *VLAN_PRIORITY;
@property(nonatomic,strong)NSString *APPID;

@property(nonatomic,assign)NSInteger MinTime;
@property(nonatomic,assign)NSInteger MaxTime;

@property(nonatomic,strong)NSString *datSet;    //数据集名称
@property(nonatomic,strong)NSString *confRev;    //版本号
@property(nonatomic,strong)NSString *appID;    //goID

@property(nonatomic,assign)NSInteger recNum;    //数据集通道个数
@property(nonatomic,strong)NSString *DataSetDesc;    //数据集注释
//一个控制块，多条记录
@property(nonatomic,strong)NSMutableArray<BD_PublishRECInfo *> *pubList;

@end

/**SMV发送数据块*/
@interface BD_SMVInfo:NSObject
@property(nonatomic,strong)NSString *apName;
@property(nonatomic,strong)NSString *apDesc;

@property(nonatomic,strong)NSString *cbName;
@property(nonatomic,strong)NSString *ldInst;
@property(nonatomic,strong)NSString *desc;

//Address
@property(nonatomic,strong)NSString *MAC_Adress;
@property(nonatomic,strong)NSString *VLAN_ID;
@property(nonatomic,strong)NSString *APPID;
@property(nonatomic,strong)NSString *VLAN_PRIORITY;

//SampledValueControl
@property(nonatomic,strong)NSString *datSet;
@property(nonatomic,strong)NSString *confRev;
@property(nonatomic,strong)NSString *SmvID;

//string multicast;    //暂时不用
@property(nonatomic,assign)NSInteger smpRate;
@property(nonatomic,assign)NSInteger nofASDU;

//SmvOpts
@property(nonatomic,assign)bool refreshTime;             //刷新时间
@property(nonatomic,assign)bool sampleSynchronized;    //同步采样
@property(nonatomic,assign)bool sampleRate;             //采样速率
@property(nonatomic,assign)bool security;                 //完全
@property(nonatomic,assign)bool dataRef;                 //数据引用

@property(nonatomic,assign)NSInteger recNum;
@property(nonatomic,strong)NSString *DataSetDesc;
//一个控制块，多条记录
@property(nonatomic,strong)NSMutableArray <BD_PublishRECInfo *> *pubList;
@end

/**IED*/
@interface BD_IEDInfoModel : NSObject
@property(nonatomic,strong)NSString *IEDname;
@property(nonatomic,strong)NSString *IEDtype;
@property(nonatomic,strong)NSString *IEDmanufacture;
@property(nonatomic,strong)NSString *IEDconfigVersion;
@property(nonatomic,strong)NSString *IEDDescription;
@property(nonatomic,strong)NSMutableArray<BD_GSEInfo *> *GSEList;
@property(nonatomic,strong)NSMutableArray<BD_SMVInfo *> *SMVList;
@property(nonatomic,strong)NSMutableArray<BD_SubRECInfo *> *GOSubList;
@property(nonatomic,strong)NSMutableArray<BD_SubRECInfo *> *SVSubList;


@end
