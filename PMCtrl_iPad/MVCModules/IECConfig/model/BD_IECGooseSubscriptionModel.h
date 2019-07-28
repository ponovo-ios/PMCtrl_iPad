//
//  BD_IECGooseSubscriptionModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_IECGooseSubscriptionSCLDataModel : NSObject
//是否发布
@property(nonatomic,assign)BOOL isTransmit;
//目标MAC地址
@property(nonatomic,strong)NSString *targeMACAddress;

//APPID
@property(nonatomic,strong)NSString *APPID;
//订阅光口
@property(nonatomic,strong)NSString *SubscriptionOpticalport;
//描述
@property(nonatomic,strong)NSString *describe;
//通道数
@property(nonatomic,strong)NSString *passageNum;
//版本
@property(nonatomic,strong)NSString *version;
@property(nonatomic,assign)BOOL isTest;
@property(nonatomic,strong)NSString *gocbRef;
@property(nonatomic,strong)NSString *datSet;
@property(nonatomic,strong)NSString *goId;
@property(nonatomic,assign)BOOL ndsCom;
//允许生存时间
@property(nonatomic,strong)NSString *alowExistTime;
//是否解析GoCB,goID和APPId
@property(nonatomic,assign)BOOL isAnalysis;

-(instancetype)initWithTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress APPID:(NSString *)APPID   SubscriptionOpticalport:(NSString *)SubscriptionOpticalport  describe:(NSString *)describe  passageNum:(NSString *)passageNum  version:(NSString *)version  isTest:(BOOL)isTest  gocbRef:(NSString *)gocbRef  datSet:(NSString *)datSet  goId:(NSString *)goId  ndsCom:(BOOL)ndsCom alowExistTime:(NSString *)alowExistTime isAnalysis:(BOOL)isAnalysis;
@end


@interface BD_IECGooseSubscriptionPassageMapModel : NSObject
//测试仪开入
@property(nonatomic,strong)NSString *binary;
//绑定控制块MAC
@property(nonatomic,strong)NSString * bindingMACAddress;
//绑定控制块appid
@property(nonatomic,strong)NSString * bindingAppID;
//绑定通道
@property(nonatomic,strong)NSString * bindingPassage;
-(instancetype)initWithBinary:(NSString *)binary bindingMACAddress:(NSString *)bindingMACAddress bindingAppID:(NSString *)bindingAppID bindingPassage:(NSString *)bindingPassage;
@end

@interface BD_IECGooseSubscriptionModel : NSObject

@end
