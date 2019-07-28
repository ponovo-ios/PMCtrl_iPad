#include "myXmlrpcServerMethod.h"
#include<iostream>
#include "hqyPUDPara.pb.h"
#include "hqyManualResult.pb.h"//旧的手动返回probuf文件
#include "OutPutCommon.pb.h"//新的手动／状态序列 返回probuf文件

//---------OC--------------------------//
#import "BD_DifferentialTestResultModel.h"//
#import "BD_QuickTestResultModel.h"//
#import "BD_StateModel.h"//
#import "BD_TestResultModel.h"//手动和状态序列统一的返回结果模型
#import "BD_GPSDateModel.h"
using namespace std;
volatile extern int g_StartFlag;

//CommonResult(新方法) 服务端返回接口方法名  QuickCheckCom(旧方法名）
//DeviceInfo 解析过载方法名
#pragma mark - QuickCheckCom


ManualTest::ManualTest(XmlRpcServer* s):myXmlRpcServerMethod("CommonResult", s)
{

}

void ManualTest::execute(XmlRpcValue & params, XmlRpcValue& result)
{
    //解析参数
    XmlRpcValue::BinaryData ovalue = params[0];

    char* pChar =(char *)malloc(sizeof(char)*ovalue.size());

    for(int i=0;i<ovalue.size();i++)
    {

        pChar[i]= ovalue.at(i);
    }

    //-----------2018/1/19日之前接口-------------------------------------//
    //实例化对象

    //    hqyManualResult::ResultInfo oresult;
    //
    //    bool bRet = oresult.ParsePartialFromArray(pChar, (int)ovalue.size());
    //
    //    if (bRet) {
    //        int nsize = oresult.oitem_size(); //oitem的size
    //
    //
    ///**
    //服务端以数组的形式返回数据，每次返回都是在原来数据的基础继续往数组中添加内容，他们每动作一次，就可能有多个状态发生，比如切换开入量动作，就需要先有状态3然后是状态4，可能两个状态同时发生，也可能有先后顺序，所以，不能单纯取最后一个对象，必须将数组进行循环，判断，然后，每次循环到的内容进行页面时的改变，只要循环判断，最终的状态就是期望的状态
    // */
    //        NSMutableArray *quickresult = [[NSMutableArray alloc]init];
    //
    //        for (int i = kSingleton.quickResult_lastCount; i<nsize; i++) {
    ////            hqyManualResult::Item oitem = oresult.oitem(nsize-1); //取最后一项
    //            hqyManualResult::Item oitem = oresult.oitem(i);
    //
    //
    //
    //            int nindex = oitem.nindex(); //类型
    //
    //            int oactivetype = oitem.oactivetype();
    //
    //            int nBinstate = oitem.nbinstate();     //开入量
    //
    //            int nbinall = oitem.nbinallstate(); //开入量所有状态值
    //            //时间 Utc时间,Utc是hqyGooseCommon::UtcTime中的一个结构体
    //            BD_UtcTime *time = [[BD_UtcTime alloc]initWithminute:oitem.time().minute() second:oitem.time().second() millisecond:oitem.time().millisecond()];
    //
    //            BD_QuickTestResultModel *quick = [[BD_QuickTestResultModel alloc]initWithnindex:nindex oactivetype:oactivetype nBinstate:nBinstate nbinall:nbinall time:time];
    //
    //            [quickresult addObject:quick];
    ////            NSDictionary *dict = @{
    ////                                   @"nindex":@(nindex),
    ////                                   @"oactivetype":@(oactivetype),
    ////                                   @"nBinstate":@(nBinstate),
    ////                                   @"nbinall":@(nbinall),
    ////                                   @"ntime":@(ntime),
    ////                                   };
    //
    //        }
    //
    //        kSingleton.quickResult_lastCount = nsize-1;
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"manual" object:quickresult];
    //    }
    //------------------------------------------------------------------------//
    /*-----------------2018／1/19日新接口--------------------------------*/
    //返回结果是个数组，可以有多个状态同时返回，比如开关量动作，就属于状态切换也属于开入变位

    OutPutCommon::result oresult;

    bool bRet = oresult.ParsePartialFromArray(pChar, (int)ovalue.size());
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    if (bRet) {

        int resultSize = oresult.oreslult_size();
        for (int i = 0; i<resultSize; i++) {
            OutPutCommon::resultItem oitem = oresult.oreslult(i);

            int ntype = oitem.ntype();//结果类型 1：开始实验    2：实验结束    3：状态切换    4：开入变位 5: 递变
            int nSource = oitem.nsource();//当type为开入变位，为变位的开入通道，bit9~bit0对应开入9~0
            //当type为状态切换时，为状态切换触发条件，
            //bit12:手动触发    bit11：时间触发    bit10：GPS触发
            //bit9~bit0:对应开关量9~0
            //nSource可以判断是那个通道进行了动作变化，需要单独判断
            int nSec = oitem.nsec();//产生结果的时间秒值
            int nNanoSec = oitem.nnanosec(); //产生结果的时间纳秒值
            int nInput = oitem.ninput(); //产生结果时开入量的值
            int nGooseValue = oitem.ngoosevalue();
            int ncurrentIndex = oitem.currentindex(); //当前状态索引号
            int nObjective = oitem.nobjective();//要跳转的状态索引号
            int nStep = oitem.nstep();//递变当前执行的步数

            BD_TestResultModel *result = [[BD_TestResultModel alloc]initWithnType:ntype nSource:nSource nSec:nSec nNanoSec:nNanoSec nInput:nInput nGooseValue:nGooseValue currentIndex:ncurrentIndex nObjective:nObjective nStep:nStep];
            [resultArr addObject:result];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           [kNotificationCenter postNotificationName:BD_ManualTestFromServiceDataNoti object:resultArr];
        });
       

    }
    free(pChar);
    pChar = NULL;
}

