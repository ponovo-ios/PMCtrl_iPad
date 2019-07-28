//
//  BD_SMVDetailSettingWeakSignalMapModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SMVDetailSettingWeakSignalMapModel.h"

@implementation BD_SMVDetailSettingWeakSignalMapModel_passageWay
-(instancetype)initWithLeftPassageway:(NSString *)leftPassageway rightPassageway:(NSString *)rightPassageway{
    if (self = [super init]) {
        self.leftPassageway = leftPassageway;
        self.rightPassageway = rightPassageway;
    }
    return self;
}
@end 
@implementation BD_SMVDetailSettingWeakSignalMapModel
-(instancetype)initWithWeakSingalMap:(BOOL)isWeakSigalMap weakpassageWays:(NSMutableArray<BD_SMVDetailSettingWeakSignalMapModel_passageWay *> *)weakpassageWays PTChangeValue1:(NSString *)PTChangeValue1 PTChangeValue2:(NSString *)PTChangeValue2 CTChangeValue1:(NSString *)CTChangeValue1 CTChangeValue2:(NSString *)CTChangeValue2{
    if (self = [super init]) {
        self.isWeakSigalMap = isWeakSigalMap;
        self.weakpassageWays = weakpassageWays;
        self.PTChangeValue1 = PTChangeValue1;
        self.PTChangeValue2 = PTChangeValue2;
        self.CTChangeValue1 = CTChangeValue1;
        self.CTChangeValue2 = CTChangeValue2;
    }
    return self;
}
@end
