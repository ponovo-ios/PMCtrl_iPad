//
//  BD_DifferentialTestResult.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/6.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>




/**
 *  幅值  相位
 */
@interface BD_DifferentialChanel : NSObject<NSCopying,NSMutableCopying>

@property(nonatomic,assign)float famptitude;
@property(nonatomic,assign)float fphase;

-(instancetype)initWithfamptitude:(float)famptitude fphase:(float)fphase;

@end

/**
 *  6相电流
 */
@interface BD_DifferentialBasicResultItem : NSObject<NSCopying,NSMutableCopying>

@property(nonatomic,strong)BD_DifferentialChanel *Ia;
@property(nonatomic,strong)BD_DifferentialChanel *Ib;
@property(nonatomic,strong)BD_DifferentialChanel *Ic;
@property(nonatomic,strong)BD_DifferentialChanel *Iap;
@property(nonatomic,strong)BD_DifferentialChanel *Ibp;
@property(nonatomic,strong)BD_DifferentialChanel *Icp;
-(instancetype)initWithIa:(BD_DifferentialChanel *)Ia Ib:(BD_DifferentialChanel *)Ib Ic:(BD_DifferentialChanel *)Ic Iap:(BD_DifferentialChanel *)Iap Ibp:(BD_DifferentialChanel *)Ibp Icp:(BD_DifferentialChanel *)Icp;
@end


/**
 *  启动 速断 返回结果
 */
@interface BD_DifferentialTestItem_QDCurrent : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)DifferTestItemType itemType;//结果类型
@property(nonatomic,assign)int iIndex;
@property(nonatomic,strong)BD_DifferentialBasicResultItem *basic;//6相电流
@property(nonatomic,assign)float Id;//差动电流
@property(nonatomic,assign)bool bEnd;//是否是最后一个点 是 true 否 false
@property(nonatomic,assign)int nibinstate;//开入量
-(instancetype)initWithitemType:(DifferTestItemType)itemType iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic Id:(float)Id bEnd:(bool)bEnd nibinstate:(int)nibinstate;

@end
/**
 *  比率制动返回结果
 */
@interface BD_DifferentialTestItem_ZDRatio : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)DifferTestItemType itemType;//类型
@property(nonatomic,assign)int iTypeIndex;//区分比率制动1 1-2 2 2-2 3 3-2 值：1 2 3 4 5 6
@property(nonatomic,assign)int iIndex;
@property(nonatomic,strong)BD_DifferentialBasicResultItem *basic;//6相电流
@property(nonatomic,assign)float Id;//差动电流
@property(nonatomic,assign)bool bEnd;//是否是最后一个点 是 true 否 false
@property(nonatomic,assign)int nibinstate;//开入量
-(instancetype)initWithitemType:(DifferTestItemType)itemType iTypeIndex:(int)iTypeIndex iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic Id:(float)Id bEnd:(bool)bEnd nibinstate:(int)nibinstate;
@end
/**
 * 动作时间返回结果
 */
@interface BD_DifferentialTestItem_ActionTime  : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)DifferTestItemType itemType;//结果类型
@property(nonatomic,assign)int iIndex;
@property(nonatomic,strong)BD_DifferentialBasicResultItem *basic;//6相电流
@property(nonatomic,assign)float fId;//差动电流
@property(nonatomic,assign)float fTime;//动作时间
@property(nonatomic,assign)bool bEnd;//是否是最后一个点 是 true 否 false
@property(nonatomic,assign)int nibinstate;//开入量
-(instancetype)initWithitemType:(DifferTestItemType)itemType iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic  fId:(float)fId fTime:(float)fTime bEnd:(bool)bEnd nibinstate:(int)nibinstate;

@end

/**
 *  谐波制动返回结果
 */
@interface BD_DifferentialHarmonicRatio  : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)DifferTestItemType itemType;//结果类型
@property(nonatomic,assign)int iIndex;
@property(nonatomic,strong)BD_DifferentialBasicResultItem *basic;//6相电流
@property(nonatomic,assign)float Ir;//制动电流
@property(nonatomic,assign)float K;//制动系数
@property(nonatomic,assign)bool bEnd;//是否是最后一个点 是 true 否 false
@property(nonatomic,assign)int nibinstate;//开入量

-(instancetype)initWithitemType:(DifferTestItemType)itemType iIndex:(int)iIndex basic:(BD_DifferentialBasicResultItem *)basic Ir:(float)Ir K:(float)K bEnd:(bool)bEnd nibinstate:(int)nibinstate;

@end

/**
 *  差动测试结果
 */
@interface BD_DifferentialTestResult : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)DifferTestItemType itemType;
@property(nonatomic,strong)BD_DifferentialTestItem_QDCurrent *oQdcurrent;
@property(nonatomic,strong)BD_DifferentialTestItem_ActionTime *oActionTime;
@property(nonatomic,strong)BD_DifferentialTestItem_ZDRatio *oZDRatio;
@property(nonatomic,strong)BD_DifferentialHarmonicRatio *oHarmnonicRatio;

-(instancetype)initWithitemType:(DifferTestItemType)itemType QDCurrent:(BD_DifferentialTestItem_QDCurrent *)QDCurrent actionTime:(BD_DifferentialTestItem_ActionTime *)actionTime ZDRatio:(BD_DifferentialTestItem_ZDRatio *)ZDRatio harmnonicRatio:(BD_DifferentialHarmonicRatio *)harmnonicRatio;


@end
