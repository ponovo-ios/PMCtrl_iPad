//
//  BD_TestDataParamModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BD_TestDataParamModel : NSObject<NSCopying,NSMutableCopying>
/** 名称：Va Vb Vc Ia Ib Ic */
@property (nonatomic,strong)NSString *titleName;
/**幅值*/
@property (nonatomic,strong)NSString *amplitude;
/**相位*/
@property (nonatomic,strong)NSString *phase;
/**频率*/
@property (nonatomic,strong)NSString *frequency;
/**单位*/
@property (nonatomic,strong)NSString *unit;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
-(instancetype)initWithtitleName:(NSString *)titleName frequency:(NSString *)frequency phase:(NSString *)phase amplitude:(NSString *)amplitude unit:(NSString *)unit;

@end
