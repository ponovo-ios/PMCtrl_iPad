//
//  BD_QuickTestIECParamModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_QuickTestIECParamModel : NSObject
/** 额定线电压 */
@property(nonatomic,strong)NSString *ratedVoltage;
/** 额定频率 */
@property(nonatomic,strong)NSString *ratedFrequency;
/** 额定电流 */
@property(nonatomic,strong)NSString *ratedCurrent;
/** 开入防抖时间 */
@property(nonatomic,strong)NSString *BinaryTime;
/** 输出选择 */
@property(nonatomic,strong)NSString *sendOutSelected;
/** 弱信号输出设置 */
@property(nonatomic,strong)NSString *weakSignal;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
-(instancetype)initWithratedVoltage:(NSString *)ratedVoltage ratedFrequency:(NSString *)ratedFrequency ratedCurrent:(NSString *)ratedCurrent BinaryTime:(NSString *)BinaryTime sendOutSelected:(NSString *)sendOutSelected weakSignal:(NSString *)weakSignal;
@end

/**变比设置中模型*/
@interface BD_QuickTestIECParam_ChangeRateModel : NSObject
/** PT变化第一个参数 单位kV */
@property(nonatomic,assign)float PT1;
/** PT变化第二个参数 单位V */
@property(nonatomic,assign)float PT2;
/** CT变化第二个参数 单位V */
@property(nonatomic,assign)float CT1;
/** CT变化第二个参数 单位V */
@property(nonatomic,assign)float CT2;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
-(instancetype)initWithPT1:(float)pt1 PT2:(float)pt2 CT1:(float)ct1 CT2:(float)ct2;
@end
