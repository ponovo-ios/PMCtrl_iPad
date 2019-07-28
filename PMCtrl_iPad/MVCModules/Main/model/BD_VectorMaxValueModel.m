//
//  BD_VectorMaxValueModel.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VectorMaxValueModel.h"

@implementation BD_VectorMaxValueModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.U_Max = 300.00;
        self.I_Max = 30.000;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_VectorMaxValueModel *model = [[[self class]allocWithZone:zone] init];
    model.U_Max = self.U_Max;
    model.I_Max = self.I_Max;
    return model;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_VectorMaxValueModel *model = [[[self class]allocWithZone:zone] init];
    model.U_Max = self.U_Max;
    model.I_Max = self.I_Max;
    return model;
}
@end
