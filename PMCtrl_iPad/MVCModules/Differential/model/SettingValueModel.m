//
//  SettingValueModel.m
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/7/28.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "SettingValueModel.h"

@implementation SettingValueModel

- (NSString *)val{
    return _val;
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


-(instancetype)initWithName:(NSString *)name val:(NSString *)val{
    self = [super init];
    if (self) {
        self.name = name;
        self.val = val;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    SettingValueModel *model = [[[self class] allocWithZone:zone]init];
    model.name = self.name;
    model.val = self.val;
    return model;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    SettingValueModel *model = [[[self class] allocWithZone:zone]init];
    model.name = self.name;
    model.val = self.val;
    return model;
}
@end
