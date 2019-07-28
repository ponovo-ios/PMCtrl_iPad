//
//  OCCenter.m
//  PQCProj
//
//  Created by liwei on 2017/3/29.
//  Copyright © 2017年 weiwei. All rights reserved.
//

#import "OCCenter.h"
#import "XmlRpc.h"
#import "myXmlrpcServer.h"

//通用模型
#import "BD_TestDataParamModel.h"
#import "hqyPUDPara.pb.h"
#import "BD_UtcTime.h"
//手动
#import "BD_QuickTestParamModel.h"
#import "manuTest.pb.h"
//状态序列
#import "BD_StateTestCommonParamModel.h"
#import "BD_StateTestParamModel.h"
#import "BD_StateTestTransmutationDetailModel.h"
#import "BD_StateTestItemModel.h"
#import "stateTest.pb.h"
//谐波
#import "BD_HarmModel.h"
#import "Harm.pb.h"
//差动
#import "BD_DifferentialTestItemModel.h"
#import "BD_DifferGeneralSetDataModel.h"
#import "BD_DifferSetDataModel.h"
#import "BD_TestBinarySwitchSetModel.h"
#import "Differential.pb.h"
//开入量下发
#import "BD_BinaryInSettingModel.h"
#import "hqyBinaryInSetting.pb.h"

#import "BD_ServiceManage.h"
using namespace XmlRpc;
#include <iostream>
using namespace std;

static OCCenter *__shareCenter = nil;

@interface OCCenter()
@property(nonatomic,strong)BD_ServiceManage *servicManager;
@end

@implementation OCCenter

#pragma mark - 运行服务端
- (void)serviceRun{
    myXmlRpcServer myServer;
    std::cout<<"About to run the server\n";
    myServer.run();

}

#pragma mark - 单例
+ (OCCenter *)shareCenter
{
    if(!__shareCenter)
    {
        __shareCenter = [[OCCenter alloc] init];
    }
    return __shareCenter;
}

- (id)init
{
    self =[super init];
    if(self)
    {
        //获取和设置ip
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"ip"])
        {
            _ip = [[NSUserDefaults standardUserDefaults] valueForKey:@"ip"];
            
            NSLog(@"非第一次设置ip，沙盒ip-->%@",_ip);
        }
        else
        {
            //测试ip
            _ip = @"192.168.2.10";
            
            NSLog(@"默认ip：%@",_ip);
        }
        
        //获取和设置端口号
        if([[NSUserDefaults standardUserDefaults] valueForKey:@"port"])
        {
            _port = [[[NSUserDefaults standardUserDefaults] valueForKey:@"port"] integerValue];
        }
        else
        {
            _port = 8085;
        }
    }
    return self;
}

-(BD_ServiceManage *)servicManager{
    if (!_servicManager) {
        _servicManager = [[BD_ServiceManage alloc]init];
    }
    return _servicManager;
}
#pragma mark - 访问器
- (void)setIp:(NSString *)ip{
    _ip = [ip copy];
    [self saveAllValue];
}
- (void)setPort:(NSInteger)port
{
    _port = port;
    [self saveAllValue];
}

