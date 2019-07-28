//
//  BD_DeviceInfoService.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DeviceInfoService.h"
#import "OCCenter.h"
#import "XmlRpc.h"
#import "myXmlrpcServer.h"
#import "hqyDeviceConfig.pb.h"
#import "BD_SysParaModel.h"
#import "manuTest.pb.h"




#include <iostream>
using namespace std;

@interface BD_DeviceInfoService()
{
    NSInteger disConnectCount;
}

@end


@implementation BD_DeviceInfoService

+(instancetype)shared{
    static BD_DeviceInfoService *instence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[BD_DeviceInfoService alloc] init];
        
    });
    return instence;
}

#pragma mark - 发送芯跳信息，判断是否连接正常
- (bool)sendHeartInfo
{
    XmlRpcValue result;
    char buf = NULL;
    bool b_success = true;
  
    @try {
    
       XmlRpcClient oClient([OCCenter shareCenter].ip.UTF8String,(int)[OCCenter shareCenter].port);
        XmlRpcValue oValue (&buf,0);
        if (oClient.execute("Heart",oValue,result) == false) {
            b_success = false;
            //如果心跳发送失败，表示连接失败，通知辅助直流关闭指示灯 ,通知页面停止试验（非老化试验）
            if (disConnectCount==0) {
                 [kNotificationCenter postNotificationName:BD_NewWordDisconnect object:nil];
                disConnectCount++;
            }
          
            
        } else {
            b_success = true;
            disConnectCount = 0;
        }
        oClient.setKeepOpen();//一直处于长链接，不再是监控
        oClient.close();//heartClient一直持有，每次请求后台都要用heartClient,不需要关闭了
        
        return b_success;
        
    } @catch (NSException *exception) {
        DLog(@"抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {
        
    }
    
}

-(bool)readDevicePara:(complete)complete{
    //pzh
    //1.定义消息变量
    ManuTestPara::TestItem oiTem;
    
    const char* ocmd = "ReadCompensation";
    XmlRpcValue result = new XmlRpcValue;
    bool b_buf = false;
    bool bSuccess = true;
    
    int size = oiTem.ByteSize();
    
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    oiTem.SerializePartialToArray(pchar, size);
    
    @try {
         XmlRpcClient oClient([OCCenter shareCenter].ip.UTF8String,(int)[OCCenter shareCenter].port);
        
        XmlRpcValue result;
        
        XmlRpcValue oValue(pchar,size);
        
        if(oClient.execute(ocmd,oValue,result) == false)
        {
            oClient.close();
            bSuccess = false;
            complete(nil,bSuccess);
        }else
        {
            oClient.close();
            if(result.valid())
            {
                XmlRpcValue::Type nType = result.getType();
                if(nType == XmlRpcValue::TypeBase64)
                {
                    XmlRpcValue::BinaryData bindata = result;
                    int nSize = bindata.size();
                    char * pChar = (char *)malloc(sizeof(char)*nSize);
                    
                    for(int i=0;i<nSize;i++)
                    {
                        pChar[i] = bindata.at(i);
                    }
                    
                    hqyDeviceConfig::device deviceSetting;
                    bool b = deviceSetting.ParseFromArray(pChar,nSize);//将接收到的字符串转换为protobuf结构
                    
                    if(b)
                    {
                        BD_DeviceChanelDesc *chanelDesc = [[BD_DeviceChanelDesc alloc]init];
                        //
                        chanelDesc.analogCurrentMaxChanel = deviceSetting.mutable_ochaneldesc()->analogcurrentmaxchanel();
                        //
                        chanelDesc.analogVoltMaxChanel = deviceSetting.mutable_ochaneldesc()->analogvoltmaxchanel();
                        //电压范围
                        chanelDesc.currentMax = deviceSetting.mutable_ochaneldesc()->fanalogcurrentmax();
                        //电流范围
                        chanelDesc.voltageMax = deviceSetting.mutable_ochaneldesc()->fanalogvoltmax();
                        //                    Sys.fDcIMax = Sys.fAcIMax/2;/* deviceSetting.mutable_ochaneldesc()->fidcmax()*/;
                        //                    Sys.fDcVMax = Sys.fAcVMax*G2/*deviceSetting.mutable_ochaneldesc()->fudcmax()*/; //∏®÷˙÷±¡˜
                        chanelDesc.UDCMax = deviceSetting.mutable_ochaneldesc()->fudcmax();
                        
                        if ([BD_PMCtrlSingleton shared].deviceType == BDDeviceType_Digit || [BD_PMCtrlSingleton shared].deviceType == BDDeviceType_ImitateDigit)
                        {
                            chanelDesc.analogVoltMaxChanel = 12;
                            chanelDesc.analogCurrentMaxChanel = 12;
                        }
                        
                        
                        bSuccess = true;
                        complete(chanelDesc,bSuccess);
                    }
                    else
                    {
                        bSuccess = false;
                        complete(nil,bSuccess);
                    }
                    free(pChar);
                }
            }
            else
            {
                bSuccess = false;
                complete(nil,bSuccess);
            }
        }
        
        ocmd = NULL;
        return bSuccess;
        
        
    } @catch (NSException *exception) {
        DLog(@"抛出异常：%@ -- %@ -- %@", exception.name, exception.reason, exception.userInfo);
    } @finally {
        free(pchar);
    }
    

}

-(void)startTimer{
    [_timer setFireDate:[NSDate distantPast]];
}
-(void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
    
}

-(void)createTimer{
    _timer  = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(threadSendHeartInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)cancelTimer{
    [_timer invalidate];
    _timer = nil;
}

-(void)threadSendHeartInfo{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        bool state = [self sendHeartInfo];
        dispatch_async(dispatch_get_main_queue(), ^{
             [kNotificationCenter postNotificationName:BD_RealHeartStateNoti object:@(state) userInfo:nil];
        });
       
    });
}

@end
