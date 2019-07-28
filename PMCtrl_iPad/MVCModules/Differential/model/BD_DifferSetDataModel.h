//
//  BD_DifferSetDataModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/13.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**差动模块--整定值*/
@interface BD_DifferSetDataModel : NSObject
@property(nonatomic,assign)NSInteger Axis;//定值整定方式
@property(nonatomic,assign)NSInteger Insel;//基准电流选择
@property(nonatomic,assign)CGFloat Inom;//基准电流
@property(nonatomic,assign)CGFloat Isd;//差动速断电流定值
@property(nonatomic,assign)CGFloat Icdqd;//差动动作电流门揽值
@property(nonatomic,assign)NSInteger KneePoint;//拐点个数
@property(nonatomic,assign)CGFloat Ip1;//比率制动特性拐点1电流
@property(nonatomic,assign)CGFloat Ip2;//比率制动特性拐点1电流
@property(nonatomic,assign)CGFloat Ip3;//比率制动特性拐点1电流
@property(nonatomic,assign)CGFloat Kid1;//启动电流斜率
@property(nonatomic,assign)CGFloat Kid2;//基波比率制动特性斜率1
@property(nonatomic,assign)CGFloat Kid3;//基波比率制动特性斜率1
@property(nonatomic,assign)CGFloat Kid4;//速断电流斜率
@property(nonatomic,assign)CGFloat Kxb2;//二次谐波制动系数
@property(nonatomic,assign)CGFloat Kxb3;//二次谐波制动系数
@property(nonatomic,assign)CGFloat Kxb5;//5次谐波制动系数
@end
