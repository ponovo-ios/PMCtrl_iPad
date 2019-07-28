 //
//  GeneralParaModel.m
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/7/31.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "GeneralParaModel.h"

@implementation GeneralParaModel

- (NSString *)para{
    return _param;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithName:(NSString *)name param:(NSString *)param{
    self = [super init];
    if (self) {
        self.name  = name;
        self.param = param;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    GeneralParaModel *model = [[[self class] allocWithZone:zone]init];
    model.name = self.name;
    model.param = self.param;
    return model;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    GeneralParaModel *model = [[[self class] allocWithZone:zone]init];
    model.name = self.name;
    model.param = self.param;
    return model;
}
@end
