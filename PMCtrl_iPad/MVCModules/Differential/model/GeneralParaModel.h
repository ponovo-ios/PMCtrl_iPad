//
//  GeneralParaModel.h
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/7/31.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneralParaModel : NSObject<NSMutableCopying,NSCopying>

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * param;

- (NSString *)para;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
-(instancetype)initWithName:(NSString *)name param:(NSString *)param;

@end