#pragma mark - StateSequence
StateSequence::StateSequence(XmlRpcServer* s):myXmlRpcServerMethod("StateSequence", s)
{}

void StateSequence::execute(XmlRpcValue & params, XmlRpcValue& result)
{
    
    NSLog(@"=================");

    //客户端传过来的数据
    XmlRpcValue::BinaryData ovalue = params[0];
    
//    NSLog(@"ovalue.size--%lu",ovalue.size());

    
    char* pChar =(char *)malloc(sizeof(char)*ovalue.size());//分配内存空间，用一个指针指向一个内存区域
    
    for(int i=0;i<ovalue.size();i++)
    {
        pChar[i]= ovalue.at(i);
    }
    /*-------------2018年1月19日前接口----------------
    //实例化对象
    hqyPudPara::stateResult oresult;
    
    //反序列化
    bool bRet = oresult.ParsePartialFromArray(pChar, (int)ovalue.size());
    
    free(pChar);
    
    if (bRet) {
        
        int nsize = oresult.oitem_size(); //oitem的size
        
        NSMutableArray *stateArr = [[NSMutableArray alloc]init];
        for (int i=kSingleton.stateResult_lastCount; i<nsize; i++) {
            hqyPudPara::StateResultItem oitem = oresult.oitem(i); //取最后一项
            
            int nindex = oitem.nindex();
            
            int secondtime = oitem.secondtime(); //时间
            
            int nstime = oitem.nstime();           //时间
            
            int nBinstate = oitem.nbinstate();     //开入量
            
            int otype = oitem.oactivetype();       //当前状态类型
            
            int ncur = oitem.ncurrentstateindex(); //当前状态序列号
            
            BD_StateModel *stateModel = [[BD_StateModel alloc]initWithnindex:nindex secondtime:secondtime nstime:nstime oactivetype:otype nBinstate:nBinstate ncurrentstateIndex:ncur];
            [stateArr addObject:stateModel];
//            
//            NSDictionary *dict = @{
//                                   @"nindex":@(nindex),
//                                   @"secondtime":@(secondtime),
//                                   @"nstime":@(nstime),
//                                   @"nBinstate":@(nBinstate),
//                                   @"otype":@(otype),
//                                   @"ncur":@(ncur),
//                                   };
        }
     
        kSingleton.stateResult_lastCount = nsize-1;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stateSequence" object:stateArr];
    }
*/
    OutPutCommon::result oresult;
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    bool bRet = oresult.ParsePartialFromArray(pChar, (int)ovalue.size());
    
    if (bRet) {
        int resultSize = oresult.oreslult_size();
        for (int i = 0; i<resultSize; i++) {
            OutPutCommon::resultItem oitem = oresult.oreslult(i);
        
            int ntype = oitem.ntype();//结果类型 1：开始实验    2：实验结束    3：状态切换    4：开入变位 5: 递变
            int nSource = oitem.nsource();//当type为开入变位，为变位的开入通道，bit9~bit0对应开入9~0
            //当type为状态切换时，为状态切换触发条件，
            //bit12:手动触发    bit11：时间触发    bit10：GPS触发
            //bit9~bit0:对应开关量9~0
            int nSec = oitem.nsec();//产生结果的时间秒值
            int nNanoSec = oitem.nnanosec(); //产生结果的时间纳秒值
            int nInput = oitem.ninput(); //产生结果时开入量的值
            int nGooseValue = oitem.ngoosevalue();
            int currentIndex = oitem.currentindex(); //当前状态索引号
            int nObjective = oitem.nobjective();//要跳转的状态索引号
            int nStep = oitem.nstep();//递变当前执行的步数
            
            BD_TestResultModel *result = [[BD_TestResultModel alloc]initWithnType:ntype nSource:nSource nSec:nSec nNanoSec:nNanoSec nInput:nInput nGooseValue:nGooseValue currentIndex:currentIndex nObjective:nObjective nStep:nStep];
            [resultArr addObject:result];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           [kNotificationCenter postNotificationName:BD_StateTestFromServiceDataNoti object:resultArr userInfo:nil];
        });
        
    }
}

