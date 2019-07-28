//
//  BD_DevicePassagewayModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/21.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_DevicePassagewayModel.h"

@implementation BD_DevicePassagewayModel
-(instancetype)initWithpassagewayNum:(NSString *)passagewayNum passagewayName:(NSString *)passagewayName{
    self = [super init];
    if (self) {
        self.passagewayNum = passagewayNum;
        self.passagewayName = passagewayName;
    }
    return self;
}
@end
