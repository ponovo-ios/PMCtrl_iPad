//
//  BD_StateTestTransmutationDetailModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/17.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_StateTestTransmutationDetailModel : NSObject<NSCopying,NSMutableCopying>
/**变量*/
@property(nonatomic,strong)NSString *paramType;
/**df／dt值*/
@property(nonatomic,strong)NSNumber *dfdtValue;
/**dv／dt值*/
@property(nonatomic,strong)NSNumber *dvdtValue;
/**起始频率*/
@property(nonatomic,strong)NSNumber *startHzValue;
/**终止频率*/
@property(nonatomic,strong)NSNumber *endHzValue;
/**起始电压*/
@property(nonatomic,strong)NSNumber *startVValue;
/**终止电压*/
@property(nonatomic,strong)NSNumber *endVValue;
///**触发电压*/
//@property(nonatomic,strong)NSNumber *trigerVValue;
/**变化步长*/
@property(nonatomic,strong)NSNumber *changeStepValue;
/**步长时间*/
@property(nonatomic,strong)NSNumber *stepTimeValue;
/**变化始值*/
@property(nonatomic,strong)NSNumber *changeStartValue;
/**变化终值*/
@property(nonatomic,strong)NSNumber *changeEndValue;

-(instancetype)initWithParamType:(NSString *)paramType dfdtValue:(NSNumber *)dfdtValue dvdtValue:(NSNumber *)dvdtValue startHzValue:(NSNumber *)startHzValue endHzValue:(NSNumber *)endHzValue startVValue:(NSNumber *)startVValue endVValue:(NSNumber *)endVValue  changeStepValue:(NSNumber *)changeStepValue stepTimeValue:(NSNumber *)stepTimeValue changeStartValue:(NSNumber *)changeStartValue changeEndValue:(NSNumber *)changeEndValue;
@end
