//
//  BD_DifferentialTestResult.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/6.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_DifferentialTestResultModel.h"

@implementation BD_DifferentialChanel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.famptitude = 0.000;
        self.fphase = 0.000;
    }
    return self;
}
-(instancetype)initWithfamptitude:(float)famptitude fphase:(float)fphase{
    self = [super init];
    if (self) {
        self.famptitude = famptitude;
        self.fphase = fphase;
    }
    return self;
    
}
-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialChanel *copy = [[[self class] allocWithZone:zone]init];
    copy.famptitude = self.famptitude;
    copy.fphase = self.fphase;
    return copy;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialChanel *copy = [[[self class] allocWithZone:zone]init];
    copy.famptitude = self.famptitude;
    copy.fphase = self.fphase;
    return copy;
}
@end


@implementation BD_DifferentialBasicResultItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Ia = [[BD_DifferentialChanel alloc]init];
        self.Ib = [[BD_DifferentialChanel alloc]init];
        self.Ic = [[BD_DifferentialChanel alloc]init];
        self.Iap = [[BD_DifferentialChanel alloc]init];
        self.Ibp = [[BD_DifferentialChanel alloc]init];
        self.Icp = [[BD_DifferentialChanel alloc]init];
    }
    return self;
}
-(instancetype)initWithIa:(BD_DifferentialChanel *)Ia Ib:(BD_DifferentialChanel *)Ib Ic:(BD_DifferentialChanel *)Ic Iap:(BD_DifferentialChanel *)Iap Ibp:(BD_DifferentialChanel *)Ibp Icp:(BD_DifferentialChanel *)Icp{
    self = [super init];
    if (self) {
        self.Ia = Ia;
        self.Ib = Ib;
        self.Ic = Ic;
        self.Iap = Iap;
        self.Ibp = Ibp;
        self.Icp = Icp;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialBasicResultItem *copy = [[[self class] allocWithZone:zone]init];
    copy.Ia = self.Ia;
    copy.Ib = self.Ib;
    copy.Ic = self.Ic;
    copy.Iap = self.Iap;
    copy.Ibp = self.Ibp;
    copy.Icp = self.Icp;
    return copy;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialBasicResultItem *copy = [[[self class] allocWithZone:zone]init];
    copy.Ia = self.Ia;
    copy.Ib = self.Ib;
    copy.Ic = self.Ic;
    copy.Iap = self.Iap;
    copy.Ibp = self.Ibp;
    copy.Icp = self.Icp;
    return copy;
}
@end



@implementation BD_DifferentialTestItem_QDCurrent
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemType = DifferTestItemType_QDCurrent;
        self.iIndex = 0;
        self.basic = [[BD_DifferentialBasicResultItem alloc]init];
        self.Id = 0.000;
        self.bEnd = NO;
        self.nibinstate = 0;
    }
    return self;
}
-(instancetype)initWithitemType:(DifferTestItemType)itemType iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic Id:(float)Id bEnd:(bool)bEnd nibinstate:(int)nibinstate{
    self = [super init];
    if (self) {
        self.itemType = itemType;
        self.iIndex = iIndex;
        self.basic = basic;
        self.Id = Id;
        self.bEnd = bEnd;
        self.nibinstate = nibinstate;
    }
    return self;
    
}
-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialTestItem_QDCurrent *copy = [[[self class] allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.Id = self.Id;
    copy.bEnd = self.bEnd;
    copy.nibinstate = self.nibinstate;
    return copy;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialTestItem_QDCurrent *copy = [[[self class] allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.Id = self.Id;
    copy.bEnd = self.bEnd;
    copy.nibinstate = self.nibinstate;
    return copy;
}
@end


@implementation BD_DifferentialTestItem_ZDRatio
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemType = DifferTestItemType_ZDRatio;
        self.iTypeIndex = 0;
        self.iIndex = 0;
        self.basic = [[BD_DifferentialBasicResultItem alloc]init];
        self.Id = 0.000;
        self.bEnd = NO;
        self.nibinstate = 0;
    }
    return self;
}
-(instancetype)initWithitemType:(DifferTestItemType)itemType iTypeIndex:(int)iTypeIndex iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic Id:(float)Id bEnd:(bool)bEnd nibinstate:(int)nibinstate{
    self = [super init];
    if (self) {
        self.itemType = itemType;
        self.iTypeIndex = iTypeIndex;
        self.iIndex = iIndex;
        self.basic = basic;
        self.Id = Id;
        self.bEnd = bEnd;
        self.nibinstate = nibinstate;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialTestItem_ZDRatio *copy = [[[self class] allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iTypeIndex = self.iTypeIndex;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.Id = self.Id;
    copy.bEnd = self.bEnd;
    copy.nibinstate = self.nibinstate;
    return copy;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialTestItem_ZDRatio *copy = [[[self class] allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iTypeIndex = self.iTypeIndex;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.Id = self.Id;
    copy.bEnd = self.bEnd;
    copy.nibinstate = self.nibinstate;
    return copy;
}
@end

@implementation BD_DifferentialTestItem_ActionTime

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemType = DifferTestItemType_ActionTime;
        self.iIndex = 0;
        self.basic = [[BD_DifferentialBasicResultItem alloc]init];
        self.fId = 0.000;
        self.fTime = 0.000;
        self.bEnd = NO;
        self.nibinstate = 0;
    }
    return self;
}


-(instancetype)initWithitemType:(DifferTestItemType)itemType iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic fId:(float)fId fTime:(float)fTime bEnd:(bool)bEnd nibinstate:(int)nibinstate{
    self = [super init];
    if (self) {
        self.itemType = itemType;
        self.iIndex = iIndex;
        self.basic = basic;
        self.fId = fId;
        self.fTime = fTime;
        self.bEnd = bEnd;
        self.nibinstate = nibinstate;
        
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialTestItem_ActionTime *copy = [[[self class]allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.fId = self.fId;
    copy.fTime = self.fTime;
    copy.bEnd = self.bEnd;
    copy.nibinstate = self.nibinstate;
    return copy;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialTestItem_ActionTime *copy = [[[self class]allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.fId = self.fId;
    copy.fTime = self.fTime;
    copy.bEnd = self.bEnd;
    copy.nibinstate = self.nibinstate;
    return copy;
}

@end

@implementation BD_DifferentialHarmonicRatio

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemType = DifferTestItemType_HarmonicRation;
        self.iIndex = 0;
        self.basic = [[BD_DifferentialBasicResultItem alloc]init];
        self.Ir = 0.000;
        self.K = 0.000;
        self.bEnd = NO;
        self.nibinstate  = 0;
    }
    return self;
}
-(instancetype)initWithitemType:(DifferTestItemType)itemType iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic Ir:(float)Ir K:(float)K bEnd:(bool)bEnd nibinstate:(int)nibinstate{
    self = [super init];
    if (self) {
        self.itemType = itemType;
        self.iIndex = iIndex;
        self.basic = basic;
        self.Ir = Ir;
        self.K = K;
        self.bEnd = bEnd;
        self.nibinstate  = nibinstate;
    }
    return  self;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialHarmonicRatio *copy = [[[self class]allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.Ir = self.Ir;
    copy.K = self.K;
    copy.bEnd = self.bEnd;
    copy.nibinstate  = self.nibinstate;
    return copy;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialHarmonicRatio *copy = [[[self class]allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.iIndex = self.iIndex;
    copy.basic = self.basic;
    copy.Ir = self.Ir;
    copy.K = self.K;
    copy.bEnd = self.bEnd;
    copy.nibinstate  = self.nibinstate;
    return copy;
}

@end


@implementation BD_DifferentialTestResult
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemType = DifferTestItemType_QDCurrent;
        self.oQdcurrent = [[BD_DifferentialTestItem_QDCurrent alloc]init];
        self.oActionTime = [[BD_DifferentialTestItem_ActionTime alloc]init];
        self.oZDRatio = [[BD_DifferentialTestItem_ZDRatio alloc]init];
        self.oHarmnonicRatio = [[BD_DifferentialHarmonicRatio alloc]init];
    }
    return self;
}
-(instancetype)initWithitemType:(DifferTestItemType)itemType QDCurrent:(BD_DifferentialTestItem_QDCurrent *)QDCurrent actionTime:(BD_DifferentialTestItem_ActionTime *)actionTime ZDRatio:(BD_DifferentialTestItem_ZDRatio *)ZDRatio harmnonicRatio:(BD_DifferentialHarmonicRatio *)harmnonicRatio{
    self = [super init];
    if (self) {
        self.itemType = itemType;
        self.oQdcurrent = QDCurrent;
        self.oActionTime = actionTime;
        self.oZDRatio = ZDRatio;
        self.oHarmnonicRatio = harmnonicRatio;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialTestResult *copy = [[[self class]allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.oQdcurrent = self.oQdcurrent;
    copy.oActionTime = self.oActionTime;
    copy.oZDRatio = self.oZDRatio;
    copy.oHarmnonicRatio = self.oHarmnonicRatio;
    return copy;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialTestResult *copy = [[[self class]allocWithZone:zone]init];
    copy.itemType = self.itemType;
    copy.oQdcurrent = self.oQdcurrent;
    copy.oActionTime = self.oActionTime;
    copy.oZDRatio = self.oZDRatio;
    copy.oHarmnonicRatio = self.oHarmnonicRatio;
    return copy;
}

@end

