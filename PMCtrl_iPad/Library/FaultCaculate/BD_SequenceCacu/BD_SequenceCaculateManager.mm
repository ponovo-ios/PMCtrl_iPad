//
//  BD_SequenceCaculateManager.m
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SequenceCaculateManager.h"
#import "BD_ChannelModel.h"

@interface BD_SequenceCaculateManager()

@end

@implementation BD_SequenceCaculateManager
-(double)getAngle:(const std::complex<double> &)complexV{
    double PI = 3.1415926;
    if ( complexV.real() == 0  )
    {
        if ( complexV.imag() > 0 )
        {
            return 90;
        }
        else if (complexV.imag() < 0 )
        {
            return -90;
        }
        else
        {
            return 0;
        }
    }
    else if ( complexV.imag() == 0  )
    {
        if ( complexV.real() >= 0 )
        {
            return 0;
        }
        else if (complexV.real() < 0 )
        {
            return -180;
        }
    }
    else if ( complexV.real()  > 0 )
    {
        return atan( complexV.imag()/complexV.real()  )*180/PI;
    }
    return [self R180:atan(complexV.imag()/complexV.real() )*180/PI + 180];
}
-(double)getAmplitude:(const std::complex<double> &)complexV{
    return sqrt( complexV.imag()*complexV.imag() + complexV.real()*complexV.real() );
}
-(double)getASubBAngle:(BD_ChannelModel *)channel1 channel2:(BD_ChannelModel *)channel2{
    double PI = 3.1415926;
    std::complex<double> a1( channel1.amplitude*cos(channel1.phase*PI/180),channel1.amplitude*sin(channel1.phase*PI/180) );
    std::complex<double> b1( channel2.amplitude*cos(channel2.phase*PI/180), channel2.amplitude*sin(channel2.phase*PI/180) );
    std::complex<double> c1 = a1 - b1;
    return [self getAngle:c1];
}
-(double)getASubBAmplitude:(BD_ChannelModel *)channel1 channel2:(BD_ChannelModel *)channel2{
    double PI = 3.1415926;
    std::complex<double> a1( channel1.amplitude*cos(channel1.phase*PI/180),channel1.amplitude*sin(channel1.phase*PI/180) );
    std::complex<double> b1( channel2.amplitude*cos(channel2.phase*PI/180), channel2.amplitude*sin(channel2.phase*PI/180) );
    std::complex<double> c1 = a1 - b1;
    return  [self getAmplitude:c1];
}
-(BD_ChannelStrModel *)getZeroSeqValueFromchannel_A:(BD_ChannelModel *)channel_A channel_B:(BD_ChannelModel *)channel_B channel_C:(BD_ChannelModel *)channel_C{
    double PI = 3.1415926;
    std::complex<double> a1(channel_A.amplitude*cos(channel_A.phase*PI/180), channel_A.amplitude*sin( channel_A.phase*PI/180) );
    std::complex<double> b1(channel_B.amplitude*cos(channel_B.phase*PI/180), channel_B.amplitude*sin( channel_B.phase*PI/180) );
    std::complex<double> c1(channel_C.amplitude*cos(channel_C.phase*PI/180), channel_C.amplitude*sin( channel_C.phase*PI/180) );
    std::complex<double> result = (a1 + b1 + c1)/3.0;
    BD_ChannelStrModel *res = [[BD_ChannelStrModel alloc]init];
    res.amplitude = [NSString stringWithFormat:@"%.3f",[self getAmplitude:result]];
    res.phase = [NSString stringWithFormat:@"%.3f",[self getAngle:result]];
    return res;
}

-(BD_ChannelStrModel *)getPositiveSeqValueFromchannel_A:(BD_ChannelModel *)channel_A channel_B:(BD_ChannelModel *)channel_B channel_C:(BD_ChannelModel *)channel_C{
    double PI = 3.1415926;
    const  std::complex<double> alpha( cos( 120*PI/180), sin( 120*PI/180));
    
    std::complex<double> a1(channel_A.amplitude*cos(channel_A.phase*PI/180), channel_A.amplitude*sin( channel_A.phase*PI/180) );
    std::complex<double> b1(channel_B.amplitude*cos(channel_B.phase*PI/180), channel_B.amplitude*sin( channel_B.phase*PI/180) );
    std::complex<double> c1(channel_C.amplitude*cos(channel_C.phase*PI/180), channel_C.amplitude*sin( channel_C.phase*PI/180) );
    std::complex<double> result = (a1 + alpha*b1 + alpha*alpha*c1)/3.0;
    BD_ChannelStrModel *res = [[BD_ChannelStrModel alloc]init];
    res.amplitude = [NSString stringWithFormat:@"%.3f",[self getAmplitude:result]];
    res.phase = [NSString stringWithFormat:@"%.3f",[self getAngle:result]];
    return res;
}
-(BD_ChannelStrModel *)getNegativeSeqValueFromchannel_A:(BD_ChannelModel *)channel_A channel_B:(BD_ChannelModel *)channel_B channel_C:(BD_ChannelModel *)channel_C{
  
    double PI = 3.1415926;
    const  std::complex<double> alpha( cos( 120*PI/180), sin( 120*PI/180));
    std::complex<double> a1( channel_A.amplitude*cos( channel_A.phase*PI/180), channel_A.amplitude*sin( channel_A.phase*PI/180) );
    std::complex<double> b1( channel_B.amplitude*cos( channel_B.phase*PI/180), channel_B.amplitude*sin( channel_B.phase*PI/180) );
    std::complex<double> c1( channel_C.amplitude*cos( channel_C.phase*PI/180), channel_C.amplitude*sin( channel_C.phase*PI/180) );
    std::complex<double> result = (a1 + alpha*alpha*b1 + alpha*c1)/3.0;
    
    BD_ChannelStrModel *res = [[BD_ChannelStrModel alloc]init];
    res.amplitude = [NSString stringWithFormat:@"%.3f",[self getAmplitude:result]];
    res.phase = [NSString stringWithFormat:@"%.3f",[self getAngle:result]];
    return res;
}

-(double)roudVal:(double)val maxV:(double)maxV minV:(double)minV cycle:(double)cycle{
    while ( val > maxV )
    {
        val = val - cycle;
    }
    while ( val < minV )
    {
        val = val + cycle;
    }
    return val;
}

-(double)R180:(double)val{
    return [self roudVal:val maxV:180 minV:-180 cycle:360];
}

@end
