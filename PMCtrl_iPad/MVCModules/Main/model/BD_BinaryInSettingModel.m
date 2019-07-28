//
//  BD_BinaryInSettingModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_BinaryInSettingModel.h"

@implementation BD_BinaryInSettingModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.isBlankNode =YES;
        self.rolloverValue = @"40.000";
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_BinaryInSettingModel *binary = [[[self class]allocWithZone:zone]init];
    binary.title = self.title;
    binary.isBlankNode = self.isBlankNode;
    binary.rolloverValue = self.rolloverValue;
    return binary;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_BinaryInSettingModel *binary = [[[self class]allocWithZone:zone]init];
    binary.title = self.title;
    binary.isBlankNode = self.isBlankNode;
    binary.rolloverValue = self.rolloverValue;
    return binary;
}
@end

@implementation BD_BinaryInSetData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.binaryStyle = 0;
        self.binaryInfoList = [[NSMutableArray alloc]init];
        self.bitime = 0;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_BinaryInSetData *model = [[[self class]allocWithZone:zone]init];
    model.binaryStyle = self.binaryStyle;
    model.binaryInfoList = self.binaryInfoList;
    model.bitime = self.bitime;
    return model;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_BinaryInSetData *model = [[[self class]allocWithZone:zone]init];
    model.binaryStyle = self.binaryStyle;
    model.binaryInfoList = self.binaryInfoList;
    model.bitime = self.bitime;
    return model;
}
@end

