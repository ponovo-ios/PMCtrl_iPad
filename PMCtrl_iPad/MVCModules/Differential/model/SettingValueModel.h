//
//  SettingValueModel.h
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/7/28.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingValueModel : NSObject<NSMutableCopying,NSCopying>

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * val;

- (NSString *)val;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
-(instancetype)initWithName:(NSString *)name val:(NSString *)val;
@end
