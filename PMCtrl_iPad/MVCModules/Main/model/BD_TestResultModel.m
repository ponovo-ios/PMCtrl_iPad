//
//  BD_TestResultModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/22.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestResultModel.h"


@implementation BD_ReultInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _binaryData = 0;
        _actionTime = 0.000;
        _actionValue = 0.000;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_ReultInfo *info = [[[self class]allocWithZone:zone] init];
    info.binaryData = self.binaryData;
    info.actionTime = self.actionTime;
    info.actionValue = self.actionValue;
    return info;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_ReultInfo *info = [[[self class]allocWithZone:zone] init];
    info.binaryData = self.binaryData;
    info.actionTime = self.actionTime;
    info.actionValue = self.actionValue;
    return info;
}
@end



@implementation BD_TestResultData
- (instancetype)init
{
    self = [super init];
    if (self) {
        _actionInfoArr = [[NSMutableArray alloc]init];
        _isMark = NO;
        _returnTime = 0.000;
        _returnValue = 0.000;
    }
    return self;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_TestResultData *resultData = [[[self class]allocWithZone:zone] init];
    resultData.actionInfoArr = self.actionInfoArr;
    resultData.isMark = self.isMark;
    resultData.returnTime = self.returnTime;
    resultData.returnValue = self.returnValue;
    return resultData;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_TestResultData *resultData = [[[self class]allocWithZone:zone] init];
    resultData.actionInfoArr = self.actionInfoArr;
    resultData.isMark = self.isMark;
    resultData.returnTime = self.returnTime;
    resultData.returnValue = self.returnValue;
    return resultData;
}
@end

@implementation BD_TestResultModel

-(instancetype)initWithnType:(int)nType nSource:(int)nSource nSec:(int)nSec nNanoSec:(int)nNanoSec nInput:(int)nInput nGooseValue:(int)nGooseValue currentIndex:(int)currentIndex nObjective:(int)nObjective nStep:(int)nStep{
    if (self = [super init]) {
        self.nType = nType;
        self.nSource = nSource;
        self.nSec = nSec;
        self.nNanoSec = nNanoSec;
        self.nInput = nInput;
        self.nGooseValue = nGooseValue;
        self.currentIndex = currentIndex;
        self.nObjective = nObjective;
        self.nStep = nStep;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_TestResultModel *result = [[[self class]allocWithZone:zone]init];
    result.nType = self.nType;
    result.nSource = self.nSource;
    result.nSec = self.nSec;
    result.nNanoSec = self.nNanoSec;
    result.nInput = self.nInput;
    result.nGooseValue = self.nGooseValue;
    result.currentIndex = self.currentIndex;
    result.nObjective = self.nObjective;
    result.nStep = self.nStep;
    return result;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_TestResultModel *result = [[[self class]allocWithZone:zone]init];
    result.nType = self.nType;
    result.nSource = self.nSource;
    result.nSec = self.nSec;
    result.nNanoSec = self.nNanoSec;
    result.nInput = self.nInput;
    result.nGooseValue = self.nGooseValue;
    result.currentIndex = self.currentIndex;
    result.nObjective = self.nObjective;
    result.nStep = self.nStep;
    return result;
}
@end
