//
//  BD_FaultCaculateModel.h
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface channel3U3I:NSObject
@property(nonatomic,assign)float fIa;
@property(nonatomic,assign)float fIb;
@property(nonatomic,assign)float fIc;
@property(nonatomic,assign)float fVa;
@property(nonatomic,assign)float fVb;
@property(nonatomic,assign)float fVc;

@property(nonatomic,assign)float fAngle_Ia;
@property(nonatomic,assign)float fAngle_Ib;
@property(nonatomic,assign)float fAngle_Ic;
@property(nonatomic,assign)float fAngle_Va;
@property(nonatomic,assign)float fAngle_Vb;
@property(nonatomic,assign)float fAngle_Vc;

@end



@interface BD_FaultCaculateModel : NSObject
/**短路阻抗角*/
@property(nonatomic,assign)double fImpAngle;
/**转换后零序补偿系数（幅值）---通用参数*/
@property(nonatomic,assign)double fK0s;
/**转换后零序补偿系数（相位）---通用参数*/
@property(nonatomic,assign)double fK0sPhi;
/**!零序补偿系数计算方式  0-|K0|,,Phi(K0), 1-RERL,,XEXL, 2-|Z0/Z1|,,Phi(Z0/Z1)  默认为1*/
@property(nonatomic,assign)double fK0CalModel;
/**此系数只有工频变化量距离用到，其他是1*/
@property(nonatomic,assign)double fDZFactor;
/**!故障方向，0-反方向，1-正方向，默认为1*/
@property(nonatomic,assign)bool fFaultDir;
/**CT极性正方向: 0--指向线路, 1--指向母线，默认为0*/
@property(nonatomic,assign)bool fCTPoint;
/**!计算模式，过流、零序为3，距离、阻抗边界搜索为0，工频变化量距离根据故障方向而不同，为4（正方向）或5（反方向），默认为0*/
@property(nonatomic,assign)int fCalMode;
/**!故障类型，0-9分别为A相接地、B相接地、C相接地、AB短路、BC短路、CA短路、AB接地短路、BC接地短路、CA接地短路、三相短路*/
@property(nonatomic,assign)int fFaultType;
/**额定电压*/
@property(nonatomic,assign)double fVNom;
/**PT变比,一般情况传入1*/
@property(nonatomic,assign)float fVFactor;
/**CT变比一般情况传入1*/
@property(nonatomic,assign)float fIFactor;
/**短路电流*/
@property(nonatomic,assign)double fDL_I;
/**短路电压*/
@property(nonatomic,assign)double fDL_V;
/**首端阻抗值*/
@property(nonatomic,assign)double fHeadZ;
/**负荷电流*/
@property(nonatomic,assign)double m_fIfh;
/**负荷公角*/
@property(nonatomic,assign)double m_fPowerAngle;

@end

@interface BD_FaultCacuResultModel:NSObject
@property(nonatomic,assign)double fDL_I;
@property(nonatomic,strong)channel3U3I *basic3U3I;
@end
