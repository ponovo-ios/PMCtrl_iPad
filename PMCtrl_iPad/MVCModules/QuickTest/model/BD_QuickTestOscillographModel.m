//
//  BD_QuickTestOscillographModel.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2017/10/22.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestOscillographModel.h"

@implementation BD_QuickTestOscillographModel_Base

-(instancetype)initWithTitle:(NSString *)title model:(NSMutableArray *)model{
    self = [super init];
    if (self) {
        self.title = title;
        self.model = model;
    }
    return self;
}
@end
@implementation BD_QuickTestOscillographModel

-(instancetype)initWithVAmplitudeArr:(NSMutableArray *)VAmplitudeArr CAmplitudeArr:(NSMutableArray *)CAmplitudeArr{
    self = [super init];
    if (self) {
       
        self.CAmplitudeArr = CAmplitudeArr;
        self.VAmplitudeArr = VAmplitudeArr;
    }
    return self;
}
@end
