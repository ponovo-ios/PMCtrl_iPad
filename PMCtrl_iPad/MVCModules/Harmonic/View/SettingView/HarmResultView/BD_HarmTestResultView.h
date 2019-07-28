//
//  BD_HarmTestResultView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/19.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_HarmTestResultView : UIView
//设置动作时间 动作值 返回时间 返回值
-(void)setValues:( NSString * _Nullable )actionTime actionValue:(NSString * _Nullable)actionValue backTime:(NSString * _Nullable)backTime backValue:(NSString * _Nullable)backValue;
//根据变化方式设置返回时间和返回值是否有效 0 始值-终值 1 始值-终值-始值
-(void)setBackViewsShow:(int)autoChangeStyle;
@end
