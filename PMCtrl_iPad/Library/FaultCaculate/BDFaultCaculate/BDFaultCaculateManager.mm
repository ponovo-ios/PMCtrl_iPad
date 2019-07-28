//
//  BDFaultCaculateLib.m
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/28.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BDFaultCaculateManager.h"
#import "BD_FaultCaculateModel.h"
#import "Complexp.h"
#import "FaultCalculat.h"
@implementation BDFaultCaculateManager

-(BD_FaultCacuResultModel *)caculateFaultDataWithTestData:(BD_FaultCaculateModel *)data{
    //计算Va Vb Vc
    CFaultCalculat FaultCalculat;
    Complex Comp1;

    double m_fImpAngle = data.fImpAngle;     //!短路阻抗角
    double m_fK0s = data.fK0s;       //!转换后零序补偿系数
    double m_fK0sPh = data.fK0sPhi;        //!转换后零序补偿系数
    int    m_nK0CalMode = data.fK0CalModel;   //!零序补偿系数计算方式  0-|K0|,,Phi(K0), 1-RERL,,XEXL, 2-|Z0/Z1|,,Phi(Z0/Z1)  默认为1
    Comp1 = FaultCalculat.GroundFactor(m_nK0CalMode,\
                                       m_fK0s,\
                                       m_fK0sPh,\
                                       m_fImpAngle);
    
    float m_fK0AmpCal=(float)Comp1.norm();
    float m_fK0AngleCal=(float)Comp1.arg();
    
    
    double m_fDZFactor  = data.fDZFactor;//!此系数只有工频变化量距离用到，其他是1
    bool   m_bFaultDir = data.fFaultDir;//data.iErrorDirc;     //!故障方向，0-反方向，1-正方向，默认为1
    bool   m_bCTPoint = data.fCTPoint;     //!CT极性正方向: 0--指向线路, 1--指向母线，默认为0
    int    m_nCalMode = data.fCalMode;     //!计算模式，过流、零序为3，距离、阻抗边界搜索为0，工频变化量距离根据故障方向而不同，为4（正方向）或5（反方向），默认为0
    int    m_nFaultType = data.fFaultType; //!故障类型，0-9分别为A相接地、B相接地、C相接地、AB短路、BC短路、CA短路、AB接地短路、BC接地短路、CA接地短路、三相短路
    int nPhaseRef[11]={1,2,0,2,0,1,2,0,1,0,0};
    float nAngle[11] = {0,-120,120,30,-90,150,30,-90,150,0,120};
    double m_fVOutmax[4] = {300, 200, 150, 100};
    double m_fIOutmax[4] = {32, 20, 25, 26};
    double m_fVNom = data.fVNom;//GETCOMMON.EDV;            //!额定电压
    float fVFactor = data.fVFactor; //PT变比
    float fIFactor = data.fIFactor; //CT变比
    double fIt = data.fDL_I;
    double fVt = data.fDL_V;
    double m_fImpedance =data.fHeadZ;
    float  fValueFactor = 1.0f;//固定显示1，貌似之前的powtest中和界面上显示的是kw还是w有关
    Complex fUI[6];         //!定义Ua、Ub、Uc、Ia、Ib、Ic
    
    FaultCalculat.Calculat(m_fDZFactor, m_bFaultDir, m_bCTPoint, m_nCalMode, m_nFaultType,\
                           nPhaseRef[m_nFaultType],\
                           nAngle[nPhaseRef[m_nFaultType]],\
                           m_fVOutmax[0]/fVFactor,\
                           m_fVNom/fVFactor,\
                           m_fIOutmax[0]/fIFactor,\
                           &fIt, &fVt,\
                           Comp1.polar(0, 0),\
                           Comp1.polar(m_fImpedance/fVFactor/fValueFactor*fIFactor, m_fImpAngle),\
                           Comp1.polar(m_fK0AmpCal, m_fK0AngleCal),\
                           Comp1.polar(m_fImpedance/fVFactor/fValueFactor*fIFactor,m_fImpAngle),\
                            Comp1.polar(m_fK0s, m_fK0sPh),
                           &fUI[0],&fUI[1],&fUI[2],&fUI[3],&fUI[4],&fUI[5]);
    BD_FaultCacuResultModel *result  = [[BD_FaultCacuResultModel alloc]init];
    result.fDL_I = fIt;
    result.basic3U3I.fVa = fUI[0].norm();
    result.basic3U3I.fAngle_Va = fUI[0].arg();
    
    result.basic3U3I.fVb = fUI[1].norm();
    result.basic3U3I.fAngle_Vb = fUI[1].arg();
    
    result.basic3U3I.fVc = fUI[2].norm();
    result.basic3U3I.fAngle_Vc = fUI[2].arg();
    
    result.basic3U3I.fIa = fUI[3].norm();
    result.basic3U3I.fAngle_Ia = fUI[3].arg();
    
    result.basic3U3I.fIb = fUI[4].norm();
    result.basic3U3I.fAngle_Ib = fUI[4].arg();
    
    result.basic3U3I.fIc = fUI[5].norm();
    result.basic3U3I.fAngle_Ic = fUI[5].arg();
    return result;
}

