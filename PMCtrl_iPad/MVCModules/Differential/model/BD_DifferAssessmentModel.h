//
//  BD_DifferHarmRateTestAssessmentModel.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_DifferAssessmentModel : NSObject<NSMutableCopying,NSCopying>
@property(nonatomic,assign)CGFloat commonErrorValue;
@property(nonatomic,assign)BOOL isRelativeErrorSelect;
@property(nonatomic,assign)BOOL isAbsoluteErrorSelect;
@property(nonatomic,assign)CGFloat relativeErrorValue;
@property(nonatomic,assign)CGFloat absoluteErrorValue;
@property(nonatomic,assign)int errorLogic;//0--或 1-与
@property(nonatomic,strong)NSString *expression;
@property(nonatomic,assign)CGFloat IdValue;
@property(nonatomic,assign)CGFloat IrValue;
//比率制动系数：表示比率制动系数 谐波制动：表示谐波制动系数 动作时间：表示动作时间
@property(nonatomic,assign)CGFloat rateValue;
-(instancetype)initWithRelativeErrorSelect:(BOOL)isRelativeErrorSelect isAbsoluteErrorSelect:(BOOL)isAbsoluteErrorSelect relativeErrorValue:(CGFloat)relativeErrorValue absoluteErrorValue:(CGFloat)absoluteErrorValue expression:(NSString *)expression IdValue:(CGFloat)IdValue IrValue:(CGFloat)IrValue rateValue:(CGFloat)rateValue commonErrorValue:(CGFloat)commonErrorValue errorLogic:(int)errorLogic;
@end