#pragma mark - DifferResult
DifferResult::DifferResult(XmlRpcServer* s):myXmlRpcServerMethod("DifferResult", s)
{}

void DifferResult::execute(XmlRpcValue & params, XmlRpcValue& result)
{
    
    NSLog(@"=================");
    
    //客户端传过来的数据
    XmlRpcValue::BinaryData ovalue = params[0];
    
    //    NSLog(@"ovalue.size--%lu",ovalue.size());
    
    char* pChar =(char *)malloc(sizeof(char)*ovalue.size());
    
    for(int i=0;i<ovalue.size();i++)
    {
        pChar[i]= ovalue.at(i);
    }
    
    //实例化对象
    Differential::testItem_Result itemResult;
    
    //反序列化
    bool bRet = itemResult.ParsePartialFromArray(pChar, (int)ovalue.size());
    
    free(pChar);
    
   
    
    if (bRet) {
        
        BD_DifferentialTestResult *testResult = [[BD_DifferentialTestResult alloc] init];
    
        Differential::TestItem_type itemtype = itemResult.itemtype();//测试结果类型
        
        Differential::TestItem_QDCurrent_Result currentResult = itemResult.oqdres();
        
        Differential::TestItem_ZDRatio_Result ratioResult = itemResult.ozdres();
        Differential::HarmonicRatio_Result harmonicratioResult = itemResult.oharmres();
        Differential::TestItem_ActionTime_Result actiontimeResult = itemResult.oactionres();
  
        testResult.itemType = (DifferTestItemType)itemtype;
        
        if (itemtype == Differential::QDCurrent || itemtype == Differential::SDCurrent) {
            //构建启动速断电流
            
            BD_DifferentialChanel *Ia = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ia().famptitude() fphase:currentResult.basic().ia().fphase()];
            BD_DifferentialChanel *Ib = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ib().famptitude() fphase:currentResult.basic().ib().fphase()];
            BD_DifferentialChanel *Ic = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ic().famptitude() fphase:currentResult.basic().ic().fphase()];
            BD_DifferentialChanel *Iap = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().iap().famptitude() fphase:currentResult.basic().iap().fphase()];
            BD_DifferentialChanel *Ibp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ibp().famptitude() fphase:currentResult.basic().ibp().fphase()];
            BD_DifferentialChanel *Icp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().icp().famptitude() fphase:currentResult.basic().icp().fphase()];
            
            
            BD_DifferentialBasicResultItem *basic = [[BD_DifferentialBasicResultItem alloc]initWithIa:Ia Ib:Ib Ic:Ic Iap:Iap Ibp:Ibp Icp:Icp];
            
            BD_DifferentialTestItem_QDCurrent *qdcurrent = [[BD_DifferentialTestItem_QDCurrent alloc] initWithitemType:(DifferTestItemType)currentResult.itemtype() iIndex:currentResult.iindex() basic:basic Id:currentResult.id() bEnd:currentResult.bend() nibinstate:currentResult.nibinstate()];
            
            testResult.oQdcurrent = qdcurrent;
             [[NSNotificationCenter defaultCenter] postNotificationName:BD_DifferTestResultNoti object:testResult];
            
        } else if (itemtype == Differential::ZDRatio){
            //构建比率制动
            BD_DifferentialChanel *Ia = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ia().famptitude() fphase:ratioResult.basic().ia().fphase()];
            BD_DifferentialChanel *Ib = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ib().famptitude() fphase:ratioResult.basic().ib().fphase()];
            BD_DifferentialChanel *Ic = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ic().famptitude() fphase:ratioResult.basic().ic().fphase()];
            BD_DifferentialChanel *Iap = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().iap().famptitude() fphase:ratioResult.basic().iap().fphase()];
            BD_DifferentialChanel *Ibp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ibp().famptitude() fphase:ratioResult.basic().ibp().fphase()];
            BD_DifferentialChanel *Icp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().icp().famptitude() fphase:ratioResult.basic().icp().fphase()];
            
            
            BD_DifferentialBasicResultItem *basic = [[BD_DifferentialBasicResultItem alloc]initWithIa:Ia Ib:Ib Ic:Ic Iap:Iap Ibp:Ibp Icp:Icp];
            
            BD_DifferentialTestItem_ZDRatio * zdratio = [[BD_DifferentialTestItem_ZDRatio alloc]initWithitemType:(DifferTestItemType)ratioResult.itemtype() iTypeIndex:ratioResult.itypeindex() iIndex:ratioResult.iindex() basic:basic Id:ratioResult.id() bEnd:ratioResult.bend() nibinstate:ratioResult.nibinstate()];
            
            testResult.oZDRatio = zdratio;
             [[NSNotificationCenter defaultCenter] postNotificationName:BD_DifferTestResultNoti object:testResult];
        } else if (itemtype == Differential::ActionTime){
            //构建动作时间返回结果
            
            BD_DifferentialChanel *Ia = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ia().famptitude() fphase:actiontimeResult.basic().ia().fphase()];
            BD_DifferentialChanel *Ib = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ib().famptitude() fphase:actiontimeResult.basic().ib().fphase()];
            BD_DifferentialChanel *Ic = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ic().famptitude() fphase:actiontimeResult.basic().ic().fphase()];
            BD_DifferentialChanel *Iap = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().iap().famptitude() fphase:actiontimeResult.basic().iap().fphase()];
            BD_DifferentialChanel *Ibp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ibp().famptitude() fphase:actiontimeResult.basic().ibp().fphase()];
            BD_DifferentialChanel *Icp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().icp().famptitude() fphase:actiontimeResult.basic().icp().fphase()];
            
            
            BD_DifferentialBasicResultItem *basic = [[BD_DifferentialBasicResultItem alloc]initWithIa:Ia Ib:Ib Ic:Ic Iap:Iap Ibp:Ibp Icp:Icp];
            
            BD_DifferentialTestItem_ActionTime * actiontime = [[BD_DifferentialTestItem_ActionTime alloc]initWithitemType:(DifferTestItemType)actiontimeResult.itemtype() iIndex:actiontimeResult.iindex() basic:basic fId:actiontimeResult.fid() fTime:actiontimeResult.ftime() bEnd:actiontimeResult.bend() nibinstate:actiontimeResult.nibinstate()];
            testResult.oActionTime = actiontime;
             [[NSNotificationCenter defaultCenter] postNotificationName:BD_DifferTestResultNoti object:testResult];
        } else if (itemtype == Differential::HarmonicRation){
            //构建谐波制动返回结果
            
            BD_DifferentialChanel *Ia = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ia().famptitude() fphase:harmonicratioResult.basic().ia().fphase()];
            BD_DifferentialChanel *Ib = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ib().famptitude() fphase:harmonicratioResult.basic().ib().fphase()];
            BD_DifferentialChanel *Ic = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ic().famptitude() fphase:harmonicratioResult.basic().ic().fphase()];
            BD_DifferentialChanel *Iap = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().iap().famptitude() fphase:harmonicratioResult.basic().iap().fphase()];
            BD_DifferentialChanel *Ibp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().ibp().famptitude() fphase:harmonicratioResult.basic().ibp().fphase()];
            BD_DifferentialChanel *Icp = [[BD_DifferentialChanel alloc]initWithfamptitude:currentResult.basic().icp().famptitude() fphase:harmonicratioResult.basic().icp().fphase()];
            
            
            BD_DifferentialBasicResultItem *basic = [[BD_DifferentialBasicResultItem alloc]initWithIa:Ia Ib:Ib Ic:Ic Iap:Iap Ibp:Ibp Icp:Icp];
            
            BD_DifferentialHarmonicRatio * harmoicRatio = [[BD_DifferentialHarmonicRatio alloc]initWithitemType:(DifferTestItemType)harmonicratioResult.itemtype() iIndex:harmonicratioResult.iindex() basic:basic Ir:harmonicratioResult.ir() K:harmonicratioResult.k() bEnd:harmonicratioResult.bend() nibinstate:harmonicratioResult.nibinstate()];
            
            
            testResult.oHarmnonicRatio = harmoicRatio;
           
            [[NSNotificationCenter defaultCenter] postNotificationName:BD_DifferTestResultNoti object:testResult];
           
            
        }
        
       
        
    }
    
    
}



