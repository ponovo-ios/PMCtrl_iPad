
//
//  BD_StateTestTransmutationDetailModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/17.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestTransmutationDetailModel.h"

@implementation BD_StateTestTransmutationDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.paramType = @"0";
        self.dfdtValue = @0.000;
        self.dvdtValue = @0.000;
        self.startHzValue = @0.000;
        self.endHzValue = @0.000;
        self.startVValue = @0.000;
        self.endVValue = @0.000;
        self.changeStepValue = @0.000;
        self.stepTimeValue = @0.01;
        self.changeStartValue = @0.000;
        self.changeEndValue = @0.000;
    }
    return self;
}
-(instancetype)initWithParamType:(NSString *)paramType dfdtValue:(NSNumber *)dfdtValue dvdtValue:(NSNumber *)dvdtValue startHzValue:(NSNumber *)startHzValue endHzValue:(NSNumber *)endHzValue startVValue:(NSNumber *)startVValue endVValue:(NSNumber *)endVValue changeStepValue:(NSNumber *)changeStepValue stepTimeValue:(NSNumber *)stepTimeValue changeStartValue:(NSNumber *)changeStartValue changeEndValue:(NSNumber *)changeEndValue{
    if (self = [super init]) {
        self.paramType = paramType;
        self.dfdtValue = dfdtValue;
        self.dvdtValue = dvdtValue;
        self.startHzValue = startHzValue;
        self.endHzValue = endHzValue;
        self.startVValue = startVValue;
        self.endVValue = endVValue;
      
        self.changeStepValue = changeStepValue;
        self.stepTimeValue = stepTimeValue;
        self.changeStartValue = changeStartValue;
        self.changeEndValue = changeEndValue;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_StateTestTransmutationDetailModel *detail = [[[self class] allocWithZone:zone] init];
    detail.paramType = self.paramType;
    detail.dfdtValue = self.dfdtValue;
    detail.dvdtValue = self.dvdtValue;
    detail.startHzValue = self.startHzValue;
    detail.endHzValue = self.endHzValue;
    detail.startVValue = self.startVValue;
    detail.endVValue = self.endVValue;
  
    detail.changeStepValue = self.changeStepValue;
    detail.stepTimeValue = self.stepTimeValue;
    detail.changeStartValue = self.changeStartValue;
    detail.changeEndValue = self.changeEndValue;
    return detail;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_StateTestTransmutationDetailModel *detail = [[[self class] allocWithZone:zone] init];
    detail.paramType = self.paramType;
    detail.dfdtValue = self.dfdtValue;
    detail.dvdtValue = self.dvdtValue;
    detail.startHzValue = self.startHzValue;
    detail.endHzValue = self.endHzValue;
    detail.startVValue = self.startVValue;
    detail.endVValue = self.endVValue;
    detail.changeStepValue = self.changeStepValue;
    detail.stepTimeValue = self.stepTimeValue;
    detail.changeStartValue = self.changeStartValue;
    detail.changeEndValue = self.changeEndValue;
    return detail;
}
@end
