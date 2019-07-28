//
//  BD_IECGooseSubscriptionModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECGooseSubscriptionModel.h"

@implementation BD_IECGooseSubscriptionSCLDataModel
-(instancetype)initWithTransmit:(BOOL)isTransmit targeMACAddress:(NSString *)targeMACAddress APPID:(NSString *)APPID SubscriptionOpticalport:(NSString *)SubscriptionOpticalport describe:(NSString *)describe passageNum:(NSString *)passageNum version:(NSString *)version isTest:(BOOL)isTest gocbRef:(NSString *)gocbRef datSet:(NSString *)datSet goId:(NSString *)goId ndsCom:(BOOL)ndsCom alowExistTime:(NSString *)alowExistTime isAnalysis:(BOOL)isAnalysis{
    if (self = [super init]) {
        self.isTransmit = isTransmit;
        self.targeMACAddress = targeMACAddress;
        self.APPID = APPID;
        self.SubscriptionOpticalport = SubscriptionOpticalport;
        self.describe = describe;
        self.passageNum = passageNum;
        self.version = version;
        self.isTest = isTest;
        self.gocbRef = gocbRef;
        self.datSet = datSet;
        self.goId = goId;
        self.ndsCom = ndsCom;
        self.alowExistTime = alowExistTime;
        self.isAnalysis = isAnalysis;
    }
    return self;
}
@end


@implementation BD_IECGooseSubscriptionPassageMapModel
-(instancetype)initWithBinary:(NSString *)binary bindingMACAddress:(NSString *)bindingMACAddress bindingAppID:(NSString *)bindingAppID bindingPassage:(NSString *)bindingPassage{
    if (self = [super init]) {
        self.binary = binary;
        self.bindingMACAddress = bindingMACAddress;
        self.bindingAppID = bindingAppID;
        self.bindingPassage = bindingPassage;
    }
    return self;
}
@end

@implementation BD_IECGooseSubscriptionModel

@end
