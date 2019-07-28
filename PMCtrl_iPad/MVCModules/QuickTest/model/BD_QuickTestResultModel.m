//
//  BD_QuickTestResultModel.m
//  PMCtrl_iOS
//
//  Created by 张姝枫 on 2017/9/27.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_QuickTestResultModel.h"
#import "objc/runtime.h"

@implementation BD_QuickTestResultModel
-(instancetype)initWithnindex:(int)nindex oactivetype:(int)oactivetype nBinstate:(int)nBinstate nbinall:(int)nbinall time:(BD_UtcTime *)time{
    self = [super init];
    if (self) {
        self.nindex = nindex;
        self.oactivetype = oactivetype;
        self.nBinstate = nBinstate;
        self.nbinall = nbinall;
        self.time = time;
    }
    return self;
}

-(NSString *)description{
     return [NSString stringWithFormat:@"<%@,%p,%@>",[self class],self,@{@"index":@(_nindex),@"index":@(_nindex),@"index":@(_nindex)}];
}
-(NSString *)debugDescription{
    return [NSString stringWithFormat:@"<%@,%p,%@>",[self class],self,@{@"index":@(_nindex),@"index":@(_nindex),@"index":@(_nindex)}];
}
@end



@implementation BD_BeginTestModel

-(instancetype)initWithBegin:(bool)isBegin{
    self = [super init];
    if (self) {
        self.isBegin = isBegin;
    }
    return self;
}


////遍历获取所有的成员变量IvarList
//- (void) getAllIvarList {
//    unsigned int methodCount = 0;
//    Ivar * ivars = class_copyIvarList([self class], &methodCount);
//    for (unsigned int i = 0; i < methodCount; i ++) {
//        Ivar ivar = ivars[i];
//        const char * name = ivar_getName(ivar);
//        const char * type = ivar_getTypeEncoding(ivar);
//        NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
//    }
//    free(ivars);
//}


@end
