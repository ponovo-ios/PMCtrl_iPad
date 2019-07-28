//
//  BD_BinaryStateModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/24.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_BinaryStateModel.h"

@implementation BD_BinaryStateModel
-(instancetype)initWithBinaryName:(NSString *)binaryName binaryState:(BOOL)binaryState lengthData:(CGFloat)lengthData{
    self = [super init];
    if (self) {
        self.binaryName = binaryName;
        self.binaryState = binaryState;
        self.lengthData = lengthData;
    }
    return self;
}
@end


@implementation BD_BinaryStateViewModel

-(instancetype)initWithbinaryName:(NSString *)binaryName lineData:(NSMutableArray *)lineData{
    self = [super init];
    if (self) {
        self.binaryName = binaryName;
        self.lineData = lineData;
    }
    return self;
}

@end
