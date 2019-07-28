//
//  BD_OutputwaveShapeDataModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_OutputwaveShapeDataModel.h"

@implementation BD_OutputwaveShapeDataModel
-(instancetype)initWithVoltageArr:(NSMutableArray *)voltageArr currentArr:(NSMutableArray *)currentArr{
    self = [self init];
    if (self) {
        self.voltageArr = voltageArr;
        self.currentArr = currentArr;
    }
    return self;
}
@end
