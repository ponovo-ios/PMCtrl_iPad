
//
//  BD_ReportInfoModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/24.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReportInfoModel.h"

@implementation BD_ReportInfoModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reportNum = @"1";
        self.reportTime = @"1970-01-01 0:00:00";
        self.reportResult = @"合格";
        self.url = @"";
    }
    return self;
}
@end
