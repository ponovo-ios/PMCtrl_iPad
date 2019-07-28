//
//  BD_TestDataParamModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestDataParamModel.h"


@implementation BD_TestDataParamModel

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

-(instancetype)init{
    if (self = [super init]) {
        self.titleName = @"Ua" ;
        self.phase = @"0.000";
        self.amplitude = @"0.000";
        self.frequency = @"0.000";
        self.unit = @"V";
        
    }
    return self;
}
-(instancetype)initWithtitleName:(NSString *)titleName frequency:(NSString *)frequency phase:(NSString *)phase amplitude:(NSString *)amplitude unit:(NSString *)unit{
    self = [super init];
    if (self) {
        self.titleName = titleName ;
        self.phase = phase;
        self.amplitude = amplitude;
        self.frequency = frequency;
        self.unit = unit;
    }
    return  self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    BD_TestDataParamModel *param = [[[self class] allocWithZone:zone] init];
    param.titleName = self.titleName;
    param.amplitude = self.amplitude;
    param.phase = self.phase;
    param.frequency = self.frequency;
    param.unit = self.unit;
    return param;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_TestDataParamModel *param = [[[self class] allocWithZone:zone] init];
    param.titleName = self.titleName;
    param.amplitude = self.amplitude;
    param.phase = self.phase;
    param.frequency = self.frequency;
    param.unit = self.unit;
    return param;
}

@end

