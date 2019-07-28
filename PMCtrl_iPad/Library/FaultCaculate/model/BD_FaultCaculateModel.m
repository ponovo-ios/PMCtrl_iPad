//
//  BD_FaultCaculateModel.m
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_FaultCaculateModel.h"

@implementation BD_FaultCaculateModel

@end

@implementation channel3U3I
-(instancetype)init{
    if (self = [super init]) {
        _fIa = 0;
        _fIb = 0;
        _fIc = 0;
        _fVa = 0;
        _fVb = 0;
        _fVc = 0;
        _fAngle_Va = 0;
        _fAngle_Vb = 0;
        _fAngle_Vc = 0;
        _fAngle_Ia = 0;
        _fAngle_Ib = 0;
        _fAngle_Ic = 0;
    }
    return self;
}
@end

@implementation BD_FaultCacuResultModel
-(instancetype)init{
    if (self = [super init ]) {
        _fDL_I = 0;
        _basic3U3I = [[channel3U3I alloc]init];
    }
    return self;
}
@end
