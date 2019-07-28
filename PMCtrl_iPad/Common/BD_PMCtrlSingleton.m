//
//  BD_PMCtrlSingleton.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/11.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_PMCtrlSingleton.h"
@implementation BD_PMCtrlSingleton
+(instancetype)shared{
    static BD_PMCtrlSingleton *instence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[BD_PMCtrlSingleton alloc]init];
    });
    return instence;
}

//
//-(int)breakPointCount{
//    if (!_breakPointCount) {
//        if ([[NSUserDefaults standardUserDefaults] integerForKey:BD_KneePointCount]) {
//            return (int)[[NSUserDefaults standardUserDefaults] integerForKey:BD_KneePointCount];
//        } else {
//            return 1;
//        }
//    }
//
//    return _breakPointCount;
//}

//-(BD_BeginTestModel *)StatebeginModel{
//    if (!_StatebeginModel) {
//        _StatebeginModel = [[BD_BeginTestModel alloc]initWithBegin:NO];
//    }
//    return _StatebeginModel;
//}
-(BDDeviceType)deviceType{
    if (!_deviceType) {
        _deviceType = BDDeviceType_Imitate;
    }
    return _deviceType;
}

//-(BOOL)quickTestisCocurrent{
//    if (!_quickTestisCocurrent) {
//        _quickTestisCocurrent = NO;
//    }
//    
//    return _quickTestisCocurrent;
//}
@end
