//
//  BD_HarmWaveformView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/23.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmTableDataModel.h"

typedef NS_ENUM(NSUInteger, WaveformType) {
    WAVEFORM_S_V = 0,//模拟电压
    WAVEFORM_S_C,//模拟电流
    WAVEFORM_N_V,//数字电压
    WAVEFORM_N_C,//数字电流
    WAVEFORM_S_V1,//模拟电压1
    WAVEFORM_S_C1,//模拟电流1
    WAVEFORM_N_V1,//数字电压1
    WAVEFORM_N_C1,//数字电流1
    WAVEFORM_S_V2,//模拟电压2
    WAVEFORM_S_C2,//模拟电流2
    WAVEFORM_N_V2,//数字电压2
    WAVEFORM_N_C2//数字电流2
};

@interface BD_HarmWaveformView : UIView

-(instancetype)initWithFrame:(CGRect)frame type:(WaveformType)type;

/**绘制波形*/
-(void)drawWaveformLine;

/**刷新波形数据*/
-(void)refreshWaveformData;

/**数据模型*/
@property (nonatomic, weak) BD_HarmTableDataModel *tableModel;

/**通道数组*/
@property (nonatomic, weak) NSArray *channelArray;

/**直流数据数组*/
@property (nonatomic, strong) NSArray *dcDataArray;

/**频率*/
@property (nonatomic, strong) NSString *fre;

@end
