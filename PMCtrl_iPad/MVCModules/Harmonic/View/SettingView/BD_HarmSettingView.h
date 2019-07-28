//
//  BD_HarmSettingView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  侧边设置视图

#import <UIKit/UIKit.h>
#import "BD_HarmModel.h"

@protocol BD_HarmSettingViewDelegate<NSObject>
/**侧边设置按钮点击*/
-(void)settingButtonClick:(UIButton *)button;
/**切换谐波通道设置*/
-(void)changedType:(NSString *)type passageway:(NSString *)passageway;
@end

@interface BD_HarmSettingView : UIView

/**谐波模型*/
@property (nonatomic, weak) BD_HarmModel *harmModel;

@property (nonatomic,strong)NSArray<UIButton *> *settingViewBtnArr;
/**代理*/
@property (nonatomic, weak) id<BD_HarmSettingViewDelegate> delegate;

-(void)setupSubView;
/**设置测试结果*/
-(void)setResultData:( NSString * _Nullable )actionTime actionValue:(NSString * _Nullable)actionValue backTime:(NSString * _Nullable)backTime backValue:(NSString * _Nullable)backValue;
@end
