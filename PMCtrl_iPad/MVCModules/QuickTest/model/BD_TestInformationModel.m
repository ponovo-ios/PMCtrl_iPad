//
//  BD_TestInformationModel.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestInformationModel.h"

@implementation BD_TestInformationModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _infoindex  = 0;
        _currentTime = @"";
        _actionType = BDActionType_Default;
        _binaryIn = @"";
        _actionTime = @"";
        _stateIndex = 0;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_TestInformationModel *model = [[[self class] allocWithZone:zone]init];
    model.infoindex = self.infoindex;
    model.currentTime = self.currentTime;
    model.actionType = self.actionType;
    model.binaryIn = self.binaryIn;
    model.actionTime = self.actionTime;
    model.stateIndex = self.stateIndex;
    return model;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_TestInformationModel *model = [[[self class] allocWithZone:zone] init];
    model.infoindex = self.infoindex;
    model.currentTime = self.currentTime;
    model.actionType = self.actionType;
    model.binaryIn = self.binaryIn;
    model.actionTime = self.actionTime;
    model.stateIndex = self.stateIndex;
    return model;
}

@end
