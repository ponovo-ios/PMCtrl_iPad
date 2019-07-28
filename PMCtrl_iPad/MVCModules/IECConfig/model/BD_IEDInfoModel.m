//
//  BD_IECInfoModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/3/29.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_IEDInfoModel.h"

@implementation BD_SubRECInfo
-(instancetype)init{
    if (self = [super init]) {
        self.ref = @"";
        self.desc  = @"";
        self.sub_IED_name = @"";
        self.sub_ldInst = @"";
        self.sub_ref = @"";
        self.index_IED = 0;
        self.index_GSE_SMV = 0;
        self.index_Rec = 0;
    }
    return self;
}
@end

@implementation BD_ConnectPubInfo
-(instancetype)init{
    if (self = [super init]) {
        self.index_IED = 0;
        self.index_Rec = 0;
    }
    return self;
}

@end

@implementation BD_PublishRECInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ref = @"";
        self.desc = @"";
        self.bType = @"";
        self.recPubList = [[NSMutableArray alloc]init];
    }
    return self;
}
@end

@implementation BD_GSEInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apName = @"";
        self.apDesc = @"";
        self.cbName = @"";
        self.ldInst = @"";
        self.desc =@"";
        self.MAC_Adress = @"";
        self.VLAN_ID = @"";
        self.VLAN_PRIORITY = @"";
        self.appID = @"";
        self.MinTime = 0;
        self.MaxTime = 0;
        self.datSet = @"";
        self.confRev = @"";
        self.appID = @"";
        self.recNum = 0;
        self.DataSetDesc = @"";
        self.pubList = [[NSMutableArray alloc]init];
    }
    return self;
}
@end

@implementation BD_SMVInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apName = @"";
        self.apDesc = @"";
        self.cbName = @"";
        self.ldInst = @"";
        self.desc = @"";
        self.MAC_Adress = @"";
        self.VLAN_ID = @"";
        self.APPID = @"";
        self.VLAN_PRIORITY = @"";
        self.datSet = @"";
        self.confRev = @"";
        self.SmvID = @"";
        self.smpRate = 0;
        self.nofASDU = 0;
        
        self.refreshTime = NO;
        self.sampleSynchronized = NO;
        self.sampleRate = NO;
        self.security = NO;
        self.dataRef = NO;
        
        self.recNum = 0;
        self.DataSetDesc = @"";
        self.pubList = [[NSMutableArray alloc]init];
    }
    return self;
}
@end

@implementation BD_IEDInfoModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.IEDname = @"";
        self.IEDtype = @"";
        self.IEDmanufacture = @"";
        self.IEDconfigVersion = @"";
        self.IEDDescription = @"";
        self.GSEList = [[NSMutableArray alloc]init];
        self.SMVList = [[NSMutableArray alloc]init];
        self.GOSubList = [[NSMutableArray alloc]init];
        self.SVSubList = [[NSMutableArray alloc]init];
        
    }
    return self;
}
@end
