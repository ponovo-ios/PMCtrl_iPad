//
//  BD_DifferHarmRateTestAssessmentModel.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferAssessmentModel.h"

@implementation BD_DifferAssessmentModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isRelativeErrorSelect=NO;
        self.isAbsoluteErrorSelect=NO;
        self.relativeErrorValue=0.000;
        self.absoluteErrorValue=0.000;
        self.expression=@"";
        self.IdValue=0.000;
        self.IrValue=0.000;
        self.rateValue=0.000;
        self.commonErrorValue = 5.000;
        self.errorLogic = 0;
    }
    return self;
}
-(instancetype)initWithRelativeErrorSelect:(BOOL)isRelativeErrorSelect isAbsoluteErrorSelect:(BOOL)isAbsoluteErrorSelect relativeErrorValue:(CGFloat)relativeErrorValue absoluteErrorValue:(CGFloat)absoluteErrorValue expression:(NSString *)expression IdValue:(CGFloat)IdValue IrValue:(CGFloat)IrValue rateValue:(CGFloat)rateValue commonErrorValue:(CGFloat)commonErrorValue errorLogic:(int)errorLogic{
    self = [super init];
    if (self) {
        self.isRelativeErrorSelect=isRelativeErrorSelect;
        self.isAbsoluteErrorSelect=isAbsoluteErrorSelect;
        self.relativeErrorValue=relativeErrorValue;
        self.absoluteErrorValue=absoluteErrorValue;
        self.expression=expression;
        self.IdValue=IdValue;
        self.IrValue=IrValue;
        self.rateValue=rateValue;
        self.commonErrorValue = commonErrorValue;
        self.errorLogic = errorLogic;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_DifferAssessmentModel *copy = [[[self class]allocWithZone:zone]init];
    copy.isRelativeErrorSelect=self.isRelativeErrorSelect;
    copy.isAbsoluteErrorSelect=self.isAbsoluteErrorSelect;
    copy.relativeErrorValue=self.relativeErrorValue;
    copy.absoluteErrorValue=self.absoluteErrorValue;
    copy.expression=self.expression;
    copy.IdValue=self.IdValue;
    copy.IrValue=self.IrValue;
    copy.rateValue=self.rateValue;
    copy.commonErrorValue = self.commonErrorValue;
    copy.errorLogic = self.errorLogic;
    return copy;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferAssessmentModel *copy = [[[self class]allocWithZone:zone]init];
    copy.isRelativeErrorSelect=self.isRelativeErrorSelect;
    copy.isAbsoluteErrorSelect=self.isAbsoluteErrorSelect;
    copy.relativeErrorValue=self.relativeErrorValue;
    copy.absoluteErrorValue=self.absoluteErrorValue;
    copy.expression=self.expression;
    copy.IdValue=self.IdValue;
    copy.IrValue=self.IrValue;
    copy.rateValue=self.rateValue;
    copy.commonErrorValue = self.commonErrorValue;
    copy.errorLogic = self.errorLogic;
    return copy;
}
@end
