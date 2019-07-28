//
//  BD_SequenceCaculateManager.h
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <iostream>
#include <complex>
#include <math.h>
using namespace std;
@class BD_ChannelModel;
@class BD_ChannelStrModel;
@interface BD_SequenceCaculateManager : NSObject
/*
 获取幅值大小
 **/
-(double)getAmplitude:(const std::complex<double>&)complexV;
/*
 获取相位大小
 **/
-(double)getAngle:(const std::complex<double>&)complexV;
/*
 获取线电压幅值
 **/
-(double)getASubBAmplitude:(BD_ChannelModel *)channel1 channel2:(BD_ChannelModel *)channel2;

/*
 获取线电压相位角度
 **/
-(double)getASubBAngle:(BD_ChannelModel *)channel1 channel2:(BD_ChannelModel *)channel2;


/*
 序分量---获取零序分量U0
 **/
-(BD_ChannelStrModel *)getZeroSeqValueFromchannel_A:(BD_ChannelModel *)channel_A channel_B:(BD_ChannelModel *)channel_B channel_C:(BD_ChannelModel *)channel_C;

/*
 序分量---获取正序分量U1
 **/
-(BD_ChannelStrModel *)getPositiveSeqValueFromchannel_A:(BD_ChannelModel *)channel_A channel_B:(BD_ChannelModel *)channel_B channel_C:(BD_ChannelModel *)channel_C;

/*
 序分量---获取负序分量U2
 **/
-(BD_ChannelStrModel *)getNegativeSeqValueFromchannel_A:(BD_ChannelModel *)channel_A channel_B:(BD_ChannelModel *)channel_B channel_C:(BD_ChannelModel *)channel_C;

@end