-(BD_FaultCacuResultModel *)stateCaculateShortDataWithTestData:(BD_FaultCaculateModel *)data{
    //计算Va Vb Vc
    CFaultCalculat FaultCalculat;
    Complex Comp1;
     Complex Comp2;
    double m_fImpAngle = data.fImpAngle;     //!短路阻抗角
    double m_fK0s = data.fK0s;       //!转换后零序补偿系数
    double m_fK0sPh = data.fK0sPhi;        //!转换后零序补偿系数
    int    m_nK0CalMode = data.fK0CalModel;   //!零序补偿系数计算方式  0-|K0|,,Phi(K0), 1-RERL,,XEXL, 2-|Z0/Z1|,,Phi(Z0/Z1)  默认为1
    Comp1 = FaultCalculat.GroundFactor(m_nK0CalMode,\
                                       m_fK0s,\
                                       m_fK0sPh,\
                                       m_fImpAngle);
    
//    float m_fK0AmpCal=(float)Comp1.norm();
//    float m_fK0AngleCal=(float)Comp1.arg();
    float m_fK0AmpCal=Comp2.norm(Comp1);
    float m_fK0AngleCal=Comp2.arg(Comp1);//距离和搜索阻抗中此处计算不一样，只是去了comp中的实部和需部
    double m_fDZFactor  = data.fDZFactor;//!此系数只有工频变化量距离用到，其他是1
    bool   m_bFaultDir = data.fFaultDir;//data.iErrorDirc;     //!故障方向，0-反方向，1-正方向，默认为1
    bool   m_bCTPoint = data.fCTPoint;     //!CT极性正方向: 0--指向线路, 1--指向母线，默认为0
    int    m_nCalMode = data.fCalMode;     //!计算模式，过流、零序为3，距离、阻抗边界搜索为0，工频变化量距离根据故障方向而不同，为4（正方向）或5（反方向），默认为0
    int    m_nFaultType = data.fFaultType; //!故障类型，0-9分别为A相接地、B相接地、C相接地、AB短路、BC短路、CA短路、AB接地短路、BC接地短路、CA接地短路、三相短路
    int nPhaseRef[11]={1,2,0,2,0,1,2,0,1,0,0};
//    float nAngle[11] = {0,-120,120,30,-90,150,30,-90,150,0,120};
   
    
//    double m_fVOutmax[4] = {300, 200, 150, 100};
//    double m_fIOutmax[4] = {32, 20, 25, 26};
    double m_fVmax = 5000000;
    double m_fImax = 5000;
    double m_fVnom = data.fVNom;//GETCOMMON.EDV;            //!额定电压
    float fVFactor = data.fVFactor; //PT变比
    float fIFactor = data.fIFactor; //CT变比
    double fIt = data.fDL_I;
    double fVt = data.fDL_V;
    if (fIt<0) {
        fIt = 0;
    }
    if (fIt>m_fImax) {
        fIt = m_fImax;
    }
    if (fVt<0) {
        fVt = 0;
    }
    if (fVt>m_fVmax) {
        fVt = m_fVmax;
    }
    double m_fImpedance =data.fHeadZ;
    float  fValueFactor = 1.0f;//固定显示1，貌似之前的powtest中和界面上显示的是kw还是w有关
    double  m_fIfh = data.m_fIfh;//负荷电流
    double m_fPowerAngle = data.m_fPowerAngle;//负荷公角
    double zszl = data.zszl;
    Complex m_fVa=Comp1.polar(m_fVnom,0.0);
    Complex m_fVb=Comp1.polar(m_fVnom,-120.0);
    Complex m_fVc=Comp1.polar(m_fVnom,120.0);
    Complex m_fIa=Comp1.polar(data.m_fIfh,0.0-data.m_fPowerAngle);
    Complex m_fIb=Comp1.polar(data.m_fIfh,-120.0-data.m_fPowerAngle);
    Complex m_fIc=Comp1.polar(data.m_fIfh,120.0-data.m_fPowerAngle);
    double nAngle[11] = {Comp1.arg(m_fVb),Comp1.arg(m_fVc),Comp1.arg(m_fVa),Comp1.arg(m_fVc),Comp1.arg(m_fVa),Comp1.arg(m_fVb),Comp1.arg(m_fVc),Comp1.arg(m_fVa),Comp1.arg(m_fVb),Comp1.arg(m_fVa),Comp1.arg(m_fVa)};
    
    Complex fUI[6];         //!定义Ua、Ub、Uc、Ia、Ib、Ic
    
    FaultCalculat.Calculat(m_fDZFactor, m_bFaultDir, m_bCTPoint, m_nCalMode, m_nFaultType,\
                           nPhaseRef[m_nFaultType],\
                           nAngle[nPhaseRef[m_nFaultType]],\
                           m_fVmax/fVFactor,\
                           m_fVnom/fVFactor,\
                           m_fImax/fIFactor,\
                           &fIt, &fVt,\
                           Comp1.polar(m_fIfh/fIFactor,-m_fPowerAngle),\
                           Comp1.polar(m_fImpedance/fVFactor/fValueFactor*fIFactor, m_fImpAngle),\
                           Comp1.polar(m_fK0AmpCal, m_fK0AngleCal),\
                           Comp1.polar(m_fImpedance*zszl/fVFactor/fValueFactor*fIFactor,m_fImpAngle),\
                           //此处距离和搜索阻抗中用的是转换后零序补偿系数m_fK0s, m_fK0sPh，而状态序列中用的则是,m_fK0AmpCal, m_fK0AngleCal，用了重复的两组，不是是否正确，目前和pc端计算结果是相同
                            Comp1.polar(m_fK0AmpCal, m_fK0AngleCal),
                           &fUI[0],&fUI[1],&fUI[2],&fUI[3],&fUI[4],&fUI[5]);
    BD_FaultCacuResultModel *result  = [[BD_FaultCacuResultModel alloc]init];
    result.fDL_I = fIt;
    result.basic3U3I.fVa = fUI[0].norm();
    result.basic3U3I.fAngle_Va = fUI[0].arg();
    
    result.basic3U3I.fVb = fUI[1].norm();
    result.basic3U3I.fAngle_Vb = fUI[1].arg();
    
    result.basic3U3I.fVc = fUI[2].norm();
    result.basic3U3I.fAngle_Vc = fUI[2].arg();
    
    result.basic3U3I.fIa = fUI[3].norm();
    result.basic3U3I.fAngle_Ia = fUI[3].arg();
    
    result.basic3U3I.fIb = fUI[4].norm();
    result.basic3U3I.fAngle_Ib = fUI[4].arg();
    
    result.basic3U3I.fIc = fUI[5].norm();
    result.basic3U3I.fAngle_Ic = fUI[5].arg();
    return result;
}

@end
