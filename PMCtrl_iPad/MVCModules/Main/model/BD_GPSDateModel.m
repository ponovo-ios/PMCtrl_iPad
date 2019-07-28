

//
//  BD_GPSDateModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/19.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_GPSDateModel.h"

@implementation BD_GPSDateModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nSecond = 0;
        self.nNanoSec = 0;
    }
    return self;
}
@end
