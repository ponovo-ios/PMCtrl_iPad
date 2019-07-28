//
//  BD_ChannelModel.m
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ChannelModel.h"

@implementation BD_ChannelModel

-(instancetype)init{
    if (self = [super init]) {
        _amplitude = 0.000;
        _phase = 0.000;
        _frequency = 0.000;
    }
    return self;
}
@end

@implementation BD_ChannelStrModel
-(instancetype)init{
    if (self = [super init]) {
        _amplitude = @"0.000";
        _phase = @"0.000";
    }
    return self;
}
@end