#pragma mark-ReadGPSMethod
ReadGPSMethod::ReadGPSMethod( XmlRpcServer* s ):myXmlRpcServerMethod("RealTime", s)
{
    
}

void ReadGPSMethod::execute( XmlRpcValue & params, XmlRpcValue& result )
{
    
    
    
    XmlRpcValue oValue;
    XmlRpcValue::BinaryData ovalue = params[0];
    int len = (int)ovalue.size();
    char* pChar =(char *)malloc(sizeof(char)*len);
    for(int i=0;i<ovalue.size();i++)
    {
        pChar[i]= ovalue.at(i);
    }
    
    OutPutCommon::gpstime oiTem;
    //otime.set_nsecond(nS);
    //otime.set_nnanosec(nNaS);
    if(! oiTem.ParsePartialFromArray(pChar,len))
    {
        NSLog(@"ParseFromString failed!");
    }
    
    
    int nSecond = oiTem.nsecond();//秒
    int nNanoSec = oiTem.nnanosec();//纳秒
    
    BD_GPSDateModel *gpsDate = [[BD_GPSDateModel alloc]init];
    gpsDate.nSecond  = nSecond;
    gpsDate.nNanoSec = nNanoSec;
    dispatch_async(dispatch_get_main_queue(), ^{
      [kNotificationCenter postNotificationName:BD_GPSRealTimeNoti object:gpsDate];
    });
    
    
    free(pChar);
    pChar = NULL;
    
}

