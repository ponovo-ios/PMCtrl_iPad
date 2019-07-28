//
//  BD_DifferentialTestItemModel.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/20.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_DifferentialTestItemModel.h"
@implementation BD_DifferentialTestItemParaModel

-(instancetype)initWithitemName:(NSString *)itemName  itemType:(DifferTestItemType)itemType iTypeIndex:( NSString *)iTypeIndex iIndex:( NSString *)iIndex Ir:( NSString *)Ir fUp:(NSString *)fUp fDown:( NSString *)fDown testPhasorType:( NSString *)testPhasorType frequency:( NSString *)frequency testAccuracy:( NSString *)testAccuracy nHarm:( NSString *)nHarm Id:( NSString *)Id searchStart:( NSString *)searchStart searchEnd:( NSString *)searchEnd{
    self = [super init];
    if (self) {
        self.itemName = itemName;
        self.itemType = itemType;
        self.iTypeIndex = iTypeIndex;
        self.iIndex = iIndex;
        self.Ir  = Ir;
        self.fUp = fUp;
        self.fDown = fDown;
        self.testPhasorType = testPhasorType;
        self.frequency = frequency;
        self.testAccuracy = testAccuracy;
        self.Id = Id;
        self.nHarm = nHarm;
        self.searchStart = searchStart;
        self.searchEnd = searchEnd;
    
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemName = @"";
        self.itemType =DifferTestItemType_QDCurrent ;
        self.iTypeIndex = @"";
        self.iIndex = @"";
        self.Ir  = @"";
        self.fUp = @"";
        self.fDown = @"";
        self.testPhasorType = @"";
        self.frequency = @"";
        self.testAccuracy = @"";
        self.Id = @"";
        self.nHarm = @"";
        self.searchStart = @"";
        self.searchEnd = @"";
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialTestItemParaModel *model = [[[self class]allocWithZone:zone]init];
    model.itemName = self.itemName;
    model.itemType = self.itemType ;
    model.iTypeIndex = self.iTypeIndex;
    model.iIndex = self.iIndex;
    model.Ir  = self.Ir;
    model.fUp = self.fUp;
    model.fDown = self.fDown;
    model.testPhasorType = self.testPhasorType;
    model.frequency = self.frequency;
    model.testAccuracy = self.testAccuracy;
    model.Id = self.Id;
    model.nHarm = self.nHarm;
    model.searchStart = self.searchStart;
    model.searchEnd = self.searchEnd;
    return model;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialTestItemParaModel *model = [[[self class]allocWithZone:zone]init];
    model.itemName = self.itemName;
    model.itemType = self.itemType ;
    model.iTypeIndex = self.iTypeIndex;
    model.iIndex = self.iIndex;
    model.Ir  = self.Ir;
    model.fUp = self.fUp;
    model.fDown = self.fDown;
    model.testPhasorType = self.testPhasorType;
    model.frequency = self.frequency;
    model.testAccuracy = self.testAccuracy;
    model.Id = self.Id;
    model.nHarm = self.nHarm;
    model.searchStart = self.searchStart;
    model.searchEnd = self.searchEnd;
    return model;
}
@end

@implementation BD_DifferentialTestItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemNum = 0;
        _itemName = @"";
        _itemSelect = YES;
        _itemResult = @"";
        _testItemParam = [[BD_DifferentialTestItemParaModel alloc]init];
        _testItemAssessment = [[BD_DifferAssessmentModel alloc]init];
    }
    return self;
}

-(instancetype)initWithItemNum:(NSInteger)itemNum itemName:(NSString *)itemName itemSelect:(BOOL)itemSelect itemResult:(NSString *)itemResult testItemParam:(BD_DifferentialTestItemParaModel *)testItemParam testItemAssessment:(BD_DifferAssessmentModel *)testItemAssessment{
    if (self = [super init]) {
        self.itemNum = itemNum;
        self.itemName = itemName;
        self.itemSelect = itemSelect;
        self.itemResult = itemResult;
        self.testItemParam = testItemParam;
        self.testItemAssessment = testItemAssessment;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone{
    BD_DifferentialTestItemModel *copy = [[[self class]allocWithZone:zone]init];
    copy.itemNum = self.itemNum;
    copy.itemName = self.itemName;
    copy.itemSelect = self.itemSelect;
    copy.itemResult = self.itemResult;
    copy.testItemParam = [self.testItemParam copy];
    copy.testItemAssessment = [self.testItemAssessment copy];
    
    return copy;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    BD_DifferentialTestItemModel *copy = [[[self class]allocWithZone:zone]init];
    copy.itemNum = self.itemNum;
    copy.itemName = self.itemName;
    copy.itemSelect = self.itemSelect;
    copy.itemResult = self.itemResult;
    copy.testItemParam = [self.testItemParam copy];
    copy.testItemAssessment = [self.testItemAssessment copy];
    return copy;
}
@end

