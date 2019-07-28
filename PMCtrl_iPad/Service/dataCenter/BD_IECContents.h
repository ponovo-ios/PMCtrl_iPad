//
//  BD_IECContents.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/8.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#ifndef BD_IECContents_h
#define BD_IECContents_h
//采集器输出
/**报文类型*/
#define IECControllorOutputParamArrs_MessType @[@"国网",@"南京新宁光电",@"采集器(许继)"]
/**采样率*/
#define IECControllorOutputParamArrs_SamplingRate @[@"4kHz",@"5kHz",@"8kHz",@"10kHz",@"12.8kHz"]
/**波特率*/
#define IECControllorOutputParamArrs_BaudRate @[@"2.5Mbps",@"5Mbps",@"10Mbps",@"2Mbps",@"4Mbps",@"6Mbps",@"8Mbps"]


//60044-7/8报文

/**报文类型*/
#define IEC60044ParamArrs_MessType @[@"南瑞12通道",@"国网22通道"]
/**采样率*/
#define IEC60044ParamArrs_SamplingRate @[@"4kHz",@"5kHz",@"8kHz",@"10kHz"]
/**波特率*/
#define IEC60044ParamArrs_BaudRate @[@"2.5Mbps",@"5Mbps",@"10Mbps"]
//ASDU数目
#define IEC60044ParamArrs_ASDUNUM @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]



#endif /* BD_IECContents_h */