#pragma mark-ReadDeviceinfoMethod
ReadDeviceinfoMethod::ReadDeviceinfoMethod( XmlRpcServer* s ):myXmlRpcServerMethod("DeviceInfo", s)
{
    
}

void ReadDeviceinfoMethod::execute( XmlRpcValue & params, XmlRpcValue& result )
{
    
    XmlRpcValue oValue;
    XmlRpcValue::BinaryData ovalue = params[0];
    int len = (int)ovalue.size();
    char* pChar =(char *)malloc(sizeof(char)*len);
    for(int i=0;i<ovalue.size();i++)
    {
        pChar[i]= ovalue.at(i);
    }
    
    OutPutCommon::deviceinfo oiTem;
    
    if(! oiTem.ParsePartialFromArray(pChar,len))
    {
      
        NSLog(@"ParseFromString failed!");
    }
    
    
    int nCurrentInfo = oiTem.ncurrentinfo();
    int nVoltInfo = oiTem.nvoltinfo();
    

    dispatch_async(dispatch_get_main_queue(), ^{
         [kNotificationCenter postNotificationName:BD_ReadDeviceInfoNoti object:@{@"currentInfo":@(nCurrentInfo),@"VolInfo":@(nVoltInfo)}];
    });
    free(pChar);
    pChar = NULL;
    
}


