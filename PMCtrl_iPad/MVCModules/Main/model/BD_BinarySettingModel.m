//
//  BD_BinarySettingModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_BinarySettingModel.h"

@implementation BD_BinarySettingModel
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
    BD_BinarySettingModel *binary = [[[self class]allocWithZone:zone]init];
    binary.title = self.title;
    binary.isBlankNode = self.isBlankNode;
    binary.rolloverValue = self.rolloverValue;
    return binary;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_BinarySettingModel *binary = [[[self class]allocWithZone:zone]init];
    binary.title = self.title;
    binary.isBlankNode = self.isBlankNode;
    binary.rolloverValue = self.rolloverValue;
    return binary;
}
@end

