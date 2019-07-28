//
//  BD_DifferentialTestItemModel.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/20.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_DifferAssessmentModel.h"

@interface BD_DifferentialTestItemParaModel:NSObject<NSMutableCopying,NSCopying>

@property(nonatomic,strong)NSString *itemName;
@property (nonatomic,assign)DifferTestItemType itemType; //测试类型
@property (nonatomic,strong)NSString  *iTypeIndex;//区分比率制动
@property (nonatomic,strong)NSString *iIndex;//编号
@property (nonatomic,strong)NSString *Ir;//制动电流
@property (nonatomic,strong)NSString *fUp;//搜索上限
@property (nonatomic,strong)NSString *fDown;//搜索下限
@property (nonatomic,strong)NSString *testPhasorType;//测试项
@property (nonatomic,strong)NSString *frequency;//频率
@property (nonatomic,strong)NSString *testAccuracy;//测试精度

@property (nonatomic,strong)NSString *Id;//差动电流
@property (nonatomic,strong)NSString *nHarm;//谐波次数
@property (nonatomic,strong)NSString *searchStart;//搜索始值
@property (nonatomic,strong)NSString *searchEnd;//搜索终值

-(instancetype)initWithitemName:(NSString *)itemName itemType:(DifferTestItemType)itemType iTypeIndex:( NSString *)iTypeIndex iIndex:( NSString *)iIndex Ir:( NSString *)Ir fUp:(NSString *)fUp fDown:( NSString *)fDown testPhasorType:( NSString *)testPhasorType frequency:( NSString *)frequency testAccuracy:( NSString *)testAccuracy nHarm:( NSString *)nHarm Id:( NSString *)Id searchStart:( NSString *)searchStart searchEnd:( NSString *)searchEnd;
@end


@interface BD_DifferentialTestItemModel : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)NSInteger itemNum;
@property(nonatomic,strong)NSString *itemName;
@property(nonatomic,assign)BOOL itemSelect;
@property(nonatomic,strong)NSString *itemResult;
@property(nonatomic,strong)BD_DifferentialTestItemParaModel *testItemParam;
@property(nonatomic,strong)BD_DifferAssessmentModel *testItemAssessment;
-(instancetype)initWithItemNum:(NSInteger)itemNum itemName:(NSString *)itemName itemSelect:(BOOL)itemSelect itemResult:(NSString *)itemResult testItemParam:(BD_DifferentialTestItemParaModel *)testItemParam testItemAssessment:(BD_DifferAssessmentModel *)testItemAssessment;
@end


