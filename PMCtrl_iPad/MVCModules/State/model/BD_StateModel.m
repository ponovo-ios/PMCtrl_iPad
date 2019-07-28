//
//  BD_StateModel.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/9.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateModel.h"

@implementation BD_StateModel
-(instancetype)initWithnindex:(int)nindex secondtime:(int)secondtime nstime:(int)nstime oactivetype:(int)oactivetype nBinstate:(int)nBinstate ncurrentstateIndex:(int)ncurrentstateIndex{
    self = [super init];
    if (self) {
        self.nindex = nindex;
        self.secondtime = secondtime;
        self.nstime = nstime;
        self.oactivetype = oactivetype;
        self.nBinstate = nBinstate;
        self.ncurrentstateIndex = ncurrentstateIndex;
    }
    return self;
}
@end