#pragma mark - 保存到沙盒
- (void)saveAllValue
{
    [[NSUserDefaults standardUserDefaults] setValue:@(_port) forKey:@"port"];
    [[NSUserDefaults standardUserDefaults] setValue:self.ip forKey:@"ip"];
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 开始
//1或2都是开始 0 停止  3进入下一状态 手动触发
- (int)start:(int)startNum
{
    @try {
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
        XmlRpcValue result;
        XmlRpcValue oValue(startNum);
        bool isSuc = oClient.execute("Start",oValue,result);

        oClient.close();
        return isSuc;
    } @catch (NSException *exception) {
DLog(@"start抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {

    }

}

#pragma mark - 结束
- (int)stop
{
    @try {
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
        XmlRpcValue result;
        XmlRpcValue oValue(0);
        bool isSuc = oClient.execute("Start",oValue,result);
        oClient.close();
        return isSuc;
    } @catch (NSException *exception) {
DLog(@"stop抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {

    }
}



#pragma mark - 手动测试
- (bool)ManualTest:(NSArray *)values
{
    NSLog(@"values:%@",values);

    //1.定义消息变量
    ManuTestPara::TestItem oiTem;

    //2级
/*
    oiTem.set_otesttype(hqyPudPara::para_type::manual_type);//设置测试类型
    hqyPudPara::manualpara* manualPara = oiTem.mutable_omanual();//配置
 */
    //2级别 TestItem
    ManuTestPara::CommonPara* commonPara = oiTem.mutable_ocommonpara();//通用参数
    ManuTestPara::SwitchPara* owitchpara = oiTem.mutable_oswitchpara();//开入变位

/*
    //3级
    manualpara下级
    hqyPudPara::acpara *oacpara = manualPara->mutable_oacpara();
    manualPara->set_sendzeroafterstop(2);
*/
    //3级别
    //CommonPara组装
    BD_QuickTestComSetModel *model;
    if (values.count>=3) {
        model = (BD_QuickTestComSetModel *)values[values.count-1][0];
    }

    commonPara->set_ftrigdelay([model.delayTime floatValue]);//触发延时
    commonPara->set_bagingtest([@(model.isAgingTest) intValue]);//是否老化试验
    commonPara->set_bautotest(model.isAuto);
    commonPara->set_bdctest([@(model.isCocurrent) intValue]);//是否直流试验
    commonPara->set_block([@(model.isLock) intValue]);//是否锁定
    commonPara->set_itesttype(model.autoChangeStyle);

     //oacanlogpara模拟量通道 oacdigitalpara数字量通道 oanaGradientpara模拟量递变参数 odigRadientpara数字量递变参数组装
    //如果模拟 oacanlogpara组装 oanaGradientpara组装 如果数字oacdigitalpara odigRadientpara 组装
    if ([BD_PMCtrlSingleton shared].deviceType==BDDeviceType_Imitate) {

        OutPutCommon::acanalogpara* oacanlogpara = oiTem.mutable_oacanlogpara();//模拟量电流电压通道
        
        OutPutCommon::GradientPara* oanaGradientpara = oiTem.mutable_oanagradientpara();//模拟量递变参数
        [self manualTestSubFunction:values object:oacanlogpara];
        //模拟变量
        oanaGradientpara->set_ivar([self varTypeStringToProbuf:[model.varlabel substringToIndex:model.varlabel.length-3]]);
        oanaGradientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//模拟变量类型
        oanaGradientpara->set_fstep([model.stepValue floatValue]);//模拟变量步长
        oanaGradientpara->set_fsteptime([model.changeTime floatValue]);//模拟变量变化时间
        oanaGradientpara->set_fstart([model.startValue floatValue]);//模拟变量变化初始值
        oanaGradientpara->set_fend([model.endValue floatValue]);//模拟变量变化终值
        oanaGradientpara->set_nharm(0);
    } else if ([BD_PMCtrlSingleton shared].deviceType==BDDeviceType_Digit){
        //数字变量
        OutPutCommon::GradientPara* odigRadientpara = oiTem.mutable_odiggradientpara();//数字量递变参数
        OutPutCommon::acanalogpara* oacdigitalpara = oiTem.mutable_oacdigitalpara();//数字量电流电压通道
        [self manualTestSubFunction:values object:oacdigitalpara];
        odigRadientpara->set_ivar([self varTypeStringToProbuf:[model.varlabel substringToIndex:model.varlabel.length-3]]);
        odigRadientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//数字变量类型
        odigRadientpara ->set_fstep([model.stepValue floatValue]);//数字变量步长
        odigRadientpara->set_fsteptime([model.changeTime floatValue]);//数字变量变化时间
        odigRadientpara->set_fstart([model.startValue floatValue]);//数字变量变化初始值
        odigRadientpara->set_fend([model.endValue floatValue]);//数字变量变化终值
    } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_ImitateDigit){
        //数模一体，前6路是模拟，后6路是数字，将前6路添加到模拟对应的通道参数，将后6路添加到数字对应的通道参数
        OutPutCommon::acanalogpara* oacanlogpara = oiTem.mutable_oacanlogpara();//模拟量电流电压通道
        OutPutCommon::GradientPara* oanaGradientpara = oiTem.mutable_oanagradientpara();//模拟量递变参数
        OutPutCommon::GradientPara* odigRadientpara = oiTem.mutable_odiggradientpara();//数字量递变参数
        OutPutCommon::acanalogpara* oacdigitalpara = oiTem.mutable_oacdigitalpara();//数字量电流电压通道
        NSMutableArray *anlogArr = [[NSMutableArray  alloc]init];
        NSMutableArray *digitalArr = [[NSMutableArray  alloc]init];

        if (values.count>=2) {
            NSArray * voltages = (NSArray *)values[0];
            NSArray *currents = (NSArray *)values[1];
            NSMutableArray *vol = [[NSMutableArray alloc]init];
            NSMutableArray *cur = [[NSMutableArray alloc]init];
            for (NSInteger i = 0; i<6; i++) {
                [vol addObject:voltages[i]];
                [cur addObject:currents[i]];
            }
            [anlogArr addObject:[vol copy]];

            [anlogArr addObject:[cur copy]];
            NSMutableArray *dvol = [[NSMutableArray alloc]init];
            NSMutableArray *dcur = [[NSMutableArray alloc]init];
            for (NSInteger i = 6; i<voltages.count; i++) {
                [dvol addObject:voltages[i]];

            }
            for (NSInteger i = 6; i<currents.count; i++) {
                [dcur addObject:currents[i]];
            }
            [digitalArr addObject:[dvol copy]];
            [digitalArr addObject:[dcur copy]];
        }
         [self manualTestSubFunction:[anlogArr copy] object:oacanlogpara];
         [self manualTestSubFunction:[digitalArr copy] object:oacdigitalpara];
        //模拟变量
        oanaGradientpara->set_ivar([self varTypeStringToProbuf:[model.varlabel substringToIndex:model.varlabel.length-3]]);
        oanaGradientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//模拟变量类型
        oanaGradientpara->set_fstep([model.stepValue floatValue]);//模拟变量步长
        oanaGradientpara->set_fsteptime([model.changeTime floatValue]);//模拟变量变化时间
        oanaGradientpara->set_fstart([model.startValue floatValue]);//模拟变量变化初始值
        oanaGradientpara->set_fend([model.endValue floatValue]);//模拟变量变化终值
        //数字变量
        odigRadientpara->set_ivar([self varTypeStringToProbuf:[model.varlabel substringToIndex:model.varlabel.length-3]]);
        odigRadientpara->set_itype([self paramTypeIntChangedToProbuf:model.ParaType]);//数字变量类型
        odigRadientpara ->set_fstep([model.stepValue floatValue]);//数字变量步长
        odigRadientpara->set_fsteptime([model.changeTime floatValue]);//数字变量变化时间
        odigRadientpara->set_fstart([model.startValue floatValue]);//数字变量变化初始值
        odigRadientpara->set_fend([model.endValue floatValue]);//数字变量变化终值
    }

    //开入量组装
    owitchpara->set_iinput([model.binaryIn intValue]);
    owitchpara->set_ilogic([@(model.binaryLogic) intValue]);
    owitchpara->set_ioutput([model.binaryOut intValue]);



 /*   manualPara->set_ndelaytime([model.delayTime floatValue]);   //接收到开入后延时多长时间停止
    manualPara->set_nisstopbichanged([@(YES) intValue]); //开入变位后是否停止

    //4级
    //oacpara下级
    hqyPudPara::acanalogpara *pacanalogpara = oacpara->mutable_oacanlogpara();
    oacpara->set_nbinaryout([model.binaryIn floatValue]); //开入量
    //5级
    //pacanalogpara下级
 */

    int size = oiTem.ByteSize();

    char *pchar = (char *)malloc(sizeof(char)*size);

    oiTem.SerializePartialToArray(pchar, size);

    @try {
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);

        XmlRpcValue result;

        XmlRpcValue oValue(pchar,size);

        //发送数据方法 PSUManuTest (新方法名) PQTTestMethod(旧方法名)
        bool isSuc = oClient.execute("PSUManuTest",oValue,result);
        oClient.close();
        
        return isSuc;

    } @catch (NSException *exception) {
       DLog(@"manual抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {
        free(pchar);
    }

}


//拼接电压电流通道
-(void)manualTestSubFunction:(NSArray *)sourceArr object:(OutPutCommon::acanalogpara*)para{
    for (int i = 0; i<2; i++) {
        if (i == 0) {
            //电压
            NSArray *modelArr = (NSArray *)sourceArr[i];
            for (int n = 0; n<modelArr.count; n++) {
                BD_TestDataParamModel *model = (BD_TestDataParamModel *)modelArr[n];
                para->add_analogvoltchangelvalue();
                para->mutable_analogvoltchangelvalue(n)->set_famptitude([model.amplitude floatValue]);//幅值
                para->mutable_analogvoltchangelvalue(n)->set_fphase([model.phase floatValue]);//相位
                para->mutable_analogvoltchangelvalue(n)->set_ffre([model.frequency floatValue]);//频率
            }
        } else {
            //电流
            NSArray *modelArr = (NSArray *)sourceArr[i];
            for (int j = 0; j<modelArr.count; j++) {
                BD_TestDataParamModel *model = (BD_TestDataParamModel *)modelArr[j];
                para->add_analogcurrentchanelvalue();
                para->mutable_analogcurrentchanelvalue(j)->set_famptitude([model.amplitude floatValue]);//幅值
                para->mutable_analogcurrentchanelvalue(j)->set_fphase([model.phase floatValue]);//相位
                para->mutable_analogcurrentchanelvalue(j)->set_ffre([model.frequency floatValue]);//频率
            }
        }
    }
}
//将int类型转换为OutPutCommon::changed_type类型
-(OutPutCommon::changed_type)paramTypeIntChangedToProbuf:(int)type{
    switch (type) {
        case 0:
            return OutPutCommon::changed_type::amplitude_type;
            break;
        case 1:
            return OutPutCommon::changed_type::phasor_type;
            break;
        case 2:
            return OutPutCommon::changed_type::fre_type;
            break;
        default:
            break;
    }
    return OutPutCommon::changed_type::amplitude_type;
}

#pragma mark - 状态序列
- (bool)statesTest:(NSArray<BD_TestDataParamModel *> *)testListDatas commonPara:(BD_StateTestCommonParamModel *)comparam deviceGPSTime:(BD_UtcTime *)deviceGPSTime{
    
   /* //1.定义消息变量
    hqyPudPara::TestItem oiTem;
    
    //2级
    oiTem.set_otesttype(hqyPudPara::para_type::state_type);  //测试类型
    hqyPudPara::states *ostatepara = oiTem.mutable_ostatepara();

    //3级  设置states属性
    //->这里需要根据app实际加载情况来创建
    for (int i = 0; i < values.count; i ++) {
    
        BD_StateTestParamModel *model = (BD_StateTestParamModel *)values[i];
    
        hqyPudPara::state *ostates = ostatepara->add_ostates();
    
        //4级 设置state
        ostates->set_nindex(i);
        hqyPudPara::acpara *oacpara = ostates->mutable_oacpara();
        ostates->set_ntrigertype([model.triggerParam.TriggerType floatValue]);//0: 手动触发 1:时间触发单位ms 2:开入变位触发 3:GPS触发
        ostates->set_ntrigerlogic([model.triggerParam.TriggerLogic floatValue]);//逻辑或、与
        ostates->set_ntirgertime([model.triggerParam.TriggerTime floatValue]);//时间触发参数或 GPS触发秒数
        ostates->set_sgpstime([model.triggerParam.sGpstime floatValue]); //sGpstime
        ostates->set_nsgpstime([model.triggerParam.nsGpsTime floatValue]);//GPS时间 hour:minute:second.ns
        ostates->set_nbivalide([model.triggerParam.nBiValide intValue]);//开入有效位
    
        //5级
        //oacpara下级
        hqyPudPara::acanalogpara *pacanalogpara = oacpara->mutable_oacanlogpara();//模拟量
        oacpara->set_nbinaryout([model.triggerParam.nbinaryout intValue]);  //开出量
    
        //6级
        //pacanalogpara下级
        //电压
   
    
            NSMutableArray<BD_QuickTestParamModel *>  *modelArr = (NSMutableArray<BD_QuickTestParamModel *> *)model.stateParam[0];
            for (int n = 0; n<modelArr.count; n++) {
                BD_QuickTestParamModel *subModel = modelArr[n];
                pacanalogpara->add_analogvoltchangelvalue();
                pacanalogpara->mutable_analogvoltchangelvalue(n)->set_famptitude([subModel.amplitude floatValue]);
                pacanalogpara->mutable_analogvoltchangelvalue(n)->set_fphase([subModel.phase floatValue]);
                pacanalogpara->mutable_analogvoltchangelvalue(n)->set_ffre([subModel.frequency floatValue]);
    
            }
    
    
        //电流
        NSMutableArray<BD_QuickTestParamModel *>  *modelArr1 = (NSMutableArray<BD_QuickTestParamModel *> *)model.stateParam[1];
    
        for (int j = 0; j<modelArr1.count; j++) {
            BD_QuickTestParamModel *subModel1 = modelArr1[j];
            pacanalogpara->add_analogcurrentchanelvalue();
            pacanalogpara->mutable_analogcurrentchanelvalue(j)->set_famptitude([subModel1.amplitude floatValue]);
            pacanalogpara->mutable_analogcurrentchanelvalue(j)->set_fphase([subModel1.phase floatValue]);
            pacanalogpara->mutable_analogcurrentchanelvalue(j)->set_ffre([subModel1.frequency floatValue]);
        }
    

    
    
    //is loops
    ostatepara->set_nisloop(0);
  */
    //一级
    StatePara::states oitem;
    //一级通用参数设置
    StatePara::CommonPara* commonPara = oitem.mutable_ocommon();
    
    commonPara->set_njudgecondition(comparam.binaryChangeState);//开入翻转参考状态 0:第一个状态 1 上一个状态
    commonPara->set_ndcoffset([@(comparam.reduceCocurrent) intValue]);//是否叠加直流分量
    commonPara->set_ftou([comparam.reduceTime floatValue]);//衰减时间常数
    commonPara->set_nloopnum([comparam.cycleIndex intValue]-1);//循环次数 循环次数下发到底层的时候应该是页面设置数-1
    //一级 测试项参数组装
    for (int i = 0; i < testListDatas.count; i ++) {
        
        BD_StateTestItemModel *model = (BD_StateTestItemModel *)testListDatas[i];
        if(model.itemSelect){
            StatePara::state *ostates = oitem.add_ostates();
            
            ostates->set_nindex((int)model.itemNum);
            ostates->set_bdc(model.itemParam.stateParam.isDirectCurrent);//是否直流
            ostates->set_ntrigertype([model.itemParam.triggerParam.TriggerType intValue]);//0: 手动触发 1:时间触发单位ms 2:开入变位触发 3:GPS触发 4:开关量或时间触发 5:低电压触发
            ostates->set_foutputtime([model.itemParam.triggerParam.TriggerTime floatValue]);//输出时间
            //gps时间传入，是通过仪器gps时间的年月日+触发条件设置的时：分：秒，为gps触发的时间，从1970到该时间到秒值为protobuf文件中需要的nGPSTime值；
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat: @"HH:mm:ss"];
            NSString *gpsDatestr = [[NSString stringWithFormat:@"%d:%d:%d ",deviceGPSTime.year,deviceGPSTime.month,deviceGPSTime.day] stringByAppendingString:model.itemParam.triggerParam.Gpstime];
            NSDate *gpsDate = [formatter dateFromString:gpsDatestr];
            
            NSTimeInterval ss = [gpsDate timeIntervalSince1970];
            float nGPSTime = (float)ss;
            float nsGPSTime = 0.0;
            ostates->set_sgpstime(nGPSTime); //sGpstime
            ostates->set_nsgpstime(nsGPSTime);//GPS时间 hour:minute:second.ns
            
            ostates->set_ftrigerholdtime([model.itemParam.triggerParam.trigerHoldTime floatValue]);//触发后保持时间
            //       OutPutCommon::acanalogpara* oacAnalogpara = ostates->mutable_oacanalogpara(); //模拟通道
            //        OutPutCommon::acanalogpara* oacDigitalpara = ostates->mutable_oacdigitalpara();//数字通道
            
            StatePara::GradientPara* oanaGradientpara = ostates->mutable_oanagradientpara();//模拟递变参数
            StatePara::GradientPara* odigGradientpara = ostates->mutable_odiggradientpara();//数字递变参数
            
            //模拟和数字组装不同的参数
            if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_Imitate) {
                ostates->set_nbivalide([model.itemParam.triggerParam.nBiValide intValue]);//开入有效位
                ostates->set_nbilogic([model.itemParam.triggerParam.TriggerLogic intValue]);//开入逻辑
                ostates->set_nbovalide([model.itemParam.triggerParam.nbinaryout intValue]);//开出有效位
                //模拟电压电流通道
                
                OutPutCommon::acanalogpara* oacAnalogpara = ostates->mutable_oacanalogpara();
                
                
                [self manualTestSubFunction:@[model.itemParam.stateParam.voltageOutputDatas,model.itemParam.stateParam.currentOutputDatas] object:oacAnalogpara];
                
                //模拟递变参数
                
                [self setStateTestTransmutationPara:oanaGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
            } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_Digit){
                ostates->set_nbidigitalvalide([model.itemParam.triggerParam.nBiValide intValue]);//数字开入变位有效位
                //数字电压电流通道
                
                OutPutCommon::acanalogpara* oacDigitalpara = ostates->mutable_oacdigitalpara();
                
                [self manualTestSubFunction:@[model.itemParam.stateParam.voltageOutputDatas,model.itemParam.stateParam.currentOutputDatas] object:oacDigitalpara];
                
                //数字递变参数
                
                [self setStateTestTransmutationPara:odigGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
            } else if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_ImitateDigit){
                ostates->set_nbivalide([model.itemParam.triggerParam.nBiValide intValue]);//开入有效位
                ostates->set_nbilogic([model.itemParam.triggerParam.TriggerLogic intValue]);//开入逻辑
                ostates->set_nbovalide([model.itemParam.triggerParam.nbinaryout intValue]);//开出有效位
                ostates->set_nbidigitalvalide([model.itemParam.triggerParam.nBiValide intValue]);//数字开入变位有效位
                
                
                //模拟电压电流通道
                OutPutCommon::acanalogpara* oacAnalogpara = ostates->mutable_oacanalogpara();
                
                NSMutableArray *anlogArr = [[NSMutableArray  alloc]init];
                NSMutableArray *digitalArr = [[NSMutableArray  alloc]init];
                
                NSMutableArray *vol = [[NSMutableArray alloc]init];
                NSMutableArray *cur = [[NSMutableArray alloc]init];
                for (NSInteger i = 0; i<6; i++) {
                    [vol addObject:model.itemParam.stateParam.voltageOutputDatas[i]];
                    [cur addObject:model.itemParam.stateParam.currentOutputDatas[i]];
                }
                [anlogArr addObject:[vol copy]];
                
                [anlogArr addObject:[cur copy]];
                NSMutableArray *dvol = [[NSMutableArray alloc]init];
                NSMutableArray *dcur = [[NSMutableArray alloc]init];
                for (NSInteger i = 6; i<model.itemParam.stateParam.voltageOutputDatas.count; i++) {
                    [dvol addObject:model.itemParam.stateParam.voltageOutputDatas[i]];
                }
                for (NSInteger i = 6; i<model.itemParam.stateParam.currentOutputDatas.count; i++) {
                    [dcur addObject:model.itemParam.stateParam.currentOutputDatas[i]];
                }
                [digitalArr addObject:[dvol copy]];
                [digitalArr addObject:[dcur copy]];
                
                
                [self manualTestSubFunction:[anlogArr copy] object:oacAnalogpara];
                
                //模拟递变参数
                
                [self setStateTestTransmutationPara:oanaGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
                //数字电压电流通道
                OutPutCommon::acanalogpara* oacDigitalpara = ostates->mutable_oacdigitalpara();
                [self manualTestSubFunction:[digitalArr copy] object:oacDigitalpara];
                //数字递变参数
                [self setStateTestTransmutationPara:odigGradientpara triggerPara:model.itemParam.triggerParam transmutationPara:model.itemParam.transmutationParam];
                
            }
            ostates->set_bboinvert([@(model.itemParam.triggerParam.isBinaryOutStateInvert) intValue]);//是否开出状态翻转
            ostates->set_fboholdtime([model.itemParam.triggerParam.binaryOutStateInvertHoldTime floatValue]);//开出状态翻转保持时间
            
        }
    }
    
    //转字节流
    //计算对象大小
    int size = oitem.ByteSize();
    
    //开辟内存空间
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    //序列化到内存中
    oitem.SerializePartialToArray(pchar, size);
    
    @try {
        //创建客户端对象
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
        
        XmlRpcValue result;
        
        XmlRpcValue oValue(pchar,size);
        //下发参数方法 PSUStateTest(新方法名)PQTTestMethod(旧方法名)
        bool isSuccess = oClient.execute("PSUStateTest",oValue,result);
        
        NSLog(@"isSuccess->:%d",isSuccess);
        
        oClient.close();
        return isSuccess;
        
    } @catch (NSException *exception) {
        DLog(@"state抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {
        free(pchar);
    }
}

//状态序列设置递变参数
-(void)setStateTestTransmutationPara:(StatePara::GradientPara *)para triggerPara:(BD_StateTestTriggerParamModel *)triggerPara transmutationPara:(BD_StateTestTransmutationDetailModel *)transmutationPara{
    para->set_bdfdt(triggerPara.isdfdt);
    para->set_bdvdt(triggerPara.isdvdt);
    para->set_bcomgradient(triggerPara.isComGradient);
    //TODO:变量类型
    if(transmutationPara.paramType.length>2){
      para->set_ivar([self varTypeStringToProbuf:[transmutationPara.paramType substringToIndex:transmutationPara.paramType.length-3]]);
    } else {
        para->set_ivar([self varTypeStringToProbuf:@"Ua"]);
    }

    para->set_fdfdt([transmutationPara.dfdtValue floatValue]);
    para->set_fdvdt([transmutationPara.dvdtValue floatValue]);
    para->set_fstartv([transmutationPara.startVValue floatValue]);
    para->set_fstarthz([transmutationPara.startHzValue floatValue]);
    para->set_fendhz([transmutationPara.endHzValue floatValue]);
    para->set_fendv([transmutationPara.endVValue floatValue]);
//    para->set_ftrigerv([transmutationPara.trigerVValue floatValue]);
    para->set_fstep([transmutationPara.changeStepValue floatValue]);
    para->set_fsteptime([transmutationPara.stepTimeValue floatValue]);
    para->set_fend([transmutationPara.changeEndValue floatValue]);
    para->set_fstart([transmutationPara.changeStartValue floatValue]);
    
}

-(OutPutCommon::para_type )varTypeStringToProbuf:(NSString *)vartype{
    
    if ([vartype isEqualToString:@"Ua"]) {
        return OutPutCommon::para_type::va1_type;
    }  else if ([vartype isEqualToString:@"Ub"]){
        return OutPutCommon::para_type::vb1_type;
    }  else if ([vartype isEqualToString:@"Uc"]){
        return OutPutCommon::para_type::vc1_type;
    }  else if ([vartype isEqualToString:@"Ua,Ub,Uc"]){
        return OutPutCommon::para_type::vabc1_type;
    }if ([vartype isEqualToString:@"Ua1"]) {
        return OutPutCommon::para_type::va1_type;
    }  else if ([vartype isEqualToString:@"Ub1"]){
        return OutPutCommon::para_type::vb1_type;
    }  else if ([vartype isEqualToString:@"Uc1"]){
        return OutPutCommon::para_type::vc1_type;
    }  else if ([vartype isEqualToString:@"Ua1,Ub1,Uc1"]){
        return OutPutCommon::para_type::vabc1_type;
    } else if ([vartype isEqualToString:@"Ua2"]){
        return OutPutCommon::para_type::va2_type;
    } else if ([vartype isEqualToString:@"Ub2"]){
        return OutPutCommon::para_type::vb2_type;
    } else if ([vartype isEqualToString:@"Uc2"]){
        return OutPutCommon::para_type::vc2_type;
    } else if ([vartype isEqualToString:@"Ua2,Ub2,Uc2"]){
        return OutPutCommon::para_type::vabc2_type;
    } else if ([vartype isEqualToString:@"Ia"]){
        return OutPutCommon::para_type::ia1_type;
    } else if ([vartype isEqualToString:@"Ib"]){
        return OutPutCommon::para_type::ib1_type;
    } else if ([vartype isEqualToString:@"Ic"]){
        return OutPutCommon::para_type::ic1_type;
    } else if ([vartype isEqualToString:@"Ia,Ib,Ic"]){
        return OutPutCommon::para_type::iabc1_type;
    } else if ([vartype isEqualToString:@"Ia1"]){
        return OutPutCommon::para_type::ia1_type;
    } else if ([vartype isEqualToString:@"Ib1"]){
        return OutPutCommon::para_type::ib1_type;
    } else if ([vartype isEqualToString:@"Ic1"]){
        return OutPutCommon::para_type::ic1_type;
    }else if ([vartype isEqualToString:@"Ia1,Ib1,Ic1"]){
        return OutPutCommon::para_type::iabc1_type;
    }if ([vartype isEqualToString:@"Ia2"]){
        return OutPutCommon::para_type::ia2_type;
    } else if ([vartype isEqualToString:@"Ib2"]){
        return OutPutCommon::para_type::ib2_type;
    } else if ([vartype isEqualToString:@"Ic2"]){
        return OutPutCommon::para_type::ic2_type;
    }else if ([vartype isEqualToString:@"Ia2,Ib2,Ic2"]){
        return OutPutCommon::para_type::iabc2_type;
    }     else if ([vartype isEqualToString:@"Ia1,Ib1,Ic1,Ia2,Ib2,Ic2"]){
        return OutPutCommon::para_type::iall_type;
    } else if ([vartype isEqualToString:@"Ua1,Ub1,Uc1,Ua2,Ub2,Uc2"]){
        return OutPutCommon::para_type::vall_type;
    }else if ([vartype isEqualToString:@"Uz"]){
        return OutPutCommon::para_type::vz_type;
    } else if ([vartype isEqualToString:@"Ua,Ub,Uc,Uz"]){
        return OutPutCommon::para_type::vall_type;
    }if ([vartype isEqualToString:@"Ua1,Ub1,Uc1,Ua2,Ub2,Uc2"]){
        return OutPutCommon::para_type::vall_type;
    }else if ([vartype isEqualToString:@"Uz"]){
        return OutPutCommon::para_type::vz_type;
    } else if ([vartype isEqualToString:@"Ua,Ub,Uc,Uz"]){
        return OutPutCommon::para_type::vall_type;
    } else if ([vartype isEqualToString:@"Ua,Ub"]){
        return OutPutCommon::para_type::vab1_type;
    }else if ([vartype isEqualToString:@"Ua,Uc"]){
        return OutPutCommon::para_type::vca1_type;
    } else if ([vartype isEqualToString:@"Ub,Uc"]){
        return OutPutCommon::para_type::vbc1_type;
    }if ([vartype isEqualToString:@"Ia,Ib"]){
        return OutPutCommon::para_type::iab1_type;
    }else if ([vartype isEqualToString:@"Ib,Ic"]){
        return OutPutCommon::para_type::ibc1_type;
    } else if ([vartype isEqualToString:@"Ia,Ic"]){
        return OutPutCommon::para_type::ica1_type;
    } else if ([vartype isEqualToString:@"Ua1,Ub1"]){
        return OutPutCommon::para_type::vab1_type;
    }else if ([vartype isEqualToString:@"Ua1,Uc1"]){
        return OutPutCommon::para_type::vca1_type;
    } else if ([vartype isEqualToString:@"Ub1,Uc1"]){
        return OutPutCommon::para_type::vbc1_type;
    }if ([vartype isEqualToString:@"Ia1,Ib1"]){
        return OutPutCommon::para_type::iab1_type;
    }else if ([vartype isEqualToString:@"Ib1,Ic1"]){
        return OutPutCommon::para_type::ibc1_type;
    }else if ([vartype isEqualToString:@"Ia1,Ic1"]){
        return OutPutCommon::para_type::ica1_type;
    }else {
        return OutPutCommon::para_type::vall_type;
    }
}

#pragma mark - 差动实验发送请求方法
- (bool)DifferentialTestWithGeneralParam:(BD_DifferGeneralSetDataModel *)generalParam setParam:(BD_DifferSetDataModel *)setParam binarySwitch:(BD_TestBinarySwitchSetModel *)binarySwitch testItem:(NSArray *)testItem outputType:(BDDeviceType)outputType{
    
    Differential::Items oitems;
    //通用参数
    Differential::CommonPara *oComm = oitems.mutable_ocomm();
    
    oComm->set_ed_v([generalParam.ED_V floatValue]);  //额定线电压
    oComm->set_ed_i([generalParam.ED_I floatValue]);  //额定电流
    oComm->set_ed_hz([generalParam.ED_Hz floatValue]); //额定频率
    oComm->set_pretime([generalParam.PreTime floatValue]); //准备时间
    oComm->set_prefaulttime([generalParam.PrefaultTime floatValue]); //故障前时间
    oComm->set_faulttime([generalParam.FaultTime floatValue]);  //故障时间
    oComm->set_balanceparacacutype([generalParam.BalanceParaCacuType intValue]);//各侧平衡系数0或1
    oComm->set_sn([generalParam.SN floatValue]);       //变压器额定容量
    oComm->set_uh([generalParam.Uh floatValue]);       //高压侧额定电压
    oComm->set_um([generalParam.Um floatValue]);       //中压侧额定电压
    oComm->set_ul([generalParam.Ul floatValue]);       //低压侧额定电压
    oComm->set_ctph([generalParam.CTPh floatValue]);   //高压侧CT一次值
    oComm->set_ctpm([generalParam.CTPm floatValue]);   //中压侧CT一次值
    oComm->set_ctpl([generalParam.CTPl floatValue]);   //低压侧CT一次值
    oComm->set_ctsh([generalParam.CTSh floatValue]);   //高压侧CT二次值
    oComm->set_ctsm([generalParam.CTSm floatValue]);   //高压侧CT二次值
    oComm->set_ctsl([generalParam.CTSl floatValue]);   //高压侧CT二次值
    oComm->set_kph([generalParam.Kph floatValue]);      //高压侧差动平衡系数
    oComm->set_kpm([generalParam.Kpm floatValue]);      //中压侧差动平衡系数
    oComm->set_kpl([generalParam.Kpl floatValue]);      //低压侧差动平衡系数
    //高压侧绕组接线型式
    switch ([generalParam.WindH intValue]) {
        case 0:
            oComm->set_windh(Differential::Connection_Type::TriangleType);
            break;
        case 1:
            oComm->set_windh(Differential::Connection_Type::StarType);
            break;
   
        default:
            break;
    }
    //中压侧绕组接线型式
    switch ([generalParam.WindM intValue]) {
        case 0:
            oComm->set_windm(Differential::Connection_Type::TriangleType);
            break;
        case 1:
            oComm->set_windm(Differential::Connection_Type::StarType);
            break;
        default:
            break;
    }
    //低压侧绕组接线型式
    switch ([generalParam.WindL intValue]) {
        case 0:
            oComm->set_windl(Differential::Connection_Type::TriangleType);
            break;
        case 1:
            oComm->set_windl(Differential::Connection_Type::StarType);
            break;
        default:
            break;
    }
    //校正选择0-2
    switch ([generalParam.AngleMode intValue]) {
        case 0:
            oComm->set_anglemode(Differential::Correct_Type::NONE_TYPE);
            break;
        case 1:
            oComm->set_anglemode(Differential::Correct_Type::Correct_Trigangel_Type);
            break;
        case 2:
            oComm->set_anglemode(Differential::Correct_Type::Correct_Start_Type);
            break;
   
        default:
            break;
    }
    //测试绕组0-2
    switch ([generalParam.WindSide intValue]) {
        case 0:
            oComm->set_windside(Differential::TestWind_Type::TestWind_HightToLow);
            break;
        case 1:
            oComm->set_windside(Differential::TestWind_Type::TestWind_HightToMin);
            break;
        case 2:
            oComm->set_windside(Differential::TestWind_Type::TestWind_MinToLow);
            break;
        default:
            break;
    }
    oComm->set_connmode([generalParam.ConnMode intValue]);//测试绕组之间角差 0 to 11
    oComm->set_jxfactor([generalParam.JXFactor intValue]);//平衡系数计算是否考虑接线形式
    //搜索方法 0-1
    switch ([generalParam.SerachMode intValue]) {
        case 0:
            oComm->set_serachmode(Differential::Search_Type::Search_Type_Search_Type);
            break;
        case 1:
            oComm->set_serachmode(Differential::Search_Type::Search_Type_Single);
            break;
        default:
            break;
    }
    //CT极性0-1
    switch ([generalParam.IdEqu intValue]) {
        case 0:
            oComm->set_idequ(Differential::CTPolar_Type::TwoSide_Type);
            break;
        case 1:
            oComm->set_idequ(Differential::CTPolar_Type::OneSide_type);
            break;
        default:
            break;
    }
    oComm->set_equation([generalParam.Equation intValue]);//制动方程
    oComm->set_k1([generalParam.K1 floatValue]);
    oComm->set_k2([generalParam.K2 floatValue]);
    //测试相0-3
    switch ([generalParam.Phase_Type intValue]) {
        case 0:
            oComm->set_phase_type(Differential::TestPhasor_type::APhase);
            break;
        case 1:
            oComm->set_phase_type(Differential::TestPhasor_type::BPhase);
            break;
        case 2:
            oComm->set_phase_type(Differential::TestPhasor_type::CPhase);
            break;
        case 3:
            oComm->set_phase_type(Differential::TestPhasor_type::ABCPhase);
            break;
  
        default:
            break;
    }
    oComm->set_reso([generalParam.Reso floatValue]);    //测试精度
    oComm->set_ugroup1([generalParam.Ugroup1 floatValue]);        //Uz
    oComm->set_ugroup2([generalParam.Ugroup2 floatValue]); 
    
    //整定值
    Differential::ProtectSetting *oProtectSet = oitems.mutable_oprotectset();
    //定值整定方式
    
    switch (setParam.Axis) {
        case 0:
            oProtectSet->set_axis(Differential::SettingType::RealValue_type);
            break;
        case 1:
            oProtectSet->set_axis(Differential::SettingType::MarkValue_Type);
            break;
        default:
            break;
    }
    ////基准电流选择
    switch (setParam.Insel) {
        case 0:
            oProtectSet->set_insel(Differential::BaseCurrentSelect::HighSideSecondaryCurrent);
            break;
        case 1:
            oProtectSet->set_insel(Differential::BaseCurrentSelect::SettingValue);
            break;
        case 2:
            oProtectSet->set_insel(Differential::BaseCurrentSelect::AllSideCurrent);
            break;
        default:
            break;
    }
    oProtectSet->set_inom(setParam.Inom);  //基准电流
    oProtectSet->set_isd(setParam.Isd);   //差动速断电流定值
    oProtectSet->set_icdqd(setParam.Icdqd); //差动动作电流门揽值
    oProtectSet->set_kneepoint((int)setParam.KneePoint); //拐点个数
    oProtectSet->set_ip1(setParam.Ip1);//比率制动特性拐点1电流
    oProtectSet->set_ip2(setParam.Ip2);//比率制动特性拐点1电流
    oProtectSet->set_ip3(setParam.Ip3);//比率制动特性拐点1电流
    oProtectSet->set_kid1(setParam.Kid1);//启动电流斜率
    oProtectSet->set_kid2(setParam.Kid2);//基波比率制动特性斜率1
    oProtectSet->set_kid3(setParam.Kid3);//速断电流斜率
    oProtectSet->set_kid4(setParam.Kid4);//速断电流斜率
    oProtectSet->set_kxb(setParam.Kxb2);//二次谐波制动系数
    oProtectSet->set_kxb3(setParam.Kxb3);//三次谐波
    oProtectSet->set_kxb5(setParam.Kxb5);//5次谐波制动系数
    
    //开关量参数
    Differential::SwitchPara *oSwitch = oitems.mutable_oswitch();
    oSwitch->set_ika((int)binarySwitch.iKA);
    oSwitch->set_ikb((int)binarySwitch.iKB);
    oSwitch->set_ikc((int)binarySwitch.iKC);
    oSwitch->set_ikd((int)binarySwitch.iKD);
    oSwitch->set_ike((int)binarySwitch.iKE);
    oSwitch->set_ikf((int)binarySwitch.iKF);
    oSwitch->set_ikg((int)binarySwitch.iKG);
    oSwitch->set_ikh((int)binarySwitch.iKH);
    oSwitch->set_iki((int)binarySwitch.iKI);
    oSwitch->set_ikj((int)binarySwitch.iKJ);
    oSwitch->set_ilogic((int)binarySwitch.iLogic);
    oSwitch->set_iout1((int)binarySwitch.iOut1);
    oSwitch->set_iout2((int)binarySwitch.iOut2);
    oSwitch->set_iout3((int)binarySwitch.iOut3);
    oSwitch->set_iout4((int)binarySwitch.iOut4);
    oSwitch->set_iout5((int)binarySwitch.iOut5);
    oSwitch->set_iout6((int)binarySwitch.iOut6);
    oSwitch->set_iout7((int)binarySwitch.iOut7);
    oSwitch->set_iout8((int)binarySwitch.iOut8);
    
    for (int i = 0; i<testItem.count; i++) {
        BD_DifferentialTestItemModel *item = (BD_DifferentialTestItemModel *)testItem[i];
        
        if (item.itemSelect) {//只有在选中的时候才下发数据到接口
            
            if (item.testItemParam.itemType == DifferTestItemType_QDCurrent) {
                Differential::testItem *QDCurrentItem = oitems.add_oitems();
                QDCurrentItem->set_itemtype(Differential::TestItem_type::QDCurrent);
                QDCurrentItem->mutable_oqdcurrent()->set_itemtype(Differential::TestItem_type::QDCurrent);
                QDCurrentItem->mutable_oqdcurrent()->set_iindex([item.testItemParam.iIndex intValue]);
                QDCurrentItem->mutable_oqdcurrent()->set_ir([item.testItemParam.Ir floatValue]);
                QDCurrentItem->mutable_oqdcurrent()->set_fup([item.testItemParam.fUp floatValue]);
                QDCurrentItem->mutable_oqdcurrent()->set_fdown([item.testItemParam.fDown floatValue]);
            }else if (item.testItemParam.itemType == DifferTestItemType_SDCurrent){
                Differential::testItem *SDCurrentItem = oitems.add_oitems();
                SDCurrentItem->set_itemtype(Differential::TestItem_type::SDCurrent);
                SDCurrentItem->mutable_oqdcurrent()->set_itemtype(Differential::TestItem_type::SDCurrent);
                SDCurrentItem->mutable_oqdcurrent()->set_iindex([item.testItemParam.iIndex intValue]);
                SDCurrentItem->mutable_oqdcurrent()->set_ir([item.testItemParam.Ir floatValue]);
                SDCurrentItem->mutable_oqdcurrent()->set_fup([item.testItemParam.fUp floatValue]);
                SDCurrentItem->mutable_oqdcurrent()->set_fdown([item.testItemParam.fDown floatValue]);
            } else if (item.testItemParam.itemType == DifferTestItemType_ZDRatio) {
                Differential::testItem *ZDRatioItem = oitems.add_oitems();
                ZDRatioItem->set_itemtype(Differential::TestItem_type::ZDRatio);
                ZDRatioItem->mutable_ozdratio()->set_itemtype(Differential::TestItem_type::ZDRatio);
                ZDRatioItem->mutable_ozdratio()->set_itypeindex([item.testItemParam.iTypeIndex intValue]);
                ZDRatioItem->mutable_ozdratio()->set_iindex([item.testItemParam.iIndex intValue]);
                ZDRatioItem->mutable_ozdratio()->set_ir([item.testItemParam.Ir floatValue]);
                ZDRatioItem->mutable_ozdratio()->set_fup([item.testItemParam.fUp floatValue]);
                ZDRatioItem->mutable_ozdratio()->set_fdown([item.testItemParam.fDown floatValue]);
                
            } else if (item.testItemParam.itemType == DifferTestItemType_HarmonicRation){
                Differential::testItem *harmItem = oitems.add_oitems();
                harmItem->set_itemtype(Differential::TestItem_type::HarmonicRation);
                harmItem->mutable_oharmnonicratio()->set_itemtype(Differential::TestItem_type::HarmonicRation);
                harmItem->mutable_oharmnonicratio()->set_iindex([item.testItemParam.iIndex intValue]);
                harmItem->mutable_oharmnonicratio()->set_id([item.testItemParam.Id floatValue]);
                harmItem->mutable_oharmnonicratio()->set_nham([item.testItemParam.nHarm intValue]);
                harmItem->mutable_oharmnonicratio()->set_fstart([item.testItemParam.searchStart floatValue]);
                harmItem->mutable_oharmnonicratio()->set_fend([item.testItemParam.searchEnd floatValue]);
            } else if (item.testItemParam.itemType == DifferTestItemType_ActionTime ) {
                Differential::testItem *actionTimeItem = oitems.add_oitems();
                actionTimeItem->set_itemtype(Differential::TestItem_type::ActionTime);
                actionTimeItem->mutable_oactiontime()->set_itemtype(Differential::TestItem_type::ActionTime);
                actionTimeItem->mutable_oactiontime()->set_iindex([item.testItemParam.iIndex intValue]);
                actionTimeItem->mutable_oactiontime()->set_id([item.testItemParam.Id floatValue]);
                actionTimeItem->mutable_oactiontime()->set_ir([item.testItemParam.Ir floatValue]);
            } else {
                
            }
            
        } else{
            DLog(@"未选中%@",item);
        }
        
    }
    //转字节流
    //计算对象大小
    int size = oitems.ByteSize();
    
    //开辟内存空间
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    //序列化到内存中
    oitems.SerializePartialToArray(pchar, size);
    
    @try {
        //创建客户端对象
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
        
        XmlRpcValue result;
        
        XmlRpcValue oValue(pchar,size);
        
        bool isSuccess = oClient.execute("PSUDifferTest",oValue,result);
        
        NSLog(@"isSuccess->:%d",isSuccess);
        
        
        oClient.close();
        return isSuccess;
        
    } @catch (NSException *exception) {
      DLog(@"differ抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {
        free(pchar);
    }

}

#pragma mark 谐波试验
-(bool)harmTestChange:(BD_HarmModel *)model
{
    //创建模型
    Harm::HarmAnalog harmAnalog;
    //设置开入量
    unsigned int tempBits = 0;
    
    for (NSInteger i = 0; i < model.switchModel.switchInArray.count; i++) {
        if ([model.switchModel.switchInArray[i] intValue]==1)
        {
            tempBits |= (1<<i);
        }
    }
    
    DLog(@"开入量:%zd", tempBits);
    harmAnalog.set_iinput(tempBits);
    
    //设置开出量
    tempBits = 0;
    for (NSInteger i = 0; i < model.switchModel.switchOutArray.count; i++) {
        if ([model.switchModel.switchOutArray[i] intValue]==1)
        {
            tempBits |= (1<<i);
        }
    }
    
    DLog(@"开出量:%zd", tempBits);
    harmAnalog.set_ioutput(tempBits);
    
    //设置是否自动
    bool isAuto = model.dataModel.isAuto;
    harmAnalog.set_bisauto(isAuto);
    
    //设置是否锁定
    bool isLock = model.isLock;
    harmAnalog.set_block(isLock);
    
    //设置开入逻辑
    harmAnalog.set_ilogic((int)model.switchModel.switchLogic);

    
    //创建直流模型
    if ([model.paramsModel.type isEqualToString:@"模拟"]) {
        /**------设置模拟参数-------*/
        //设置直流参数
        Harm::DCPara *oAnalogDC = harmAnalog.mutable_oanalogdc();
        [self.servicManager harmSetDCPara:oAnalogDC viewModel:model];
        //设置递变参数
        OutPutCommon::GradientPara *oGradientPara = harmAnalog.mutable_ogradientpara();
        [self.servicManager harmsetGradientPara:oGradientPara viewModel:model];
        //添加电压设置
        //遍历列表数据
        if (model.allDataArray.count==2) {
            [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:NO];
        } else if (model.allDataArray.count==4){
           [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:NO];
            [self.servicManager harmSetVolCurPara:model.allDataArray[2] curData:model.allDataArray[3] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:NO];
        }

        
    } else {
        /**------设置数字参数-------*/
        //设置直流参数
        Harm::DCPara *oDigitalDC = harmAnalog.mutable_odigitaldc();
        [self.servicManager harmSetDCPara:oDigitalDC viewModel:model];
        //设置递变参数
        OutPutCommon::GradientPara *oDigitalGradientPara = harmAnalog.mutable_odigitalgradientpara();
        [self.servicManager harmsetGradientPara:oDigitalGradientPara viewModel:model];
        //添加电压设置
        //遍历列表数据
        if (model.allDataArray.count==2) {
            [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:YES];
        } else if (model.allDataArray.count==4){
            [self.servicManager harmSetVolCurPara:model.allDataArray[0] curData:model.allDataArray[1] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:YES];
            [self.servicManager harmSetVolCurPara:model.allDataArray[2] curData:model.allDataArray[3] fre:model.dataModel.fre.floatValue passsagewayArr:model.passagewayArray harmAnalog:&harmAnalog isDigi:YES];
        }
    }
    
    DLog(@"%@", model.dataModel);
    
    int size = harmAnalog.ByteSize();
    
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    harmAnalog.SerializePartialToArray(pchar, size);
    
    @try {
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
        
        XmlRpcValue result;
        
        XmlRpcValue oValue(pchar,size);
        
        //发送数据方法
        bool isSuc = oClient.execute("PSUHarmTest",oValue,result);
        oClient.close();
        return isSuc;
        
    } @catch (NSException *exception) {
        
        DLog(@"harm抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
        
    } @finally {
        //释放
         free(pchar);
    }
    
}


-(bool)binarySetAction:(BD_BinaryInSetData *)binaryData{
    NSLog(@"values:%@",binaryData);
    
    //1.定义消息变量
    hqyBinaryInPackage::BinaryinSetting *oiTem = new hqyBinaryInPackage::BinaryinSetting;
    hqyBinaryInPackage::BinaryInInfo *oinfos;
    for (int i = 0; i<binaryData.binaryInfoList.count; i++) {
        oinfos = oiTem->add_obinaryinfolist();
        if (binaryData.binaryInfoList[i].isBlankNode) {
            oinfos->set_ntype(hqyBinaryInPackage::BinaryInType::BT_EmptyMode);
            
        } else {
            oinfos->set_ntype(hqyBinaryInPackage::BinaryInType::BT_SampleMode);
        }
        oinfos->set_fthreshold([binaryData.binaryInfoList[i].rolloverValue floatValue]);
       
    }
    oiTem->set_binarymode(binaryData.binaryStyle);
    oiTem->set_bitime(binaryData.bitime);
    
    
    int size = oiTem->ByteSize();
    
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    oiTem->SerializePartialToArray(pchar, size);
    
    @try {
        XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
        
        XmlRpcValue result;
        
        XmlRpcValue oValue(pchar,size);
        
        //发送数据方法 PSUManuTest (新方法名) PQTTestMethod(旧方法名)
        bool isSuc = oClient.execute("SetBinaryInSetting",oValue,result);
        oClient.close();
        return isSuc;
        
    } @catch (NSException *exception) {
        
    } @finally {
        free(pchar);
        free(oinfos);
    }

}
//获取开入量数据，点击获取的时候重新获取，数据
-(nullable BD_BinaryInSetData *)getBinaryInfo
{
    XmlRpcValue result;
    //XmlRpcValue oValue(pchar,size);
    char *pSzchar = new char;
    XmlRpcValue tempValue(pSzchar,1);
    XmlRpcValue oValue;
    oValue = tempValue;
    std::string str;
    
    XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
    free(pSzchar);
    if (oClient.execute("SetBinaryInSetting",oValue,result) == false)
    {
       oClient.close();
        return nil;
    }
    else
    {
     
        XmlRpcValue::BinaryData binarySetData = result;
        int len = (int)binarySetData.size();
        char* pChar =(char *)malloc(sizeof(char)*len);
        for(int i=0;i<binarySetData.size();i++)
        {
            pChar[i]= binarySetData.at(i);
        }
        
        hqyBinaryInPackage::BinaryinSetting oItem;
        if(! oItem.ParsePartialFromArray(pChar,len))
        {
            DLog(@"ParseFromString failed!")
        }
        
       int m_nMode=oItem.binarymode();
       int  m_nFDTime=oItem.bitime();
       int size = oItem.obinaryinfolist_size();
        NSMutableArray *binaryList = [[NSMutableArray alloc]init];
        for(int i=0;i<size;i++)
        {
            BD_BinaryInSettingModel *binaryInfo = [[BD_BinaryInSettingModel alloc]init];
            hqyBinaryInPackage::BinaryInInfo binaryPara = oItem.obinaryinfolist(i);
            if(binaryPara.ntype()==hqyBinaryInPackage::BT_EmptyMode)
            {
                binaryInfo.isBlankNode = YES;
            }
            else
            {
                binaryInfo.isBlankNode = NO;
            }
            binaryInfo.rolloverValue = [NSString stringWithFormat:@"%.3f", binaryPara.fthreshold()];
            [binaryList addObject:binaryInfo];
        }
        BD_BinaryInSetData *binaryData = [[BD_BinaryInSetData alloc]init];
        binaryData.binaryStyle = m_nMode;
        binaryData.bitime = m_nFDTime;
        binaryData.binaryInfoList = [binaryList copy];
        
        oClient.close();
        return binaryData;
        //close();
    }
    
}

//直流设置
-(bool)directCurrentSetActionIsStart:(bool)isStart dirCurrentValue:(float)dirCurrentValue{
   
    XmlRpcValue result;
    
    const char* ch = [[NSString stringWithFormat:@"%.3f",dirCurrentValue] UTF8String];
    int size = sizeof(ch);
    NSData *data = [NSData dataWithBytes:ch length:size];
    char *pchar = (char*)[data bytes];
    //float类型的数据必须转化为二进制串上传
    XmlRpcValue oValue(pchar,sizeof(char)*(int)[data length]);
  
    
    bool bSuccess = true;
    XmlRpcClient oClient(self.ip.UTF8String,(int)self.port);
    if (isStart) {
        
        if (oClient.execute("LockerDispStart",oValue,result) == false)
        {
            oClient.close();
            bSuccess = false;
        }
        else
        {
            oClient.close();
            bSuccess = true;
        }
        
    } else {
        if (oClient.execute("LockerDispStop",oValue,result) == false)
        {
            oClient.close();
            bSuccess = false;
        }
        else
        {
            oClient.close();
            bSuccess = true;
        }
    }
    
    return bSuccess;
    
}
@end
