//
//  BD_QuickTestIECParamModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestIECParamModel.h"

@implementation BD_QuickTestIECParamModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithratedVoltage:(NSString *)ratedVoltage ratedFrequency:(NSString *)ratedFrequency ratedCurrent:(NSString *)ratedCurrent BinaryTime:(NSString *)BinaryTime sendOutSelected:(NSString *)sendOutSelected weakSignal:(NSString *)weakSignal{
    self = [super init];
    if (self) {
        self.ratedVoltage = ratedVoltage;
        self.ratedCurrent = ratedCurrent;
        self.ratedFrequency = ratedFrequency;
        self.BinaryTime = BinaryTime;
        self.sendOutSelected = sendOutSelected;
        self.weakSignal = weakSignal;
    }
    return  self;
}

@end


@implementation BD_QuickTestIECParam_ChangeRateModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithPT1:(float)pt1 PT2:(float)pt2 CT1:(float)ct1 CT2:(float)ct2{
    self = [super init];
    if (self) {
        self.PT1 = pt1;
        self.PT2 = pt2;
        self.CT1 = ct1;
        self.CT2 = ct2;
    }
    return self;
}

@end
