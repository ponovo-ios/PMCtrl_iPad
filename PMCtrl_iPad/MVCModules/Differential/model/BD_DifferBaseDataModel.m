//
//  BD_DifferBaseDataModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/16.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferBaseDataModel.h"

@implementation BD_DifferBaseDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.m_QDIr = 0;
        self.m_ZD1Ir = 0;
        self.m_ZD1_2Ir = 0;
        self.m_ZD2Ir = 0;
        self.m_ZD2_2Ir = 0;
        self.m_ZD3Ir = 0;
        self.m_ZD3_2Ir = 0;
        self.m_ZD4Ir = 0;
        self.m_ZD4_2Ir = 0;
        self.m_SDIr = 0;
        self.m_HarmId = 0;
        self.m_ActionIr = 0;
        self.m_ActionId = 0;
        self.testPhasorType = @"A";
        self.frequency = 0;
        self.testAccuracy = 0;
    }
    return self;
}

@end
