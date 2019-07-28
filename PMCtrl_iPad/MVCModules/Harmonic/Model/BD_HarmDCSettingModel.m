//
//  BD_HarmDCSettingModel.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDCSettingModel.h"

@implementation BD_HarmDCSettingModel

-(instancetype)init
{
    if (self = [super init]) {
        _type = BDDeviceType_Imitate;
        _ua = @"0.000";
        _ub = @"0.000";
        _uc = @"0.000";
        _uz = @"0.000";
        _ua2 = @"0.000";
        _ub2 = @"0.000";
        _uc2 = @"0.000";
        _ia = @"0.000";
        _ib = @"0.000";
        _ic = @"0.000";
        _ia2 = @"0.000";
        _ib2 = @"0.000";
        _ic2 = @"0.000";
    }
    return self;
}

//清空数据
-(void)clearData
{
    self.ua = @"0.000";
    self.ub = @"0.000";
    self.uc = @"0.000";
    self.uz = @"0.000";
    self.ua2 = @"0.000";
    self.ub2 = @"0.000";
    self.uc2 = @"0.000";
    self.ia = @"0.000";
    self.ib = @"0.000";
    self.ic = @"0.000";
    self.ia2 = @"0.000";
    self.ib2 = @"0.000";
    self.ic2 = @"0.000";
}

-(id)copyWithZone:(NSZone *)zone{
    BD_HarmDCSettingModel *model = [[[self class]allocWithZone:zone]init];
    model.ua = self.ua;
    model.ub = self.ub;
    model.uc = self.uc;
    model.uz = self.uz;
    model.ua2 = self.ua2;
    model.ub2 = self.ub2;
    model.uc2 = self.uc2;
    model.ia = self.ia;
    model.ib = self.ib;
    model.ic = self.ic;
    model.ia2 = self.ia2;
    model.ib2 = self.ib2;
    model.ic2 = self.ic2;
    return model;
    
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_HarmDCSettingModel *model = [[[self class]allocWithZone:zone]init];
    model.ua = self.ua;
    model.ub = self.ub;
    model.uc = self.uc;
    model.uz = self.uz;
    model.ua2 = self.ua2;
    model.ub2 = self.ub2;
    model.uc2 = self.uc2;
    model.ia = self.ia;
    model.ib = self.ib;
    model.ic = self.ic;
    model.ia2 = self.ia2;
    model.ib2 = self.ib2;
    model.ic2 = self.ic2;
    return model;
}
@end
