//
//  BD_EnumCollection.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#ifndef BD_EnumCollection_h
#define BD_EnumCollection_h
/**测试动作类型*/
//1：开始实验    2：实验结束    3：状态切换    4：开入变位 5: 递变
typedef NS_ENUM(NSInteger,BDActionType){
    BDActionType_Start = 1,
    BDActionType_Stop = 2,
    BDActionType_StateChanged = 3,
    BDActionType_Binary = 4,
    BDActionType_Gradient = 5,
    BDActionType_Default = 6,
};


/**状态序列递变类型*/
typedef NS_ENUM(NSInteger,BDGradientType) {
    BDGradientType_dfdt = 0,//df/dt
    BDGradientType_dvdt = 1,//dv/dt
    BDGradientType_comGradient = 2,//普通递变
    BDGradientType_dfdvdt = 3,//dv/dt 和df/dt
    BDGradientType_null,//什么都不选
};

/**goose订阅通道绑定操作类型*/
typedef NS_ENUM(NSInteger,IECGooseSubscriptionBindingType){
    IECGooseSubscriptionBindingType_Selected = 0,
    IECGooseSubscriptionBindingType_Binding,
    IECGooseSubscriptionBindingType_Unbinding
};


/**差动模块测试项类型*/
typedef NS_ENUM(NSInteger,DifferTestItemType){
    DifferTestItemType_QDCurrent = 0,//启动电流
    DifferTestItemType_ZDRatio = 1,// 比率制动
    DifferTestItemType_SDCurrent = 2,//速断电流
    DifferTestItemType_HarmonicRation = 3,//谐波制动系数
    DifferTestItemType_ActionTime = 4,// 动作时间
    DifferTestItemType_Characteristic = 5,// 动作特性曲线测试
    DifferTestItemType_Other=6  //其他
};
/**手动测试，手动递变 手动+／- */
typedef NS_ENUM(NSInteger,OperationType){
    OperationTypePluse=0,
    OperationTypeReduce
};
/**手动测试数据模型改变类型*/
typedef NS_ENUM(NSInteger,QuickTestParamModelChangeItemType){
    QuickTestParamModelChangeItemType_Amplitude = 0,
    QuickTestParamModelChangeItemType_Phase,
    QuickTestParamModelChangeItemType_Frequency,
    QuickTestParamModelChangeItemType_All
};
/**测试仪类型*/
typedef  NS_ENUM(NSInteger,BDDeviceType){
    BDDeviceType_Imitate = 0,
    BDDeviceType_Digit,
    BDDeviceType_ImitateDigit,
};

/**ied类型*/
typedef  NS_ENUM(NSInteger,BD_IEDInfoType){
    BD_IEDInfoType_GOSend = 0,
    BD_IEDInfoType_GOSub,
    BD_IEDInfoType_SMVSend,
   BD_IEDInfoType_SMVSub,
};
/**实验模块*/
typedef NS_ENUM(NSInteger,BD_TestModuleType){
    BD_TestModuleType_Manual=0,//手动
    BD_TestModuleType_Status,//状态序列
    BD_TestModuleType_Diff,//差动
    BD_TestModuleType_Harm,//谐波
    BD_TestModuleType_Distance,//距离
    BD_TestModuleType_SearchZBorder,//搜索阻抗
    BD_TestModuleType_CBOperateTest,//整组
};
/**谐波通道类型*/
typedef NS_ENUM(NSInteger,BDHarmPassageType){
    BDHarmPassageType_FUTI = 0,
    BDHarmPassageType_SUSI,
};
#endif /* BD_EnumCollection_h */
