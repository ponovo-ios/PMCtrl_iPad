//
//  BD_HarmWaveformSelView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WaveformLeftType) {
    LIFT_S_V = 0,//模拟电压
    LIFT_S_C,//模拟电流
    LIFT_N_V,//数字电压
    LIFT_N_C,//数字电流
    LIFT_S_V1,//模拟电压1
    LIFT_S_C1,//模拟电流1
    LIFT_N_V1,//数字电压1
    LIFT_N_C1,//数字电流1
    LIFT_S_V2,//模拟电压2
    LIFT_S_C2,//模拟电流2
    LIFT_N_V2,//数字电压2
    LIFT_N_C2//数字电流2
};

@protocol BD_HarmWaveformSelViewDelegate <NSObject>

-(void)waveformDidChangeWith:(UIButton *)button;

@end

@interface BD_HarmWaveformSelView : UIView

/**代理*/
@property (nonatomic, weak) id<BD_HarmWaveformSelViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame type:(WaveformLeftType)type;


@end
