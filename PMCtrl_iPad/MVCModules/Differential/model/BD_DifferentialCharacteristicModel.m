//
//  BD_DifferentialCharacteristicModel.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/6.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_DifferentialCharacteristicModel.h"

@implementation BD_DifferentialCharacteristicModel

-(instancetype)initWithThresholdLevel:(float)thresholdLevel SDCurrentLevel:(float)SDCurrentLevel breakPoint1_current:(float)breakPoint1_current breakPoint2_current:(float)breakPoint2_current breakPoint3_current:(float)breakPoint3_current rateSlope1:(float)rateSlope1 rateSlope2:(float)rateSlope2 rateSlope3:(float)rateSlope3 rateSlope4:(float)rateSlope4 QDCurrentId:(float)QDCurrentId RateSlope1Id1:(float)RateSlope1Id1 RateSlope1Id2:(float)RateSlope1Id2 RateSlope2Id1:(float)RateSlope2Id1 RateSlope2Id2:(float)RateSlope2Id2 SDCurrentId:(float)SDCurrentId{
    self = [super init];
    if (self) {
        self.thresholdLevel = thresholdLevel;
        self.SDCurrentLevel = SDCurrentLevel;
        self.breakPoint1_current = breakPoint1_current;
        self.breakPoint2_current = breakPoint2_current;
        self.breakPoint3_current = breakPoint3_current;
        self.rateSlope1 = rateSlope1;
        self.rateSlope2 = rateSlope2;
        self.rateSlope3 = rateSlope3;
        self.rateSlope4 = rateSlope4;
        self.QDCurrentId = QDCurrentId;
        self.RateSlope1Id1 = RateSlope1Id1;
        self.RateSlope1Id2 = RateSlope1Id2;
        self.RateSlope2Id1 = RateSlope2Id1;
        self.RateSlope2Id2 = RateSlope2Id2;
        self.SDCurrentId = SDCurrentId;
    
    }
    return self;
}
@end
