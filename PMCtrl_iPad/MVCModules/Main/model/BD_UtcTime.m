//
//  BD_UtcTime.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/27.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_UtcTime.h"

@implementation BD_UtcTime
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.year = 0;
        self.month= 0;
        self.day= 0;
        self.hour= 0;
        self.minute= 0;
        self.second= 0;
        self.millisecond= 0;
    }
    return self;
}
@end
